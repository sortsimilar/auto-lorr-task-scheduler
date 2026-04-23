import urllib.request

proxy_handler = urllib.request.ProxyHandler({'http': 'http://127.0.0.1:7897', 'https': 'http://127.0.0.1:7897'})
opener = urllib.request.build_opener(proxy_handler)

for url in [
    'https://www.baidu.com/',
    'https://mirrors.cloud.tencent.com/',
    'https://api.github.com/',
]:
    try:
        r = opener.open(url, timeout=10)
        print(f"{url}: {r.status}")
    except Exception as e:
        print(f"{url}: ERROR - {e}")
