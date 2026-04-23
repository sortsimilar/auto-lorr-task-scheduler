import urllib.request
import os

proxy_handler = urllib.request.ProxyHandler({'http': 'http://127.0.0.1:7897', 'https': 'http://127.0.0.1:7897'})
opener = urllib.request.build_opener(proxy_handler)

base_url = "https://mirrors.cloud.tencent.com/msys2/mingw/mingw64/"
out_dir = r"C:\msys64\msys64\var\lib\pacman\local"

packages = [
    "mingw-w64-x86_64-gcc-15.2.0-14-any.pkg.tar.zst",
    "mingw-w64-x86_64-gcc-libs-15.2.0-14-any.pkg.tar.zst",
    "mingw-w64-x86_64-winpthreads-13.0.0.r179.g8181947cc-1-any.pkg.tar.zst",
    "mingw-w64-x86_64-make-4.4.1-4-any.pkg.tar.zst",
    "mingw-w64-x86_64-cmake-4.3.2-2-any.pkg.tar.zst",
    "mingw-w64-x86_64-boost-1.90.0-3-any.pkg.tar.zst",
]

os.makedirs(r"C:\msys64\msys64\pkg_temp", exist_ok=True)

for pkg in packages:
    url = base_url + pkg
    out_path = os.path.join(r"C:\msys64\msys64\pkg_temp", pkg)
    print(f"Downloading {pkg}...")
    try:
        r = opener.open(url, timeout=120)
        with open(out_path, 'wb') as f:
            while True:
                chunk = r.read(1024*1024)
                if not chunk:
                    break
                f.write(chunk)
        print(f"  Downloaded: {os.path.getsize(out_path)} bytes")
    except Exception as e:
        print(f"  Failed: {e}")

print("All downloads done!")
