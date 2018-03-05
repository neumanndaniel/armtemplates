(Invoke-WebRequest -Headers @{'Metadata'='true'} -UseBasicParsing -Uri 'http://169.254.169.254/metadata/instance?api-version=2017-08-01' -Verbose).Content|ConvertFrom-Json|ConvertTo-Json -Depth 99
