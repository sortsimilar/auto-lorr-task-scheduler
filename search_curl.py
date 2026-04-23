import subprocess
bash = r"C:\msys64\msys64\usr\bin\bash.exe"
r = subprocess.run([bash, "-c", "PATH=/usr/bin:$PATH pacman -Ss curl 2>&1"], capture_output=True, text=True, timeout=30)
print(r.stdout[:3000])
