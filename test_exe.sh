#!/bin/bash
export PATH="/mingw64/bin:/usr/bin:$PATH"

cd /c/gitcloud/auto-lorr-new/lorr-code/example_problems/random.domain

echo "=== Test running lifelong.exe ==="
/c/gitcloud/auto-lorr-new/lorr-code/build/lifelong.exe -i random-example_400.json -s 10 -o /tmp/test_output.json 2>&1
echo "exit: $?"

echo "=== Check output ==="
if [ -f /tmp/test_output.json ]; then
    cat /tmp/test_output.json
else
    echo "NO OUTPUT FILE"
fi
