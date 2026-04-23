import urllib.request
import sys

proxy_handler = urllib.request.ProxyHandler({'http': 'http://127.0.0.1:33331', 'https': 'http://127.0.0.1:33331'})
opener = urllib.request.build_opener(proxy_handler)

# Test proxy
try:
    r = opener.open('https://mirrors.cloud.tencent.com/msys2/distrib/x86_64/', timeout=10)
    print(f"Status: {r.status}")
    content = r.read(2000).decode('utf-8', errors='ignore')
    # Find package links
    import re
    pkgs = re.findall(r'mingw-w64-x86_64-[a-z0-9-]+\.pkg\.tar\.zst', content)
    for p in sorted(set(pkgs))[:20]:
        print(p)
except Exception as e:
    print(f"Error: {e}")
