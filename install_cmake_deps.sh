#!/bin/bash
export PATH="/c/msys64/msys64/usr/bin:$PATH"
rm -f /c/msys64/msys64/var/lib/pacman/db.lck

echo "=== Sync ==="
/usr/bin/pacman -Sy 2>&1

echo "=== Install cmake dependencies ==="
yes | /usr/bin/pacman -S mingw-w64-x86_64-libarchive mingw-w64-x86_64-libcurl mingw-w64-x86_64-libexpat mingw-w64-x86_64-libjsoncpp mingw-w64-x86_64-libcppdap 2>&1

echo "=== Test cmake ==="
export PATH="/mingw64/bin:/usr/bin:$PATH"
cmake --version 2>&1
echo "cmake exit: $?"
