import os

# Check file formats
files = [
    r"C:\gitcloud\auto-lorr-new\lorr-code\example_problems\warehouse.domain\agents\fulfill-example_2500.agents",
    r"C:\gitcloud\auto-lorr-new\lorr-code\example_problems\warehouse.domain\tasks\fulfill-example_2500.tasks",
    r"C:\gitcloud\auto-lorr-new\lorr-code\example_problems\random.domain\agents\random-example_400.agents",
    r"C:\gitcloud\auto-lorr-new\lorr-code\example_problems\random.domain\tasks\random-example_400.tasks",
]

for fp in files:
    sz = os.path.getsize(fp)
    with open(fp, 'rb') as f:
        head = f.read(200)
    print(f"\n{os.path.basename(fp)}: {sz} bytes")
    print(f"  First 200 bytes: {head[:200]}")
