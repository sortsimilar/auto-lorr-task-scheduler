import json, os, sys

if len(sys.argv) > 1:
    output_dir = sys.argv[1]
else:
    output_dir = os.path.dirname(os.path.abspath(__file__))

maps = ['random', 'bos', 'room', 'maze', 'fulfill', 'orz', 'iron']
results = []

for m in maps:
    path = os.path.join(output_dir, m + '.json')
    if os.path.exists(path):
        try:
            with open(path) as f:
                d = json.load(f)
            tasks = d.get('numTaskFinished', 0)
            makespan = d.get('makespan', 10)
            score = tasks / makespan if makespan > 0 else 0
            line = f'{m}: {score:.3f} (tasks={tasks}, makespan={makespan})'
            results.append(line)
            print(line)
        except Exception as e:
            line = f'{m}: ERROR ({e})'
            results.append(line)
            print(line)
    else:
        line = f'{m}: NO DATA'
        results.append(line)
        print(line)

# Save to txt
txt_path = os.path.join(output_dir, 'scores.txt')
with open(txt_path, 'w') as f:
    f.write('\n'.join(results))
print(f'Saved to {txt_path}')
