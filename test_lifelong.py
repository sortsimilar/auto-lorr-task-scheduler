import subprocess, os

bash = r"C:\msys64\msys64\usr\bin\bash.exe"

# Test: find exe
r = subprocess.run([bash, "-c", "which lifelong.exe || echo not found; ls /c/gitcloud/auto-lorr-new/lorr-code/build/lifelong.exe || echo file not found"],
    capture_output=True, text=True, timeout=10)
print(f"which: {r.stdout}")

# Test: run with env
r = subprocess.run([bash, "-c", "export PATH=/mingw64/bin:/usr/bin:$PATH; /c/gitcloud/auto-lorr-new/lorr-code/build/lifelong.exe --help 2>&1"],
    capture_output=True, text=True, timeout=10)
print(f"exit: {r.returncode}")
print(f"out: {r.stdout[:500]}")

# Test: working dir
r = subprocess.run([bash, "-c", 'cd /c/gitcloud/auto-lorr-new/lorr-code/example_problems/city.domain && pwd && ls *.json 2>&1'],
    capture_output=True, text=True, timeout=10)
print(f"pwd: {r.stdout}")
