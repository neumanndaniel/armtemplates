New-Item -Path C:\ -Name "_securityTest" -ItemType Directory -Verbose
Copy-Item -Path C:\Windows\notepad.exe -Destination C:\_securityTest\ASC_AlertTest_662jfi039N.exe -Verbose
$scriptRow1='$command="ASC_AlertTest_662jfi039N.exe -foo"'
$scriptRow2='cmd.exe /c $command'
$scriptRow1|Out-File -FilePath C:\_securityTest\runSecurityTest.ps1 -Append -Verbose
$scriptRow2|Out-File -FilePath C:\_securityTest\runSecurityTest.ps1 -Append -Verbose
