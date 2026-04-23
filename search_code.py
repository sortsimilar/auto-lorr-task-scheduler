import os, re

root = r"C:\gitcloud\auto-lorr-new\lorr-code"
for dirpath, dirs, files in os.walk(root):
    for f in files:
        if f.endswith(('.cpp', '.h', '.hpp')):
            fp = os.path.join(dirpath, f)
            try:
                content = open(fp, 'r', errors='ignore').read()
                if 'is_large_map' in content or 'manhattanDistance' in content or 'warehouse' in content.lower():
                    print(f"\n=== {fp} ===")
                    for i, line in enumerate(content.split('\n'), 1):
                        if 'is_large_map' in line or 'manhattanDistance' in line or ('warehouse' in line.lower() and 'map' in line.lower()):
                            print(f"  {i}: {line.rstrip()}")
            except:
                pass
