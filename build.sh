#!/bin/bash
export PATH="/c/msys64/msys64/mingw64/bin:/c/msys64/msys64/usr/bin:$PATH"
export CC=gcc
export CXX=g++

cd /c/gitcloud/auto-lorr-new/lorr-code

rm -rf build

echo "=== Configure ==="
/c/msys64/msys64/mingw64/bin/cmake.exe -B build -G "MinGW Makefiles" . \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=/c/msys64/msys64/mingw64/bin/gcc.exe \
    -DCMAKE_CXX_COMPILER=/c/msys64/msys64/mingw64/bin/g++.exe \
    -DBoost_USE_STATIC_LIBS=OFF \
    -DPYTHON_EXECUTABLE=C:/Python314/python.exe \
    -DPYTHON_LIBRARY=C:/Python314/libs/python314.lib \
    -DPYTHON_INCLUDE_DIR=C:/Python314/include \
    -Wno-dev 2>&1

echo "cmake exit: $?"

echo "=== Build ==="
/c/msys64/msys64/mingw64/bin/cmake.exe --build build --target lifelong 2>&1
echo "build exit: $?"

if [ -f build/lifelong.exe ]; then
    sz=$(stat -c%s build/lifelong.exe)
    echo "=== SUCCESS: lifelong.exe $sz bytes ==="
else
    echo "=== FAILED ==="
fi
