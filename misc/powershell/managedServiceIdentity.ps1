$response = Invoke-WebRequest -Uri http://localhost:50342/oauth2/token -Method GET -Body @{resource = "https://management.azure.com/"} -Headers @{Metadata = "true"} -UseBasicParsing -Verbose
$content = $response.Content|ConvertFrom-Json
$armToken = $content.access_token
Login-AzureRmAccount -AccountId $env:COMPUTERNAME -AccessToken $armToken -Verbose
Get-AzureRmVm|Format-Table
