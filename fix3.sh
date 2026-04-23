#!/bin/bash
export PATH="/c/msys64/msys64/usr/bin:$PATH"
rm -f /c/msys64/msys64/var/lib/pacman/db.lck

echo "=== Sync ==="
/usr/bin/pacman -Sy 2>&1

echo "=== Force install libwinpthread (overwrite conflicts) ==="
# Use pacman with overwrite to force install
/usr/bin/pacman -S --overwrite '*' --noconfirm mingw-w64-x86_64-libwinpthread mingw-w64-x86_64-winpthreads 2>&1

echo "=== Verify DLLs ==="
/usr/bin/ls -la /c/msys64/msys64/mingw64/bin/*.dll 2>&1

echo "=== Test gcc ==="
/c/msys64/msys64/mingw64/bin/gcc.exe --version 2>&1
echo "gcc exit: $?"

echo "=== Test make ==="
/c/msys64/msys64/mingw64/bin/mingw32-make.exe --version 2>&1
echo "make exit: $?"
