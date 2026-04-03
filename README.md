# Install & Configure BetterStepsRecorder

## BetterStepsRecorder Installer

This repository contains a PowerShell installer script that automatically downloads, installs, configures, and launches the latest release of BetterStepsRecorder on Windows systems.

The script retrieves the most recent release from GitHub, installs required dependencies, places the application in Program Files, launches it, and pins it to the Windows taskbar.

---

## What This Script Does

When executed, Install & Configure BetterStepsRecorder.ps1 performs the following actions:

- Fetches the latest BetterStepsRecorder release from GitHub
- Downloads the release ZIP file
- Extracts the application files
- Copies the application to C:\Program Files\
- Downloads and installs the .NET 8 Desktop Runtime (x64)
- Launches BetterStepsRecorder.exe
- Pins BetterStepsRecorder to the Windows taskbar

All actions are performed automatically.

---

## Requirements

- Windows 10 or Windows 11
- PowerShell 5.1 or later
- Internet access
- Administrator privileges
- Ability to run PowerShell scripts

---

## Installation & Usage

### 1. Open PowerShell as Administrator

Right‑click PowerShell → Run as administrator

---

### 2. Allow Script Execution (Temporary)

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

This change applies only to the current PowerShell session.

---

### 3. Run the Installer Script

If running locally:

```powershell
.\Install & Configure BetterStepsRecorder.ps1
```

Because the file name contains spaces and an ampersand, using quotes or the call operator is recommended:

```powershell
& ".\Install & Configure BetterStepsRecorder.ps1"
```

---

## Installation Path

The application is installed to:

```
C:\Program Files\<ReleaseFolderName>\
```

The folder name is derived from the downloaded release ZIP.

---

## Dependencies

The script installs the following dependency automatically if needed:

- .NET 8 Desktop Runtime (Windows x64)

Downloaded from:
https://aka.ms/dotnet/8.0/windowsdesktop-runtime-win-x64.exe

Installation is performed silently using:

```
/quiet /norestart
```

---

## Security Notes

- The script requires administrator access to copy files into Program Files
- All downloads are performed over HTTPS
- The GitHub API is used to ensure the latest release is installed
- PowerShell error handling is set to fail fast:

```powershell
$ErrorActionPreference = "Stop"
```

---

## Known Limitations

- Taskbar pinning relies on a Windows Shell COM object and may be blocked by enterprise group policy
- The script does not currently support uninstall or upgrade‑in‑place scenarios
- No checksum or signature validation is performed on downloaded assets

---

## Uninstall

To remove BetterStepsRecorder:

1. Close the application
2. Delete the installation directory:

```
C:\Program Files\<ReleaseFolderName>
```

3. Optionally uninstall .NET 8 Desktop Runtime from Apps & Features

---

## Disclaimer

This script is provided as‑is, without warranty. Review the contents before execution, especially in managed or enterprise environments.

---

## License

GNU General Public License v3.0
