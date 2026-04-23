@echo off
setlocal EnableDelayedExpansion
set "PROJ=C:\gitcloud\auto-lorr-new\lorr-code"
set "CMAKE=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
set "CC=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\VC\Tools\MSVC\14.50.35717\bin\Hostx64\x64\cl.exe"
set "CXX=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\VC\Tools\MSVC\14.50.35717\bin\Hostx64\x64\cl.exe"
set "CMAKE_PREFIX_PATH=C:\boost_1_86_0"
set "PATH=C:\msys64\ucrt64\bin;C:\msys64\usr\bin;%PATH%"
cd /d "%PROJ%"

echo ==========================================
echo   LORR Build Script
echo ==========================================
echo.

if exist build (
    echo Cleaning build directory...
    rmdir /s /q build
)

echo Configuring CMake...
"%CMAKE%" -B build -G "NMake Makefiles" . ^
    -DCMAKE_BUILD_TYPE=Release ^
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
