#!/bin/bash
export PATH="/mingw64/bin:/usr/bin:$PATH"
cd /c/gitcloud/auto-lorr-new/lorr-code

echo "=== Testing cmake ==="
cmake --version 2>&1
echo "cmake exit: $?"

echo "=== Testing gcc ==="
gcc --version 2>&1
echo "gcc exit: $?"
