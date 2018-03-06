Set-Location $PSScriptRoot
Clear-Host

Write-Verbose 'STEP 1: Install or update AzureRM PowerShell module:' -Verbose
Write-Output 'STEP 1: Install or update AzureRM PowerShell module:'
try {
    $azureRM = Get-Module -ListAvailable AzureRM -Verbose
    if ($azureRM -eq $null) {
        Install-Module AzureRM -Force -Verbose -ErrorAction Stop
    }
    else {
        Update-Module AzureRM -Force -Verbose -ErrorAction Stop
    }
}
catch {
    Write-Host $_
    Write-Output 'ERROR:'
    Write-Output $_
    Pause
}

Write-Verbose 'STEP 2: Download AzCopy:' -Verbose
Write-Output 'STEP 2: Download AzCopy:'
try {
    Invoke-WebRequest -Uri "https://aka.ms/downloadazcopy" -OutFile ./MicrosoftStorageTools.msi -Verbose -ErrorAction Stop
}
catch {
    Write-Host $_
    Write-Output 'ERROR:'
    Write-Output $_
    Pause
}

Write-Verbose 'STEP 3: Install AzCopy:' -Verbose
Write-Output 'STEP 3: Install AzCopy:'
try {
    Start-Process ./MicrosoftStorageTools.msi -Wait
}
catch {
    Write-Host $_
    Write-Output 'ERROR:'
    Write-Output $_
    Pause
}
Write-Verbose 'STEP 4: Download Azure CLI:' -Verbose
Write-Output 'STEP 4: Download Azure CLI:'
try {
    Invoke-WebRequest -Uri "https://azurecliprod.blob.core.windows.net/msi/azure-cli-latest.msi" -OutFile ./AzureCLI.msi -Verbose -ErrorAction Stop
}
catch {
    Write-Host $_
    Write-Output 'ERROR:'
    Write-Output $_
    Pause
}

Write-Verbose 'STEP 5: Install Azure CLI:' -Verbose
Write-Output 'STEP 5: Install Azure CLI:'
try {
    Start-Process ./AzureCLI.msi -Wait
}
catch {
    Write-Host $_
    Write-Output 'ERROR:'
    Write-Output $_
    Pause
}
