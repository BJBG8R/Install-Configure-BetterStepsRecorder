# Install & Configure BetterStepsRecorder

## BetterStepsRecorder Installer

This repository contains a PowerShell installer script that automatically downloads, installs, configures, and launches the latest release of BetterStepsRecorder on Windows systems.

The script retrieves the most recent release from GitHub, installs required dependencies, places the application in **Program Files**, launches it, and pins it to the Windows taskbar.

---

## What This Script Does

When executed, **Install & Configure BetterStepsRecorder.ps1** performs the following actions:

- Fetches the latest BetterStepsRecorder release from GitHub
- Downloads the release ZIP file
- Extracts the application files
- Copies the application to `C:\Program Files\`
- Downloads and installs the **.NET 8 Desktop Runtime (x64)**
- Launches `BetterStepsRecorder.exe`
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

Right‑click **PowerShell** → **Run as administrator**

---

### 2. Allow Script Execution (Temporary)

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
