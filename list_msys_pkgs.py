import urllib.request
import re

proxy_handler = urllib.request.ProxyHandler({'http': 'http://127.0.0.1:7897', 'https': 'http://127.0.0.1:7897'})
opener = urllib.request.build_opener(proxy_handler)

# Get package listing
r = opener.open('https://mirrors.cloud.tencent.com/msys2/distrib/x86_64/', timeout=15)
content = r.read().decode('utf-8', errors='ignore')

# Find all package names
pkgs = re.findall(r'mingw-w64-x86_64-[a-zA-Z0-9_+.-]+\.pkg\.tar\.zst', content)
unique_pkgs = sorted(set(pkgs))

# Filter relevant ones
keywords = ['gcc', 'make', 'cmake', 'boost', 'winpthreads', 'libc++', 'libunwind']
for kw in keywords:
    matching = [p for p in unique_pkgs if kw in p.lower()]
    if matching:
        print(f"\n=== {kw} ===")
        for p in matching:
            print(p)
