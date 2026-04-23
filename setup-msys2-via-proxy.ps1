$oldProxy = Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyServer
Write-Host "Old proxy: $($oldProxy.ProxyServer)"

Set-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyServer -Value '127.0.0.1:7897'
Set-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyEnable -Value 1

Write-Host "New proxy set to 127.0.0.1:7897"

# Now run msys2 setup
Write-Host "Starting MSYS2 setup..."
Start-Process 'C:\gitcloud\auto-lorr-new\msys2-setup.exe' -ArgumentList 'in --confirm --accept-messages --accept-all' -Wait

Write-Host "Setup finished. Restoring old proxy..."
Set-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyServer -Value $oldProxy.ProxyServer

Write-Host "Done!"
