import subprocess
import os

# MSYS2 bash path
bash = r"C:\msys64\msys64\usr\bin\bash.exe"
proj = r"C:\gitcloud\auto-lorr-new\lorr-code"

# Build script that runs inside MSYS2 bash
build_script = """
export PATH="/mingw64/bin:/usr/bin:$PATH"
cd /c/gitcloud/auto-lorr-new/lorr-code

rm -rf build

echo "=== Configure ==="
cmake -B build -G "MinGW Makefiles" . \\
    -DCMAKE_BUILD_TYPE=Release \\
    -DCMAKE_C_COMPILER=gcc \\
    -DCMAKE_CXX_COMPILER=g++ \\
    -DBoost_USE_STATIC_LIBS=OFF \\
    -DPYTHON_EXECUTABLE=C:/Python314/python.exe \\
    -DPYTHON_LIBRARY=C:/Python314/libs/python314.lib \\
    -DPYTHON_INCLUDE_DIR=C:/Python314/include \\
    -Wno-dev 2>&1

echo "cmake exit: $?"

echo "=== Build ==="
cmake --build build --target lifelong 2>&1
echo "build exit: $?"

if [ -f build/lifelong.exe ]; then
    sz=$(stat -c%s build/lifelong.exe)
    echo "SUCCESS: lifelong.exe $sz bytes"
else
    echo "FAILED"
fi
"""

result = subprocess.run(
    [bash, "-c", build_script],
    capture_output=True,
    text=True,
    timeout=300
)

print("STDOUT:", result.stdout)
print("STDERR:", result.stderr)
print("RETURN CODE:", result.returncode)
