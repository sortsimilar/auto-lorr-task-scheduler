@echo off
setlocal EnableDelayedExpansion
set "PATH=C:\msys64\ucrt64\bin;C:\msys64\usr\bin;%PATH%"
set "PROJ=%~dp0..\LORR26_842072627"
cd /d "%PROJ%"

echo ==========================================
echo   LORR Build Script
echo ==========================================
echo.

if exist build (
    echo Cleaning build directory...
    rmdir /s /q build
)

echo Configuring CMake with Python311...
C:\msys64\ucrt64\bin\cmake.exe -B build -G "Unix Makefiles" . ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DBoost_USE_STATIC_LIBS=OFF ^
    -DPYTHON_EXECUTABLE=C:/Python311/python.exe ^
    -DPYTHON_LIBRARY=C:/Python311/libs/python311.lib ^
    -DPYTHON_INCLUDE_DIR=C:/Python311/include ^
    -Wno-dev

echo.
echo Building lifelong.exe (-j4)...
C:\msys64\ucrt64\bin\cmake.exe --build build --target lifelong -j4

if exist build\lifelong.exe (
    for %%A in (build\lifelong.exe) do set SZ=%%~zA
    echo.
    echo ==========================================
    echo   BUILD SUCCESS
    echo   lifelong.exe  !SZ!  bytes
    echo ==========================================
) else (
    echo.
    echo BUILD FAILED!
    exit /b 1
)
