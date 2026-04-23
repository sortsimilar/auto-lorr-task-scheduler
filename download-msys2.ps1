$ErrorActionPreference = 'Stop'
$url = 'https://mirrors.cloud.tencent.com/msys2/distrib/x86_64/msys2-x86_64-20260322.exe'
$out = 'C:\gitcloud\auto-lorr-new\msys2-setup.exe'
Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing
$sz = (Get-Item $out).Length
Write-Host "Done, size: $sz"
