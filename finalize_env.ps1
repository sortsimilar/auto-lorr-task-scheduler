$oldProxy = Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyServer
Write-Host "Restoring old proxy: $($oldProxy.ProxyServer)"
Set-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyServer -Value $oldProxy.ProxyServer

# Add mingw64 to PATH permanently
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
$newPath = "C:\msys64\msys64\mingw64\bin;$currentPath"
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")
Write-Host "Updated user PATH to include mingw64/bin"

# Also set for current session
$env:PATH = "C:\msys64\msys64\mingw64\bin;" + $env:PATH
Write-Host "Updated current session PATH"
Write-Host "PATH now starts with: $($env:PATH.Substring(0, [Math]::Min(100, $env:PATH.Length)))"

# Test gcc
Write-Host "Testing gcc..."
& "C:\msys64\msys64\mingw64\bin\gcc.exe" --version
Write-Host "gcc exit: $LASTEXITCODE"

# Test make
Write-Host "Testing make..."
& "C:\msys64\msys64\mingw64\bin\make.exe" --version
Write-Host "make exit: $LASTEXITCODE"

# Test cmake
Write-Host "Testing cmake..."
& "C:\msys64\msys64\mingw64\bin\cmake.exe" --version
Write-Host "cmake exit: $LASTEXITCODE"
