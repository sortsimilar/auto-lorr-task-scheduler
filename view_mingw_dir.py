import urllib.request

proxy_handler = urllib.request.ProxyHandler({'http': 'http://127.0.0.1:7897', 'https': 'http://127.0.0.1:7897'})
opener = urllib.request.build_opener(proxy_handler)

r = opener.open('https://mirrors.cloud.tencent.com/msys2/mingw/', timeout=15)
content = r.read().decode('utf-8', errors='ignore')
print(content[:3000])
