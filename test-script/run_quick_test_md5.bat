@echo off
REM ============================================================
REM MAPF Quick Test Script with MD5 Cache
REM - Queries MD5 before running
REM - Checks if this MD5 was already tested (uses cached result)
REM - Records MD5 in scores.txt
REM ============================================================
setlocal enabledelayedexpansion

REM Configuration
set "PROJ_DIR=C:\Users\Administrator\Desktop\test-studio-mapf\LORR26_842072627"
set "LIFELONG=%PROJ_DIR%\build\lifelong.exe"
set "OUTPUT_BASE=C:\Users\Administrator\Desktop\test-studio-mapf\test-scripts\round"
set "PROBLEMS=%PROJ_DIR%\example_problems"
set "SCRIPT_DIR=C:\Users\Administrator\Desktop\test-studio-mapf\test-scripts"
set "PATH=C:\msys64\ucrt64\bin;C:\msys64\usr\bin;%PATH%"

REM Check if build needed
if not exist "%LIFELONG%" (
    echo ============================================================
    echo Building project first...
    echo ============================================================
    rmdir /s /q "%PROJ_DIR%\build" 2>nul
    mkdir "%PROJ_DIR%\build"
    
    C:\msys64\ucrt64\bin\cmake.exe -S "%PROJ_DIR%" -B "%PROJ_DIR%\build" -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DBoost_USE_STATIC_LIBS=OFF -DPYTHON_LIBRARY=C:/msys64/ucrt64/lib/libpython3.14.dll.a -DPYTHON_INCLUDE_DIR=C:/msys64/ucrt64/include/python3.14 -Wno-dev >nul 2>&1
    
    C:\msys64\ucrt64\bin\cmake.exe --build "%PROJ_DIR%\build" --target lifelong -j4 >nul 2>&1
    
    if not exist "%LIFELONG%" (
        echo BUILD FAILED!
        pause
        exit /b 1
    )
    echo Build OK!
)

REM ============================================================
REM Step 1: Get MD5 using PowerShell
REM ============================================================
for /f "delims=" %%i in ('powershell -Command "(Get-FileHash '%LIFELONG%' -Algorithm MD5).Hash"') do set "MD5=%%i"
echo Current MD5: %MD5%

REM ============================================================
REM Step 2: Check if MD5 was already tested using PowerShell
REM ============================================================
set "CACHED_ROUND="
for /f "delims=" %%r in ('powershell -NoProfile -Command "Get-ChildItem -LiteralPath '%OUTPUT_BASE%' -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -match '^round\d+$' } | ForEach-Object { $content = Get-Content -LiteralPath ($_.FullName + '\scores.txt') -ErrorAction SilentlyContinue; if ($content -match 'MD5:\s*%MD5%') { $_.Name } } | Select-Object -First 1"') do (
    set "CACHED_ROUND=%%r"
)

if defined CACHED_ROUND (
    echo ============================================================
    echo FOUND CACHED RESULT: Round %CACHED_ROUND% has same MD5!
    echo Using cached results instead of re-testing.
    echo ============================================================
    type "%OUTPUT_BASE%\%CACHED_ROUND%\scores.txt"
    echo Done!
    pause
    exit /b 0
)

REM ============================================================
REM Step 3: No cache found, run new test
REM ============================================================

REM Find next available round number
set ROUND=1
:find_next
if exist "%OUTPUT_BASE%\round%ROUND%" (
    set /a ROUND+=1
    goto find_next
)

set "OUTPUT_DIR=%OUTPUT_BASE%\round%ROUND%"

REM Create output directory
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

echo ============================================================
echo MAPF Quick Test (round%ROUND%) - MD5: %MD5%
echo Output directory: %OUTPUT_DIR%
echo ============================================================

REM Test random (400 agents, 300 steps)
echo [1/7] Testing random...
cd /d "%PROBLEMS%\random.domain"
"%LIFELONG%" -i "random-example_400.json" -s 300 -o "%OUTPUT_DIR%\random.json" >nul 2>&1
if exist "%OUTPUT_DIR%\random.json" echo   random OK

REM Test bos (600 agents, 700 steps)
echo [2/7] Testing bos...
cd /d "%PROBLEMS%\city.domain"
"%LIFELONG%" -i "bos-example_600.json" -s 700 -o "%OUTPUT_DIR%\bos.json" >nul 2>&1
if exist "%OUTPUT_DIR%\bos.json" echo   bos OK

REM Test room (150 agents, 400 steps)
echo [3/7] Testing room...
cd /d "%PROBLEMS%\room.domain"
"%LIFELONG%" -i "room-example_150.json" -s 400 -o "%OUTPUT_DIR%\room.json" >nul 2>&1
if exist "%OUTPUT_DIR%\room.json" echo   room OK

REM Test maze (40 agents, 500 steps)
echo [4/7] Testing maze...
cd /d "%PROBLEMS%\maze.domain"
"%LIFELONG%" -i "maze-example_40.json" -s 500 -o "%OUTPUT_DIR%\maze.json" >nul 2>&1
if exist "%OUTPUT_DIR%\maze.json" echo   maze OK

REM Test fulfill (2500 agents, 1000 steps)
echo [5/7] Testing fulfill...
cd /d "%PROBLEMS%\warehouse.domain"
"%LIFELONG%" -i "fulfill-example_2500.json" -s 1000 -o "%OUTPUT_DIR%\fulfill.json" >nul 2>&1
if exist "%OUTPUT_DIR%\fulfill.json" echo   fulfill OK

REM Test orz (1800 agents, 400 steps)
echo [6/7] Testing orz...
cd /d "%PROBLEMS%\game.domain"
"%LIFELONG%" -i "orz-example_1800.json" -s 400 -o "%OUTPUT_DIR%\orz.json" >nul 2>&1
if exist "%OUTPUT_DIR%\orz.json" echo   orz OK

REM Test iron (10000 agents, 700 steps)
echo [7/7] Testing iron...
cd /d "%PROBLEMS%\iron_harvest.domain"
"%LIFELONG%" -i "iron-example_10000.json" -s 700 -o "%OUTPUT_DIR%\iron.json" >nul 2>&1
if exist "%OUTPUT_DIR%\iron.json" echo   iron OK

REM Change back to original directory
cd /d "%SCRIPT_DIR%"

echo ============================================================
echo Round %ROUND% Complete!
echo Results saved in: %OUTPUT_DIR%
echo ============================================================

REM Parse results
python "%SCRIPT_DIR%\parse_round.py" "%OUTPUT_DIR%"

REM Append MD5 to scores.txt
echo. >> "%OUTPUT_DIR%\scores.txt"
echo MD5: %MD5% >> "%OUTPUT_DIR%\scores.txt"

echo Done!
pause
