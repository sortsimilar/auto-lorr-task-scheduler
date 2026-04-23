import subprocess
import os

bash = r"C:\msys64\msys64\usr\bin\bash.exe"
mingw_bin = r"C:\msys64\msys64\mingw64\bin"

# Check what DLLs cmake needs
script = """
export PATH="/mingw64/bin:/usr/bin:$PATH"
ldd /mingw64/bin/cmake 2>&1
"""
result = subprocess.run([bash, "-c", script], capture_output=True, text=True, timeout=30)
print("STDOUT:", result.stdout)
print("STDERR:", result.stderr)
