:: Disable echoing commands onto the console
@ECHO off

if exist "MCGradle Scripts.ps1" (
    :: If PowerShell Core is installed, run the script on there. If not, run via Windows PowerShell.
    where /q pwsh
    IF ERRORLEVEL 1 (
        PowerShell -ExecutionPolicy Bypass -NoLogo -NoProfile -File ".\MCGradle Scripts.ps1" FromCMD
        if exist "HAS_UPDATED" (
            DEL /f HAS_UPDATED
            PowerShell -ExecutionPolicy Bypass -NoLogo -NoProfile -File ".\MCGradle Scripts.ps1" FromCMD
        )
    ) ELSE (
        pwsh -ExecutionPolicy Bypass -NoLogo -NoProfile -File ".\MCGradle Scripts.ps1" FromCMD
        if exist "HAS_UPDATED" (
            DEL /f HAS_UPDATED
            pwsh -ExecutionPolicy Bypass -NoLogo -NoProfile -File ".\MCGradle Scripts.ps1" FromCMD
        )
    )
) else (
    :: If PowerShell Core is installed, run the script on there. If not, run via Windows PowerShell.
    echo MCGradle Scripts was not found in this folder. Installing now...
    where /q pwsh
    IF ERRORLEVEL 1 (
        PowerShell -ExecutionPolicy Bypass -NoLogo -NoProfile -Command ". { Invoke-WebRequest -useb https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/master/updater/update.ps1 } | Invoke-Expression"
        if exist "MCGradle Scripts.ps1" (
            DEL /f HAS_UPDATED
            PowerShell -ExecutionPolicy Bypass -NoLogo -NoProfile -File ".\MCGradle Scripts.ps1" FromCMD
        )
    ) ELSE (
        pwsh -ExecutionPolicy Bypass -NoLogo -NoProfile -Command ". { Invoke-WebRequest -useb https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/master/updater/update.ps1 } | Invoke-Expression"
        if exist "MCGradle Scripts.ps1" (
            DEL /f HAS_UPDATED
            pwsh -ExecutionPolicy Bypass -NoLogo -NoProfile -File ".\MCGradle Scripts.ps1" FromCMD
        )
    )
)
