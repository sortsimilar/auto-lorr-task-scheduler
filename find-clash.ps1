$paths = @(
    'C:\Users\take_\.config\clash-verge\config.yaml',
    'C:\Users\take_\AppData\Roaming\clash-verge\config.yaml',
    'C:\Users\take_\.config\verge-mihomo\config.yaml',
    'C:\Users\take_\AppData\Roaming\verge-mihomo\config.yaml',
    'C:\Users\take_\.config\mihomo\config.yaml'
)
foreach ($p in $paths) {
    if (Test-Path $p) {
        Write-Host "FOUND: $p"
        Get-Content $p | Select-Object -First 20
    }
}
