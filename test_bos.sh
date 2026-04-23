#!/bin/bash
export PATH="/mingw64/bin:/usr/bin:$PATH"
cd /c/gitcloud/auto-lorr-new/lorr-code/example_problems/bos.domain
echo "=== Testing bos (city.domain) ==="
/c/gitcloud/auto-lorr-new/lorr-code/build/lifelong.exe -i bos-example_600.json -s 200 -o /c/gitcloud/auto-lorr-new/test-script/bos_test.json 2>&1
echo "exit: $?"
echo ""
echo "=== JSON head ==="
head -c 2000 /c/gitcloud/auto-lorr-new/test-script/bos_test.json
