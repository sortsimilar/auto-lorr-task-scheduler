# MAPF Mini Variance Test (no MD5 cache check)
# - Tests random + fulfill
# - Standard steps (300 + 1000)
# - No MD5 cache check (always runs), but writes MD5 to scores.txt
$PROJ_DIR = "C:\Users\Administrator\Desktop\test-studio-mapf\LORR26_842072627"
$LIFELONG = "$PROJ_DIR\build\lifelong.exe"
$OUTPUT_BASE = "C:\Users\Administrator\Desktop\test-studio-mapf\test-scripts\round_mini"
$PROBLEMS = "$PROJ_DIR\example_problems"
$SCRIPT_DIR = "C:\Users\Administrator\Desktop\test-studio-mapf\test-scripts"

$env:PATH = "C:\msys64\ucrt64\bin;C:\msys64\usr\bin;$env:PATH"

$MD5 = (Get-FileHash $LIFELONG -Algorithm MD5).Hash

$ROUND = 1
while (Test-Path "$OUTPUT_BASE\round$ROUND") { $ROUND++ }
$OUTPUT_DIR = "$OUTPUT_BASE\round$ROUND"
New-Item -ItemType Directory -Path $OUTPUT_DIR -Force | Out-Null

Write-Host "Round $ROUND - Computing..."

# Test random
Set-Location "$PROBLEMS\random.domain"
$tmpOut = "$env:TEMP\lifelong_random_$PID.tmp"
$proc = Start-Process -FilePath $LIFELONG -ArgumentList "-i `"random-example_400.json`" -s 300 -o `"$OUTPUT_DIR\random.json`"" -PassThru -NoNewWindow -RedirectStandardOutput $tmpOut
$proc.WaitForExit()
if (Test-Path "$OUTPUT_DIR\random.json") { Write-Host "random: OK" }
else { Write-Host "random: FAIL" }
Remove-Item $tmpOut -ErrorAction SilentlyContinue

# Test fulfill
Set-Location "$PROBLEMS\warehouse.domain"
$tmpOut = "$env:TEMP\lifelong_fulfill_$PID.tmp"
$proc = Start-Process -FilePath $LIFELONG -ArgumentList "-i `"fulfill-example_2500.json`" -s 1000 -o `"$OUTPUT_DIR\fulfill.json`"" -PassThru -NoNewWindow -RedirectStandardOutput $tmpOut
$proc.WaitForExit()
if (Test-Path "$OUTPUT_DIR\fulfill.json") { Write-Host "fulfill: OK" }
else { Write-Host "fulfill: FAIL" }
Remove-Item $tmpOut -ErrorAction SilentlyContinue

Set-Location $SCRIPT_DIR

python parse_round.py $OUTPUT_DIR

$scoresFile = "$OUTPUT_DIR\scores.txt"
Add-Content $scoresFile ""
Add-Content $scoresFile "MD5: $MD5"

Write-Host "Done!"
