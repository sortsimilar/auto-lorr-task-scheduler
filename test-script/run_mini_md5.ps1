# MAPF Mini Test with Source MD5 Cache (Python MD5)
# Tests random + fulfill maps, saves to round_mini/

$PROJ_DIR = "C:\gitcloud\auto-lorr-new\lorr-code"
$SRC_DIR = "$PROJ_DIR\src"
$LIFELONG = "$PROJ_DIR\build\lifelong.exe"
$OUTPUT_BASE = "C:\gitcloud\auto-lorr-new\test-script\round_mini"
$PROBLEMS = "$PROJ_DIR\example_problems"
$SCRIPT_DIR = "C:\gitcloud\auto-lorr-new\test-script"

$env:PATH = "C:\msys64\ucrt64\bin;C:\msys64\usr\bin;$env:PATH"

if (-not (Test-Path $LIFELONG)) {
    Write-Host "Build not found!"
    exit 1
}

$origDir = $PWD
Set-Location $SRC_DIR
$MD5_OUTPUT = & python -c @"
import hashlib, os
files = []
for root, dirs, filenames in os.walk('.'):
    for f in filenames:
        if not f.endswith('.md'):
            files.append(os.path.join(root, f))
files.sort()
md5 = hashlib.md5()
for fp in files:
    with open(fp, 'rb') as fh: md5.update(fh.read())
print(md5.hexdigest().upper())
"@
Set-Location $origDir
$MD5 = $MD5_OUTPUT.Trim()
Write-Host "Source MD5: $MD5"

$cached = Get-ChildItem "$OUTPUT_BASE\round*" -Directory -ErrorAction SilentlyContinue | Where-Object {
    $content = Get-Content "$($_.FullName)\scores.txt" -Raw -ErrorAction SilentlyContinue
    $content -match "MD5: $MD5"
} | Select-Object -First 1

if ($cached) {
    $roundName = $cached.Name -replace 'round', ''
    Write-Host "Cached: Round $roundName (src MD5: $MD5)"
    Get-Content "$($cached.FullName)\scores.txt"
    exit 0
}

$ROUND = 1
while (Test-Path "$OUTPUT_BASE\round$ROUND") { $ROUND++ }
$OUTPUT_DIR = "$OUTPUT_BASE\round$ROUND"
New-Item -ItemType Directory -Path $OUTPUT_DIR -Force | Out-Null

Write-Host "Round $ROUND - Computing..."

# Test random
Set-Location "$PROBLEMS\random.domain"
$tmpOut = "$env:TEMP\lifelong_random_$PID.tmp"
$proc = Start-Process -FilePath $LIFELONG -ArgumentList "-i `"random-example_400.json`" -s 200 -o `"$OUTPUT_DIR\random.json`"" -PassThru -NoNewWindow -RedirectStandardOutput $tmpOut
$proc.WaitForExit()
if (Test-Path "$OUTPUT_DIR\random.json") { Write-Host "random: OK" }
else { Write-Host "random: FAIL" }
Remove-Item $tmpOut -ErrorAction SilentlyContinue

# Test fulfill
Set-Location "$PROBLEMS\warehouse.domain"
$tmpOut = "$env:TEMP\lifelong_fulfill_$PID.tmp"
$proc = Start-Process -FilePath $LIFELONG -ArgumentList "-i `"fulfill-example_2500.json`" -s 200 -o `"$OUTPUT_DIR\fulfill.json`"" -PassThru -NoNewWindow -RedirectStandardOutput $tmpOut
$proc.WaitForExit()
if (Test-Path "$OUTPUT_DIR\fulfill.json") { Write-Host "fulfill: OK" }
else { Write-Host "fulfill: FAIL" }
Remove-Item $tmpOut -ErrorAction SilentlyContinue

Set-Location $SCRIPT_DIR
python parse_round.py $OUTPUT_DIR

$scoresFile = "$OUTPUT_DIR\scores.txt"
if (-not (Select-String -Path $scoresFile -Pattern "^# MD5:" -Quiet)) {
    Add-Content $scoresFile ""
    Add-Content $scoresFile "MD5: $MD5"
}

Write-Host "Done!"
