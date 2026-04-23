$ProgressPreference = 'SilentlyContinue'
try {
    $r = Invoke-WebRequest -Uri 'https://mirrors.cloud.tencent.com/msys2/distrib/x86_64/' -Proxy 'http://127.0.0.1:33331' -TimeoutSec 15
    $r.Content -split "`n" | Select-String 'mingw-w64-x86_64-gcc|mingw-w64-x86_64-make|mingw-w64-x86_64-cmake|mingw-w64-x86_64-boost|mingw-w64-x86_64-libwinpthread' | Select-Object -First 20
} catch {
    Write-Host $_.Exception.Message
}
