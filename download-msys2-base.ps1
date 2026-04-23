$ErrorActionPreference = 'Stop'
$url = 'https://mirrors.cloud.tencent.com/msys2/distrib/x86_64/msys2-base-x86_64-20260322.sfx.exe'
$out = 'C:\gitcloud\auto-lorr-new\msys2-base-sfx.exe'
Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing
$sz = (Get-Item $out).Length
Write-Host "Done, size: $sz"
