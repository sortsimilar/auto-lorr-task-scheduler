$pinfo = New-Object System.Diagnostics.ProcessStartInfo
$pinfo.FileName = "C:\Users\Administrator\Desktop\test-studio-mapf\LORR26_842072627\build\lifelong.exe"
$pinfo.Arguments = "-i C:\Users\Administrator\Desktop\test-studio-mapf\LORR26_842072627\example_problems\random.domain\random-example_400.json -s 300 -o C:\Users\Administrator\Desktop\test-studio-mapf\test-scripts\test_random3.json"
$pinfo.RedirectStandardError = $true
$pinfo.RedirectStandardOutput = $true
$pinfo.UseShellExecute = $false
$p = New-Object System.Diagnostics.Process
$p.StartInfo = $pinfo
$p.Start() | Out-Null
$stderr = $p.StandardError.ReadToEnd()
$stdout = $p.StandardOutput.ReadToEnd()
$p.WaitForExit()
Write-Host "STDOUT:"
Write-Host $stdout
Write-Host "STDERR:"
Write-Host $stderr
Write-Host "EXIT:" $p.ExitCode
