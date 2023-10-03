Write-Host @"

███╗░░░███╗░█████╗░██╗░░░░░██████╗░███████╗██╗░░░██╗░░░░░░██████╗░██╗░░░██╗██╗██╗░░░░░██████╗░
████╗░████║██╔══██╗██║░░░░░██╔══██╗██╔════╝██║░░░██║░░░░░░██╔══██╗██║░░░██║██║██║░░░░░██╔══██╗
██╔████╔██║███████║██║░░░░░██║░░██║█████╗░░╚██╗░██╔╝█████╗██████╦╝██║░░░██║██║██║░░░░░██║░░██║
██║╚██╔╝██║██╔══██║██║░░░░░██║░░██║██╔══╝░░░╚████╔╝░╚════╝██╔══██╗██║░░░██║██║██║░░░░░██║░░██║
██║░╚═╝░██║██║░░██║███████╗██████╔╝███████╗░░╚██╔╝░░░░░░░░██████╦╝╚██████╔╝██║███████╗██████╔╝
╚═╝░░░░░╚═╝╚═╝░░╚═╝╚══════╝╚═════╝░╚══════╝░░░╚═╝░░░░░░░░░╚═════╝░░╚═════╝░╚═╝╚══════╝╚═════╝░

"@

$id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object System.Security.Principal.WindowsPrincipal($id)
if (-Not $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw "This script must be run with elevated privileges."
}

Write-Host "Installing Chocolatey"
Invoke-Expression (Invoke-RestMethod "https://community.chocolatey.org/install.ps1")

$inputPackages = $("git", "sysinternals", "vscode", "visualstudio2022community", "googlechrome", "sublimetext3")
$validPackages = @()
$somePackageValidationFailed = $false

Write-Host "Checking packages are valid...`n"
foreach ($package in $inputPackages) {
    if ((choco find $package).Length -gt 2) {
        $validPackages = $validPackages + $package
        Write-Host "$package - ok"
    }
    else {
        $somePackageValidationFailed = $true
        Write-Host "$package - failed"
    }
}
Write-Host "`n"

$choice = "y"
if ($somePackageValidationFailed) {
    Write-Warning "Failed to find some packages"

    while ($choice -notmatch "[y|n]") {
        $choice = Read-Host "Wish to continue? (y/n):"
    }
}

if ($choice -ne "y") {
    throw "Verify your package list and try again"
} 

try {
    Write-Host "Starting installation of chocolatey packages`n"

    foreach ($package in $validPackages) {
        choco install $package -y --acceptlicense
    }
}
catch {
    throw "Failure to install packages"
}

Write-Host "Add exclusion and disable realtime protection to we can pull the Defender kill script"
Add-MpPreference -ExclusionPath "$env:temp"
Set-MpPreference -DisableRealtimeMonitoring 1

Write-Host "Pulling and running Defender removal script"
(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/hack3n/maldev-build/main/kill-defender.ps1', "$env:temp/kill-defender.ps1")
."$env:temp\kill-defender.ps1"