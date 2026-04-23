$env:HTTP_PROXY = "http://127.0.0.1:33331"
$env:HTTPS_PROXY = "http://127.0.0.1:33331"
$env:ALL_PROXY = "socks5://127.0.0.1:33331"
$bash = "C:\msys64\msys64\usr\bin\bash.exe"

Write-Host "Updating pacman DB..."
& $bash -c "export HTTP_PROXY='http://127.0.0.1:33331'; export HTTPS_PROXY='http://127.0.0.1:33331'; pacman -Sy 2>&1" | Out-String | Write-Host

Write-Host "Installing toolchain..."
& $bash -c "export HTTP_PROXY='http://127.0.0.1:33331'; export HTTPS_PROXY='http://127.0.0.1:33331'; pacman -S --noconfirm make mingw-w64-x86_64-gcc mingw-w64-x86_64-cmake mingw-w64-x86_64-boost mingw-w64-x86_64-pybind11 2>&1" | Out-String | Write-Host

Write-Host "Done!"
