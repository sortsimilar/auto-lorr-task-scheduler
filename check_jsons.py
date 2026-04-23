import os, json

base = r"C:\gitcloud\auto-lorr-new\test-script"
for f in os.listdir(base):
    fp = os.path.join(base, f)
    if fp.endswith('.json'):
        sz = os.path.getsize(fp)
        try:
            with open(fp) as fh:
                d = json.load(fh)
            tasks = d.get('numTaskFinished', 0)
            makespan = d.get('makespan', 0)
            score = round(tasks/makespan, 3) if makespan > 0 else 0
            print(f"{f}: {sz}B, tasks={tasks}, makespan={makespan}, score={score}")
        except Exception as e:
            print(f"{f}: {sz}B, JSON ERR: {e}")
