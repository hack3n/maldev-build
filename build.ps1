Write-Output @"

███╗░░░███╗░█████╗░██╗░░░░░██████╗░███████╗██╗░░░██╗░░░░░░██████╗░██╗░░░██╗██╗██╗░░░░░██████╗░
████╗░████║██╔══██╗██║░░░░░██╔══██╗██╔════╝██║░░░██║░░░░░░██╔══██╗██║░░░██║██║██║░░░░░██╔══██╗
██╔████╔██║███████║██║░░░░░██║░░██║█████╗░░╚██╗░██╔╝█████╗██████╦╝██║░░░██║██║██║░░░░░██║░░██║
██║╚██╔╝██║██╔══██║██║░░░░░██║░░██║██╔══╝░░░╚████╔╝░╚════╝██╔══██╗██║░░░██║██║██║░░░░░██║░░██║
██║░╚═╝░██║██║░░██║███████╗██████╔╝███████╗░░╚██╔╝░░░░░░░░██████╦╝╚██████╔╝██║███████╗██████╔╝
╚═╝░░░░░╚═╝╚═╝░░╚═╝╚══════╝╚═════╝░╚══════╝░░░╚═╝░░░░░░░░░╚═════╝░░╚═════╝░╚═╝╚══════╝╚═════╝░

"@

$id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object System.Security.Principal.WindowsPrincipal($id)
if(-Not $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)){
    throw "This script must be run with elevated privileges."
}

Write-Output "Installing Chocolatey"
Invoke-Expression (Invoke-RestMethod "https://community.chocolatey.org/install.ps1")

$inputPackages = $("git", "disabledefender-winconfig", "sysinternals", "vscode")
$validPackages = @()
$somePackageValidationFailed = $false

Write-Output "Checking packages are valid...`n"
foreach ($package in $inputPackages) {
    if ((choco find $package).Length -gt 2) {
        $validPackages = $validPackages + $package
        Write-Output "$package - ok"
    }
    else {
        $somePackageValidationFailed = $true
        Write-Output "$package - failed"
    }
}
Write-Output "`n"

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
    Write-Output "Starting installation of chocolatey packages`n"

    foreach ($package in $validPackages) {
        choco install $package -y --acceptlicense
    }
} catch {
    throw "Failure to install packages"
}