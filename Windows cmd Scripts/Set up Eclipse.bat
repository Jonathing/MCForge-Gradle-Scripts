:: Disable echoing commands onto the console
@ECHO off

:: Run the PowerShell script
PowerShell -ExecutionPolicy Bypass -NoLogo -NoProfile -File "..\PowerShell Scripts\Set up Eclipse.ps1" FromCMD
