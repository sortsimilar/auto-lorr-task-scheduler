#!/bin/bash
export PATH="/c/msys64/msys64/usr/bin:$PATH"
export MSYS="winsymlinks:native"

echo "=== Syncing db ==="
/usr/bin/pacman -Sy 2>&1
echo "sync: $?"

echo "=== Installing toolchain ==="
/usr/bin/pacman -S --noconfirm mingw-w64-x86_64-gcc mingw-w64-x86_64-make mingw-w64-x86_64-cmake mingw-w64-x86_64-boost 2>&1
echo "install: $?"

echo "=== Test gcc ==="
/c/msys64/msys64/mingw64/bin/gcc.exe --version 2>&1
echo "gcc test: $?"
