@echo off
setlocal EnableDelayedExpansion
set "PATH=C:\msys64\msys64\usr\bin;C:\msys64\msys64\mingw64\bin;%PATH%"
set "MSYS_NO_CONSOLECONVERSION=1"
set "CHERE_INVOKING=1"
cd /d C:\gitcloud\auto-lorr-new\lorr-code

echo Installing toolchain via pacman...
C:\msys64\msys64\usr\bin\bash.exe -c "pacman -Sy --noconfirm make mingw-w64-x86_64-gcc mingw-w64-x86_64-cmake mingw-w64-x86_64-boost mingw-w64-x86_64-pybind11 2>&1"

echo Done!
C:\msys64\msys64\usr\bin\bash.exe -c "pacman -Qs make gcc cmake 2>&1 | head -20"
