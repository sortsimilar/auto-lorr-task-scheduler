import subprocess, os

bash = r"C:\msys64\msys64\usr\bin\bash.exe"
exe = "/c/gitcloud/auto-lorr-new/lorr-code/build/lifelong.exe"

# Test with forward-slash path
r = subprocess.run([bash, "-c", f'{exe} --help 2>&1'],
    capture_output=True, text=True, timeout=10)
print(f"exe exit: {r.returncode}")
print(f"exe out: {r.stdout[:500]}")
print(f"exe err: {r.stderr[:500]}")
