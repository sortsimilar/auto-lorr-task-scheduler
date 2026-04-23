$bash = "C:\msys64\msys64\usr\bin\bash.exe"
Write-Host "Checking PATH..."
& $bash -c "echo $PATH" | Out-String | Write-Host
Write-Host "Looking for pacman..."
& $bash -c "ls /usr/bin/pacman* 2>&1" | Out-String | Write-Host
& $bash -c "ls /bin/pacman* 2>&1" | Out-String | Write-Host
& $bash -c "which pacman 2>&1" | Out-String | Write-Host
