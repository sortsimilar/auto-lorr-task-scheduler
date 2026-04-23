import subprocess, os, json

bash = r"C:\msys64\msys64\usr\bin\bash.exe"
exe = "/c/gitcloud/auto-lorr-new/lorr-code/build/lifelong.exe"

def test_map(name, domain, jsonfile, steps=200):
    out = f"/c/gitcloud/auto-lorr-new/test-script/test_{name}.json"
    probepath = f"/c/gitcloud/auto-lorr-new/lorr-code/example_problems/{domain}"

    cmd = f'export PATH=/mingw64/bin:/usr/bin:$PATH; cd {probepath} && "{exe}" -i {jsonfile} -s {steps} -o {out} 2>&1'
    r = subprocess.run([bash, "-c", cmd], capture_output=True, text=True, timeout=300)
    print(f"\n=== {name} (exit={r.returncode}) ===")
    print(f"stdout: {len(r.stdout)} chars, last 500: ...{r.stdout[-500:]}")
    if r.stderr:
        print(f"stderr: {r.stderr[:200]}")

    if os.path.exists(out):
        sz = os.path.getsize(out)
        with open(out) as f:
            data = json.load(f)
        tasks = data.get('numTaskFinished', 0)
        makespan = data.get('makespan', steps)
        score = round(tasks/makespan, 3) if makespan > 0 else 0
        print(f"  -> tasks={tasks}, makespan={makespan}, score={score}, size={sz}")
    else:
        print(f"  -> OUTPUT FILE NOT CREATED")

test_map("bos", "city.domain", "bos-example_600.json", 200)
test_map("fulfill", "warehouse.domain", "fulfill-example_2500.json", 200)
test_map("iron", "iron_harvest.domain", "iron-example_10000.json", 200)
