@echo off
setlocal EnableDelayedExpansion

set "PROJ=C:\gitcloud\auto-lorr-new\lorr-code"
set "MINGW_ROOT=C:\msys64\msys64\mingw64"
set "MINGW_BIN=C:\msys64\msys64\mingw64\bin"
set "MSYS_BIN=C:\msys64\msys64\usr\bin"
set "CMAKE=%MINGW_BIN%\cmake.exe"

set "PATH=%MINGW_BIN%;%MSYS_BIN%;%PATH%"
set "CC=gcc"
set "CXX=g++"
set "CFLAGS=-O2"
set "CXXFLAGS=-O2"

cd /d "%PROJ%"

echo ==========================================
echo   LORR Build Script (MinGW)
echo ==========================================
echo CC: %CC%
echo CXX: %CXX%
echo.

if exist build (
    echo Cleaning build directory...
    rmdir /s /q build
)

echo Configuring CMake with MinGW...
"%CMAKE%" -B build -G "MinGW Makefiles" . ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_C_COMPILER="%MINGW_BIN%\gcc.exe" ^
    -DCMAKE_CXX_COMPILER="%MINGW_BIN%\g++.exe" ^
    -DCMAKE_MAKE_PROGRAM="%MINGW_BIN%\make.exe" ^
    -DBoost_USE_STATIC_LIBS=OFF ^
    -DPYTHON_EXECUTABLE=C:/Python314/python.exe ^
    -DPYTHON_LIBRARY=C:/Python314/libs/python314.lib ^
    -DPYTHON_INCLUDE_DIR=C:/Python314/include ^
    -Wno-dev 2>&1

echo.
echo Building lifelong.exe...
"%CMAKE%" --build build --target lifelong 2>&1

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
