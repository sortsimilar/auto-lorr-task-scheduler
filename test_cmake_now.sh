#!/bin/bash
export PATH="/mingw64/bin:/usr/bin:$PATH"
echo "=== ldd cmake ==="
ldd /mingw64/bin/cmake 2>&1 | grep "not found"

echo "=== cmake version ==="
cmake --version 2>&1
echo "cmake exit: $?"
