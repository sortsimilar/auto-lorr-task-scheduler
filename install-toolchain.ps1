$env:PATH = "C:\msys64\msys64\usr\bin;C:\msys64\msys64\mingw64\bin;$env:PATH"
$env:MSYS_NO_CONSOLECONVERSION = "1"
$bash = "C:\msys64\msys64\usr\bin\bash.exe"

# Update pacman DB first
Write-Host "Updating pacman DB..."
& $bash -c "pacman -Sy 2>&1" | Out-String | Write-Host

Write-Host "Installing toolchain..."
& $bash -c "pacman -S --noconfirm make mingw-w64-x86_64-gcc mingw-w64-x86_64-cmake mingw-w64-x86_64-boost mingw-w64-x86_64-pybind11 2>&1" | Out-String | Write-Host

Write-Host "Done!"
