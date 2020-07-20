:: Disable echoing commands onto the console
@ECHO off

:: Run the PowerShell script
PowerShell -ExecutionPolicy Bypass -NoLogo -NoProfile -File "..\PowerShell\setup_eclipse.ps1" FromCMD
