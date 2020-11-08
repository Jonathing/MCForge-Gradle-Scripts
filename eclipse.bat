:: Disable echoing commands onto the console
@ECHO off

:: If PowerShell Core is installed, run the script on there. If not, run via Windows PowerShell.
where /q pwsh
IF ERRORLEVEL 1 (
    PowerShell -ExecutionPolicy Bypass -NoLogo -NoProfile -File ".\MCGradle Scripts.ps1" FromCMD eclipse
) ELSE (
    pwsh -ExecutionPolicy Bypass -NoLogo -NoProfile -File ".\MCGradle Scripts.ps1" FromCMD eclipse
)
