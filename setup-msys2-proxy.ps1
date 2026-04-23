$env:HTTP_PROXY = "http://127.0.0.1:33331"
$env:HTTPS_PROXY = "http://127.0.0.1:33331"
Write-Host "Starting MSYS2 setup with proxy..."
Start-Process -FilePath 'C:\gitcloud\auto-lorr-new\msys2-setup.exe' -ArgumentList 'in --confirm --accept-messages --accept-all' -Wait -PassThru | Select-Object ExitCode
Write-Host "Exit code: $($_.ExitCode)"
