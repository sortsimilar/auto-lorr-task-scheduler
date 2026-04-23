import subprocess, os

bash = r"C:\msys64\msys64\usr\bin\bash.exe"
exe = r"C:\gitcloud\auto-lorr-new\lorr-code\build\lifelong.exe"
out = r"C:\gitcloud\auto-lorr-new\test-script\bos_test.json"
probepath = r"C:\gitcloud\auto-lorr-new\lorr-code\example_problems\city.domain"
jsonfile = "bos-example_600.json"

# Check if path exists
exists = os.path.exists(os.path.join(probepath, jsonfile))
print(f"Problem path exists: {exists}")

# Run
r = subprocess.run(
    [bash, "-c", f'cd /c/gitcloud/auto-lorr-new/lorr-code/example_problems/city.domain && "{exe}" -i bos-example_600.json -s 200 -o /c/gitcloud/auto-lorr-new/test-script/bos_test.json 2>&1'],
    capture_output=True, text=True, timeout=60
)
print("STDOUT:", r.stdout[:3000])
print("STDERR:", r.stderr[:1000])
print("returncode:", r.returncode)

# Check output
if os.path.exists(out):
    sz = os.path.getsize(out)
    print(f"Output: {sz} bytes")
    with open(out) as f:
        content = f.read(500)
    print("Content head:", content)
