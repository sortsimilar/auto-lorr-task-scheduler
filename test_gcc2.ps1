$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = "C:\msys64\msys64\mingw64\bin\gcc.exe"
$psi.Arguments = "--version"
$psi.UseShellExecute = $false
$psi.RedirectStandardOutput = $true
$psi.RedirectStandardError = $true
$psi.WorkingDirectory = "C:\msys64\msys64\mingw64\bin"
$proc = [System.Diagnostics.Process]::Start($psi)
$stdout = $proc.StandardOutput.ReadToEnd()
$stderr = $proc.StandardError.ReadToEnd()
$proc.WaitForExit()
Write-Host "Exit: $($proc.ExitCode)"
Write-Host "Stdout: $stdout"
Write-Host "Stderr: $stderr"
