#!/bin/bash
export PATH="/c/msys64/msys64/usr/bin:$PATH"
export MSYS="winsymlinks:native"

# Initialize pacman database
echo "=== Initializing pacman ==="
pacman-key --init 2>&1
echo "key init exit: $?"

echo "=== Populating pacman ==="
pacman -Sy --noconfirm 2>&1
echo "sync exit: $?"

echo "=== Installing mingw64 toolchain ==="
pacman -S --noconfirm mingw-w64-x86_64-gcc mingw-w64-x86_64-make mingw-w64-x86_64-cmake mingw-w64-x86_64-boost mingw-w64-x86_64-libwinpthread-git 2>&1
echo "install exit: $?"
