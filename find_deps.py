import subprocess
bash = r"C:\msys64\msys64\usr\bin\bash.exe"

# Missing DLLs: libcppdap, libjsoncpp-26, librhash, libuv-1
missing = ["libcppdap", "jsoncpp", "rhash", "libuv"]

for pkg in missing:
    r = subprocess.run([bash, "-c", f"/usr/bin/pacman -Ss {pkg} 2>&1"], capture_output=True, text=True, timeout=30)
    lines = r.stdout.strip().split('\n')
    for line in lines:
        if 'mingw64/mingw-w64-x86_64' in line and 'lib' in line:
            print(line)
