import urllib.request

proxy_handler = urllib.request.ProxyHandler({'http': 'http://127.0.0.1:7897', 'https': 'http://127.0.0.1:7897'})
opener = urllib.request.build_opener(proxy_handler)

r = opener.open('https://mirrors.cloud.tencent.com/msys2/mingw/x86_64/', timeout=15)
content = r.read().decode('utf-8', errors='ignore')
import re
pkgs = re.findall(r'mingw-w64-x86_64-[a-zA-Z0-9_+.-]+\.pkg\.tar\.zst', content)
for p in sorted(set(pkgs)):
    print(p)
