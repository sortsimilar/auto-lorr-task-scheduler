import json, os

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

for name, (domain, jsonfile) in maps.items():
    fp = os.path.join(base, domain, jsonfile)
    with open(fp) as f:
        data = json.load(f)

    mapfp = os.path.join(base, domain, data["mapFile"])
    with open(mapfp) as f:
        lines = f.readlines()

    height = int([l for l in lines if l.startswith("height")][0].split()[1])
    width = int([l for l in lines if l.startswith("width")][0].split()[1])

    # Find map data
    try:
        mi = lines.index("map\n")
        maplines = lines[mi+1:]
    except:
        try:
            mi = lines.index("map\r\n")
            maplines = lines[mi+1:]
        except:
            maplines = lines[3:]  # fallback

    # Strip trailing whitespace
    maplines = [l.rstrip("\r\n") for l in maplines]
    total = sum(len(l) for l in maplines)

    # Count @ (wall) and . (open) - T is also traversable in warehouse maps
    walls = sum(1 for l in maplines for c in l if c == '@')
    open_space = sum(1 for l in maplines for c in l if c == '.')
    special = sum(1 for l in maplines for c in l if c not in ['@', '.', '\r', '\n'])

    print(f"{name}: {width}x{height}, total={total}, @={walls}({100*walls/total:.1f}%), .={open_space}({100*open_space/total:.1f}%), special={special}")
    if special > 0:
        # Show what special chars exist
        chars = set(c for l in maplines for c in l if c not in ['@', '.', '\r', '\n'])
        print(f"  Special chars: {chars}")
