#!/bin/bash
export PATH="/c/msys64/msys64/usr/bin:$PATH"
rm -f /c/msys64/msys64/var/lib/pacman/db.lck

echo "=== Sync ==="
/usr/bin/pacman -Sy 2>&1

echo "=== Install libwinpthread with overwrite ==="
yes | /usr/bin/pacman -S --overwrite '*' mingw-w64-x86_64-libwinpthread mingw-w64-x86_64-winpthreads mingw-w64-x86_64-gcc 2>&1

echo "=== Test gcc ==="
/c/msys64/msys64/mingw64/bin/gcc.exe --version 2>&1
echo "gcc exit: $?"
