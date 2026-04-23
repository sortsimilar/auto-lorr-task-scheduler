import json, os

# Analyze all 7 maps
maps = {
    "random": ("random.domain", "random-example_400.json"),
    "room": ("room.domain", "room-example_150.json"),
    "maze": ("maze.domain", "maze-example_40.json"),
    "orz": ("game.domain", "orz-example_1800.json"),
    "fulfill": ("warehouse.domain", "fulfill-example_2500.json"),
    "iron": ("iron_harvest.domain", "iron-example_10000.json"),
    "bos": ("city.domain", "bos-example_600.json"),
}

base = r"C:\gitcloud\auto-lorr-new\lorr-code\example_problems"
results = {}

for name, (domain, jsonfile) in maps.items():
    fp = os.path.join(base, domain, jsonfile)
    with open(fp) as f:
        data = json.load(f)

    # Parse map file
    mapfp = os.path.join(base, domain, data["mapFile"])
    with open(mapfp) as f:
        lines = f.readlines()
    height = int([l for l in lines if l.startswith("height")][0].split()[1])
    width = int([l for l in lines if l.startswith("width")][0].split()[1])

    results[name] = {
        "agents": data["teamSize"],
        "map_size": f"{width}x{height}",
        "map_file": data["mapFile"],
        "delay_model": data["delayConfig"]["eventModel"],
        "delay_p": data["delayConfig"]["pDelay"],
        "delay_range": f"{data['delayConfig']['minDelay']}-{data['delayConfig']['maxDelay']}",
        "num_tasks_reveal": data.get("numTasksReveal", "N/A"),
    }

print("=== MAP CHARACTERISTICS ===")
print(f"{'Map':<10} {'Agents':<8} {'Map Size':<12} {'Delay Model':<12} {'pDelay':<8} {'Delay Range':<12}")
print("-" * 70)
for name, r in results.items():
    print(f"{name:<10} {r['agents']:<8} {r['map_size']:<12} {r['delay_model']:<12} {r['delay_p']:<8} {r['delay_range']:<12}")

# Count traversable cells
print("\n=== MAP DENSITY ANALYSIS ===")
for name, (domain, jsonfile) in maps.items():
    mapfp = os.path.join(base, domain, results[name]["map_file"])
    with open(mapfp) as f:
        lines = f.readlines()
    # Find map data lines (after "map" line)
    map_start = lines.index("map\n") + 1
    map_lines = lines[map_start:]
    total = sum(len(l.rstrip()) for l in map_lines)
    traversable = sum(c != '@' and c != '.' and c != 'T' for l in map_lines for c in l.rstrip())
    obstacle = sum(1 for l in map_lines for c in l.rstrip() if c == '@' or c == '.')
    print(f"{name}: {traversable}/{total} traversable ({100*traversable/total:.1f}%), obstacles={obstacle}")
