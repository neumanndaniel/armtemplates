Set-Location $PSScriptRoot
Clear-Host

Write-Verbose 'STEP 1: Download Azure CLI:' -Verbose
Write-Output 'STEP 1: Download Azure CLI:'
try {
    Invoke-WebRequest -Uri "https://aka.ms/installazurecliwindows" -OutFile ./AzureCLI.msi -Verbose -ErrorAction Stop
}
catch {
    Write-Host $_
    Write-Output 'ERROR:'
    Write-Output $_
    Pause
}

Write-Verbose 'STEP 2: Install Azure CLI:' -Verbose
Write-Output 'STEP 2: Install Azure CLI:'
try {
    Start-Process ./AzureCLI.msi -Wait
}
catch {
    Write-Host $_
    Write-Output 'ERROR:'
    Write-Output $_
    Pause
}
