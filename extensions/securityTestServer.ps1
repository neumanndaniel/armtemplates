New-Item -Path C:\ -Name "_securityTest" -ItemType Directory -Verbose
Copy-Item -Path C:\Windows\notepad.exe -Destination C:\_securityTest\ASC_AlertTest_662jfi039N.exe -Verbose
".\ASC_AlertTest_662jfi039N.exe -foo" > C:\_securityTest\runSecurityTest.ps1
