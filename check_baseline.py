import os
import json

output_dir = r"C:\gitcloud\auto-lorr-new\test-script\baseline_round1"
maps = ['random', 'bos', 'room', 'maze', 'fulfill', 'orz', 'iron']

for m in maps:
    fp = os.path.join(output_dir, f"{m}.json")
    if os.path.exists(fp):
        size = os.path.getsize(fp)
        with open(fp, 'r') as f:
            data = json.load(f)
        tasks = data.get('numTaskFinished', 'N/A')
        makespan = data.get('makespan', 'N/A')
        score = round(tasks/makespan, 3) if makespan and makespan > 0 else 0
        print(f"{m}: tasks={tasks}, makespan={makespan}, score={score}, size={size}")
    else:
        print(f"{m}: FILE NOT FOUND")
