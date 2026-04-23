import subprocess, os, json

bash = r"C:\msys64\msys64\usr\bin\bash.exe"
exe = "/c/gitcloud/auto-lorr-new/lorr-code/build/lifelong.exe"
out = "/c/gitcloud/auto-lorr-new/test-script/bos_test.json"

# Run with full path and PATH set
r = subprocess.run(
    [bash, "-c",
     f'export PATH=/mingw64/bin:/usr/bin:$PATH; cd /c/gitcloud/auto-lorr-new/lorr-code/example_problems/city.domain && "{exe}" -i bos-example_600.json -s 200 -o /c/gitcloud/auto-lorr-new/test-script/bos_test.json 2>&1'],
    capture_output=True, text=True, timeout=60
)
print(f"exit: {r.returncode}")
print(f"out lines: {len(r.stdout.split(chr(10)))}")
print(f"err: {r.stderr[:500]}")
print("first 2000 chars of stdout:")
print(r.stdout[:2000])

# Check if output file exists
if os.path.exists("/c/gitcloud/auto-lorr-new/test-script/bos_test.json"):
    sz = os.path.getsize("/c/gitcloud/auto-lorr-new/test-script/bos_test.json")
    print(f"\nOutput file: {sz} bytes")
    with open("/c/gitcloud/auto-lorr-new/test-script/bos_test.json") as f:
        content = f.read(2000)
    print("Content:", content[:2000])
else:
    print("\nOutput file NOT created")
