@echo off
REM ============================================================
REM MAPF Quick Test Script with MD5 Cache
REM - Uses source code MD5 for cache (not exe MD5)
REM - Checks if this MD5 was already tested (uses cached result)
REM - Records MD5 in scores.txt
REM ============================================================
setlocal enabledelayedexpansion

set "PROJ_DIR=C:\gitcloud\auto-lorr-new\lorr-code"
set "LIFELONG=%PROJ_DIR%\build\lifelong.exe"
set "OUTPUT_BASE=C:\gitcloud\auto-lorr-new\test-script\round"
set "PROBLEMS=%PROJ_DIR%\example_problems"
set "SCRIPT_DIR=C:\gitcloud\auto-lorr-new\test-script"
set "SRC_DIR=%PROJ_DIR%\src"
set "PATH=C:\msys64\ucrt64\bin;C:\msys64\usr\bin;%PATH%"

if not exist "%LIFELONG%" (
    echo Build not found!
    exit /b 1
)

REM ============================================================
REM Step 1: Get source code MD5 via Python
REM ============================================================
pushd "%SRC_DIR%"
for /f "delims=" %%i in ('python -c "import hashlib,os;files=[];[(files.append(os.path.join(r,f)) for r,ds,fs in os.walk('.') for f in fs if not f.endswith('.md'))];files.sort();m=hashlib.md5();[m.update(open(f,'rb').read()) for f in files];print(m.hexdigest().upper())"') do set "MD5=%%i"
popd
echo Source MD5: %MD5%

REM ============================================================
REM Step 2: Check cache
REM ============================================================
set "CACHED_ROUND="
for /f "delims=" %%r in ('powershell -NoProfile -Command "Get-ChildItem -LiteralPath '%OUTPUT_BASE%' -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -match '^round\d+$' } | ForEach-Object { $content = Get-Content -LiteralPath ($_.FullName + '\scores.txt') -ErrorAction SilentlyContinue; if ($content -match 'MD5:\s*%MD5%') { $_.Name } } | Select-Object -First 1"') do (
    set "CACHED_ROUND=%%r"
)

if defined CACHED_ROUND (
    echo FOUND CACHED RESULT: Round %CACHED_ROUND% has same MD5!
    type "%OUTPUT_BASE%\%CACHED_ROUND%\scores.txt"
    exit /b 0
)

REM ============================================================
REM Step 3: No cache, run test (200 steps)
REM ============================================================
set ROUND=1
:find_next
if exist "%OUTPUT_BASE%\round%ROUND%" (
    set /a ROUND+=1
    goto find_next
)
set "OUTPUT_DIR=%OUTPUT_BASE%\round%ROUND%"
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

echo Running round%ROUND% - MD5: %MD5%

REM Test all 7 maps (200 steps each)
echo [1/7] random...
cd /d "%PROBLEMS%\random.domain"
"%LIFELONG%" -i "random-example_400.json" -s 200 -o "%OUTPUT_DIR%\random.json" >nul 2>&1
if exist "%OUTPUT_DIR%\random.json" echo   random OK

echo [2/7] bos...
cd /d "%PROBLEMS%\city.domain"
"%LIFELONG%" -i "bos-example_600.json" -s 200 -o "%OUTPUT_DIR%\bos.json" >nul 2>&1
if exist "%OUTPUT_DIR%\bos.json" echo   bos OK

echo [3/7] room...
cd /d "%PROBLEMS%\room.domain"
"%LIFELONG%" -i "room-example_150.json" -s 200 -o "%OUTPUT_DIR%\room.json" >nul 2>&1
if exist "%OUTPUT_DIR%\room.json" echo   room OK

echo [4/7] maze...
cd /d "%PROBLEMS%\maze.domain"
"%LIFELONG%" -i "maze-example_40.json" -s 200 -o "%OUTPUT_DIR%\maze.json" >nul 2>&1
if exist "%OUTPUT_DIR%\maze.json" echo   maze OK

echo [5/7] fulfill...
cd /d "%PROBLEMS%\warehouse.domain"
"%LIFELONG%" -i "fulfill-example_2500.json" -s 200 -o "%OUTPUT_DIR%\fulfill.json" >nul 2>&1
if exist "%OUTPUT_DIR%\fulfill.json" echo   fulfill OK

echo [6/7] orz...
cd /d "%PROBLEMS%\game.domain"
"%LIFELONG%" -i "orz-example_1800.json" -s 200 -o "%OUTPUT_DIR%\orz.json" >nul 2>&1
if exist "%OUTPUT_DIR%\orz.json" echo   orz OK

echo [7/7] iron...
cd /d "%PROBLEMS%\iron_harvest.domain"
"%LIFELONG%" -i "iron-example_10000.json" -s 200 -o "%OUTPUT_DIR%\iron.json" >nul 2>&1
if exist "%OUTPUT_DIR%\iron.json" echo   iron OK

cd /d "%SCRIPT_DIR%"

REM Parse results
python "%SCRIPT_DIR%\parse_round.py" "%OUTPUT_DIR%"

REM Append MD5
echo. >> "%OUTPUT_DIR%\scores.txt"
echo MD5: %MD5% >> "%OUTPUT_DIR%\scores.txt"

echo Done!
