# BetterStepsRecorder Installer Script
# Requires PowerShell 5.1+ and internet access

$ErrorActionPreference = "Stop"

# Step 1-2: Define GitHub URL
$githubUrl = "https://api.github.com/repos/Mentaleak/BetterStepsRecorder/releases/latest"

# Step 3-4: Get latest release and download ZIP
Write-Host "Fetching latest release..."
$release = Invoke-RestMethod -Uri $githubUrl -UseBasicParsing
$zipAsset = $release.assets | Where-Object { $_.name -like "*.zip" } | Select-Object -First 1
$zipUrl = $zipAsset.browser_download_url
$zipName = $zipAsset.name
$downloadPath = "$env:TEMP\$zipName"

Write-Host "Downloading $zipName..."
Invoke-WebRequest -Uri $zipUrl -OutFile $downloadPath

# Step 5-11: Extract ZIP and copy to Program Files
$folderName = [System.IO.Path]::GetFileNameWithoutExtension($zipName)
$extractPath = "$env:TEMP\BSR_Extract"
$destination = "C:\Program Files\$folderName"

Write-Host "Extracting files..."
Expand-Archive -Path $downloadPath -DestinationPath $extractPath -Force

# Step 8-11: Copy to Program Files (requires admin)
Write-Host "Copying to Program Files..."
Copy-Item -Path "$extractPath\$folderName" -Destination $destination -Recurse -Force

# Step 17-19: Check if .NET Desktop Runtime 10.0.4 x86 is already installed
$dotnetInstalled = Get-ItemProperty "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" |
                   Where-Object { ($_.DisplayName -like "*Microsoft Windows Desktop Runtime*" -or
                                   $_.DisplayName -like "*Microsoft .NET*Desktop Runtime*") -and
                                   $_.DisplayVersion -like "10.0.4*" } |
                   Select-Object -First 1

if ($dotnetInstalled) {
    Write-Host ".NET Desktop Runtime already installed"
} else {
    Write-Host "Downloading .NET Desktop Runtime 10.0.4 (x86)..."
    $dotnetUrl = "https://aka.ms/dotnet/10.0/windowsdesktop-runtime-win-x86.exe"
    $dotnetInstaller = "$env:TEMP\windowsdesktop-runtime-x86.exe"
    Invoke-WebRequest -Uri $dotnetUrl -OutFile $dotnetInstaller

    Write-Host "Installing .NET Desktop Runtime 10.0.4 (x86)..."
    Start-Process -FilePath $dotnetInstaller -ArgumentList "/quiet /norestart" -Wait

    Write-Host "Pausing for 10 seconds..."
    Start-Sleep -Seconds 10

    Write-Host ".NET Desktop Runtime successfully installed."
    Read-Host "Press Enter to Launch BetterStepsRecorder"
}

# Step 20: Launch BetterStepsRecorder
$exePath = "$destination\BetterStepsRecorder.exe"
Write-Host "Launching BetterStepsRecorder..."
Start-Process -FilePath $exePath

# Step 21-22: Pin to Taskbar using TaskbarLib method
Write-Host "Attempting to pin BetterStepsRecorder to Taskbar..."
try {
    $pinScript = {
        param($path)
        $shell = New-Object -ComObject Shell.Application
        $folder = $shell.Namespace([System.IO.Path]::GetDirectoryName($path))
        $item = $folder.ParseName([System.IO.Path]::GetFileName($path))
        $verbs = $item.Verbs()
        $pinVerb = $verbs | Where-Object { $_.Name -match "Pin to tas&kbar" -or $_.Name -match "Pin to taskbar" }
        if ($pinVerb) {
            $pinVerb.DoIt()
            Write-Host "BetterStepsRecorder successfully pinned to Taskbar."
        } else {
            throw "Pin verb not found"
        }
    }
    & $pinScript $exePath
} catch {
    Write-Host ""
    Write-Host "-------------------------------------------------------------"
    Write-Host "Automatic taskbar pinning was unsuccessful on this system." -ForegroundColor Yellow
    Write-Host "Please pin manually:" -ForegroundColor Yellow
    Write-Host "  1. Locate BetterStepsRecorder in the Taskbar after launching" -ForegroundColor Yellow
    Write-Host "  2. Right-click the icon and select 'Pin to taskbar' [1]" -ForegroundColor Yellow
    Write-Host "-------------------------------------------------------------"
    Write-Host ""
}

Write-Host "Installation complete!"