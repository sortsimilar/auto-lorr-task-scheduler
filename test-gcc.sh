#!/bin/bash
export PATH="/c/msys64/msys64/mingw64/bin:$PATH"
export MSYSTEM=MINGW64
gcc --version
echo "EXIT:$?"
