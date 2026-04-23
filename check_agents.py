import json

# Check fulfill agents
fp = r"C:\gitcloud\auto-lorr-new\lorr-code\example_problems\warehouse.domain\agents\fulfill-example_2500.agents"
with open(fp) as f:
    data = json.load(f)

print(f"Fulfill agents: {len(data['agents'])} agents")
print("First 3 agents:")
for a in data['agents'][:3]:
    print(f"  {a}")

print(f"\nFirst 3 tasks:")
tfp = r"C:\gitcloud\auto-lorr-new\lorr-code\example_problems\warehouse.domain\tasks\fulfill-example_2500.tasks"
with open(tfp) as f:
    tasks_data = json.load(f)
for t in tasks_data['task_tasks'][:3]:
    print(f"  task {t['id']}: {t['locations']} (reveal={t['release_time']})")

# Also check random for comparison
fp2 = r"C:\gitcloud\auto-lorr-new\lorr-code\example_problems\random.domain\agents\random-example_400.agents"
with open(fp2) as f:
    data2 = json.load(f)
print(f"\nRandom agents: {len(data2['agents'])} agents")
for a in data2['agents'][:3]:
    print(f"  {a}")
