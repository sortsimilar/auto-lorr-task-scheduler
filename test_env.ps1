$env:PATH = "C:\msys64\msys64\mingw64\bin;" + $env:PATH
$env:MSYSTEM = "MINGW64"
$env:CHERE_INVOKING = "1"

$bash = "C:\msys64\msys64\usr\bin\bash.exe"

Write-Host "=== Testing from bash ==="
& $bash -c "export PATH='/c/msys64/msys64/mingw64/bin:`$PATH'; export MSYSTEM=MINGW64; gcc --version 2>&1"
Write-Host "gcc exit: $LASTEXITCODE"

Write-Host ""
Write-Host "=== Testing cmake ==="
& $bash -c "export PATH='/c/msys64/msys64/mingw64/bin:`$PATH'; export MSYSTEM=MINGW64; cmake --version 2>&1"
Write-Host "cmake exit: $LASTEXITCODE"

Write-Host ""
Write-Host "=== Testing make ==="
& $bash -c "export PATH='/c/msys64/msys64/mingw64/bin:`$PATH'; export MSYSTEM=MINGW64; make --version 2>&1"
Write-Host "make exit: $LASTEXITCODE"
