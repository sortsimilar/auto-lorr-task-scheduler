#!/bin/bash
export PATH="/mingw64/bin:/usr/bin:$PATH"
echo "=== gcc ==="
gcc --version 2>&1
echo "gcc exit: $?"
echo "=== cmake ==="
cmake --version 2>&1
echo "cmake exit: $?"
echo "=== make ==="
make --version 2>&1
echo "make exit: $?"
