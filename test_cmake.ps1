$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = "C:\msys64\msys64\mingw64\bin\cmake.exe"
$psi.Arguments = "--version"
$psi.UseShellExecute = $false
$psi.RedirectStandardOutput = $true
$psi.RedirectStandardError = $true
$psi.EnvironmentVariables["PATH"] = "C:\msys64\msys64\mingw64\bin;C:\msys64\msys64\usr\bin;" + [System.Environment]::GetEnvironmentVariable("PATH", "Machine")
$proc = [System.Diagnostics.Process]::Start($psi)
$stdout = $proc.StandardOutput.ReadToEnd()
$stderr = $proc.StandardError.ReadToEnd()
$proc.WaitForExit()
Write-Host "Exit: $($proc.ExitCode)"
Write-Host "Stdout: $stdout"
Write-Host "Stderr: $stderr"
