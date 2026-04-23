#!/bin/bash
export PATH="/c/msys64/msys64/usr/bin:$PATH"
rm -f /c/msys64/msys64/var/lib/pacman/db.lck 2>/dev/null
rm -f /c/msys64/msys64/var/lib/pacman/db.lck 2>/dev/null
echo "=== Sync ==="
/usr/bin/pacman -Sy 2>&1
echo "sync exit: $?"
echo "=== Install ==="
/usr/bin/pacman -S --noconfirm mingw-w64-x86_64-gcc mingw-w64-x86_64-make mingw-w64-x86_64-cmake mingw-w64-x86_64-boost 2>&1
echo "install exit: $?"
echo "=== Test ==="
/c/msys64/msys64/mingw64/bin/gcc.exe --version 2>&1
echo "gcc exit: $?"
