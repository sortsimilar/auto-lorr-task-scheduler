#!/bin/bash
# Quick baseline test - all 7 maps, 200 steps each
export PATH="/mingw64/bin:/usr/bin:$PATH"

PROJ_DIR="/c/gitcloud/auto-lorr-new/lorr-code"
OUTPUT_DIR="/c/gitcloud/auto-lorr-new/test-script/baseline_round1"
PROBLEMS="$PROJ_DIR/example_problems"
LIFELONG="$PROJ_DIR/build/lifelong.exe"

mkdir -p "$OUTPUT_DIR"

echo "=== BASELINE TEST - ALL MAPS 200 STEPS ==="

maps=(
    "random:random.domain:random-example_400.json"
    "bos:city.domain:bos-example_600.json"
    "room:room.domain:room-example_150.json"
    "maze:maze.domain:maze-example_40.json"
    "fulfill:warehouse.domain:fulfill-example_2500.json"
    "orz:game.domain:orz-example_1800.json"
    "iron:iron_harvest.domain:iron-example_10000.json"
)

for map_info in "${maps[@]}"; do
    IFS=':' read -r name dir file <<< "$map_info"
    echo ""
    echo "--- $name ---"
    cd "$PROBLEMS/$dir"
    $LIFELONG -i $file -s 200 -o "$OUTPUT_DIR/${name}.json" 2>&1 | grep -E "error|Error|ERROR|solve|finish" || true
    echo "exit: $?"
done

echo ""
echo "=== Parse results ==="
cd /c/gitcloud/auto-lorr-new/test-script
python parse_round.py "$OUTPUT_DIR" 2>&1 || true

echo ""
echo "=== Scores ==="
if [ -f "$OUTPUT_DIR/scores.txt" ]; then
    cat "$OUTPUT_DIR/scores.txt"
fi
