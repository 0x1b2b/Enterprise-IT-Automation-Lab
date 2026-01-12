# Bulk Active Directory User Provisioning

## Overview
This PowerShell script automates the creation of Active Directory users from a CSV file in a lab environment. Users are automatically placed into the `Restricted Users` OU and added to the `GG-Lab-Staff` group.

## Environment
- Windows Server 2025 (Domain Controller)
- Active Directory Module for PowerShell
- Domain-joined Windows 11 Client
- CSV input file: `users.csv`

## Usage
1. Place `bulk_user_create.ps1` and `users.csv` in the same folder.
2. Open PowerShell as Administrator on the Server 2025 VM.
3. Navigate to the folder:
```powershell
cd "C:\path\to\ActiveDirectory"
```
4. Run the script:
```powershell
.\bulk_user_create.ps1
```