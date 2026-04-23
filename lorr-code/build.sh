#!/bin/bash
export PATH="/mingw64/bin:/usr/bin:$PATH"

cd /c/gitcloud/auto-lorr-new/lorr-code

rm -rf build

PYBIND11_DIR="C:/Users/take_/AppData/Roaming/Python/Python314/site-packages/pybind11/share/cmake/pybind11"

echo "=== Configure ==="
cmake -B build -G "MinGW Makefiles" . \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=gcc \
    -DCMAKE_CXX_COMPILER=g++ \
    -DBoost_USE_STATIC_LIBS=OFF \
    -DBOOST_LOG_DYN_LINK=ON \
    -DPYTHON_EXECUTABLE=C:/Python314/python.exe \
    -DPYTHON_LIBRARY=C:/Python314/libs/python314.lib \
    -DPYTHON_INCLUDE_DIR=C:/Python314/include \
    -Dpybind11_DIR="$PYBIND11_DIR" \
    2>&1

echo "cmake exit: $?"

echo ""
echo "=== Build ==="
cmake --build build --target lifelong 2>&1
echo "build exit: $?"

if [ -f build/lifelong.exe ]; then
    sz=$(stat -c%s build/lifelong.exe)
    echo ""
    echo "=== SUCCESS: lifelong.exe $sz bytes ==="
else
    echo ""
    echo "=== FAILED ==="
fi
