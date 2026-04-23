$ProgressPreference = 'SilentlyContinue'
$proxy = "http://127.0.0.1:33331"

# Try direct GitHub raw URL for boost binaries (via proxy)
$urls = @(
    "https://raw.githubusercontent.com/brechtsanders/winlibs_mingw/HEAD/README.md",
    "https://github.com/brechtsanders/winlibs_mingw/releases/download/13.2.0-16.0.6-11.0.0-msvcrt-r1/mingw64.7z"
)

foreach ($url in $urls) {
    try {
        Write-Host "Trying: $url"
        $r = Invoke-WebRequest -Uri $url -Proxy $proxy -TimeoutSec 10 -Method Head
        Write-Host "  OK: $($r.StatusCode)"
    } catch {
        Write-Host "  Failed: $($_.Exception.Message)"
    }
}
