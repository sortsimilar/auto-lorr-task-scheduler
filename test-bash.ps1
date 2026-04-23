$bash = "C:\msys64\msys64\usr\bin\bash.exe"
$proc = Start-Process -FilePath $bash -ArgumentList "-c","echo TEST" -NoNewWindow -PassThru -Wait
Write-Host "Exit: $($proc.ExitCode)"
