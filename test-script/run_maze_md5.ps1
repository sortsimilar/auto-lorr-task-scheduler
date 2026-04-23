# MAPF Test Script for MAZE map
# Tests maze map only, saves to maze_round/

$PROJ_DIR = "C:\Users\Administrator\Desktop\test-studio-mapf\LORR26_842072627"
$SRC_DIR = "$PROJ_DIR\src"
$LIFELONG = "$PROJ_DIR\build\lifelong.exe"
$OUTPUT_BASE = "C:\Users\Administrator\Desktop\test-studio-mapf\test-scripts\maze_round"
$PROBLEMS = "$PROJ_DIR\example_problems"
$SCRIPT_DIR = "C:\Users\Administrator\Desktop\test-studio-mapf\test-scripts"

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

Write-Host "MAPF Maze Test (round$ROUND) - MD5: $MD5"

$map = @{name="maze"; dir="maze.domain"; file="maze-example_40.json"; steps=500}
$oldLoc = Get-Location
Set-Location "$PROBLEMS\$($map.dir)"
& $LIFELONG -i $map.file -s $map.steps -o "$OUTPUT_DIR\$($map.name).json" 2>&1 | Select-String -Pattern "error|Error|ERROR" | Select-Object -First 5
Set-Location $oldLoc

# Parse results (score = tasks / makespan)
$jsonFile = "$OUTPUT_DIR\$($map.name).json"
if (Test-Path $jsonFile) {
    $content = Get-Content $jsonFile -Raw
    $data = $content | ConvertFrom-Json
    $tasks = $data.numTaskFinished
    $makespan = $data.makespan
    $score = [math]::Round($tasks / $makespan, 3)
    $result = "$($map.name): $score (tasks=$tasks, makespan=$makespan)"
    Write-Host $result
    $result | Out-File "$OUTPUT_DIR\scores.txt"
} else {
    Write-Host "$($map.name): NO DATA"
    "$($map.name): NO DATA" | Out-File "$OUTPUT_DIR\scores.txt"
}

$scoresFile = "$OUTPUT_DIR\scores.txt"
$md5Line = "MD5: $MD5"
if (-not (Select-String -Path $scoresFile -Pattern "^MD5:" -Quiet)) {
    Add-Content $scoresFile ""
    Add-Content $scoresFile $md5Line
}

Write-Host "Done!"
