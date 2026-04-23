# MAPF Quick Test with Source MD5 Cache
# - Calculates source code MD5 recursively
# - If source MD5 was already tested, uses cached result
# - Records source MD5 in scores.txt

$PROJ_DIR = "C:\gitcloud\auto-lorr-new\lorr-code"
$SRC_DIR = "$PROJ_DIR\src"
$LIFELONG = "$PROJ_DIR\build\lifelong.exe"
$OUTPUT_BASE = "C:\gitcloud\auto-lorr-new\test-script\round"
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
    Write-Host "Found cached result from round $roundName - using cached scores."
    Get-Content "$($cached.FullName)\scores.txt"
    exit 0
}

$ROUND = 1
while (Test-Path "$OUTPUT_BASE\round$ROUND") { $ROUND++ }
$OUTPUT_DIR = "$OUTPUT_BASE\round$ROUND"
New-Item -ItemType Directory -Path $OUTPUT_DIR -Force | Out-Null

Write-Host "MAPF Quick Test (round$ROUND) - MD5: $MD5"

$maps = @(
    @{name="random"; dir="random.domain"; file="random-example_400.json"; steps=200},
    @{name="bos"; dir="city.domain"; file="bos-example_600.json"; steps=200},
    @{name="room"; dir="room.domain"; file="room-example_150.json"; steps=200},
    @{name="maze"; dir="maze.domain"; file="maze-example_40.json"; steps=200},
    @{name="fulfill"; dir="warehouse.domain"; file="fulfill-example_2500.json"; steps=200},
    @{name="orz"; dir="game.domain"; file="orz-example_1800.json"; steps=200},
    @{name="iron"; dir="iron_harvest.domain"; file="iron-example_10000.json"; steps=200}
)

foreach ($map in $maps) {
    $oldLoc = Get-Location
    Set-Location "$PROBLEMS\$($map.dir)"
    & $LIFELONG -i $map.file -s $map.steps -o "$OUTPUT_DIR\$($map.name).json" *> $null
    Set-Location $oldLoc
}

Set-Location $SCRIPT_DIR

$parsePy = "$SCRIPT_DIR\parse_round.py"
& python $parsePy $OUTPUT_DIR

$scoresFile = "$OUTPUT_DIR\scores.txt"
$md5Line = "MD5: $MD5"
if (-not (Select-String -Path $scoresFile -Pattern "^MD5:" -Quiet)) {
    Add-Content $scoresFile ""
    Add-Content $scoresFile $md5Line
}

Write-Host "Done!"
