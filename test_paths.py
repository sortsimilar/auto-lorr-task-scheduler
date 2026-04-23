import subprocess, os

bash = r"C:\msys64\msys64\usr\bin\bash.exe"
exe = r"C:\gitcloud\auto-lorr-new\lorr-code\build\lifelong.exe"
out = r"C:\gitcloud\auto-lorr-new\test-script\bos_test.json"

# Check paths
print(f"exe exists: {os.path.exists(exe)}")
print(f"bash exists: {os.path.exists(bash)}")

# Test: just run bash, no exe
r = subprocess.run([bash, "-c", "echo hello"], capture_output=True, text=True, timeout=10)
print(f"bash works: {r.returncode}, out: {r.stdout}")

# Test with exe
r = subprocess.run([bash, "-c", "/c/gitcloud/auto-lorr-new/lorr-code/build/lifelong.exe --help 2>&1"],
    capture_output=True, text=True, timeout=10)
print(f"exe exit: {r.returncode}")
print(f"exe out: {r.stdout[:500]}")
print(f"exe err: {r.stderr[:500]}")
