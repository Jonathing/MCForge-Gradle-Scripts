:: Disable echoing commands onto the console
@ECHO off

if exist "MCGradle Scripts.ps1" (
    :: If PowerShell Core is installed, run the script on there. If not, run via Windows PowerShell.
    where /q pwsh
    IF ERRORLEVEL 1 (
        PowerShell -ExecutionPolicy Bypass -NoLogo -NoProfile -File ".\MCGradle Scripts.ps1" FromCMD
    ) ELSE (
        pwsh -ExecutionPolicy Bypass -NoLogo -NoProfile -File ".\MCGradle Scripts.ps1" FromCMD
    )
) else (
    :: If PowerShell Core is installed, run the script on there. If not, run via Windows PowerShell.
    echo MCGradle Scripts was not found in this folder. Installing now...
    where /q pwsh
    IF ERRORLEVEL 1 (
        PowerShell -ExecutionPolicy Bypass -NoLogo -NoProfile -Command ". { iwr -useb https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/update.ps1 } | iex"
        if exist "MCGradle Scripts.ps1" (
            PowerShell -ExecutionPolicy Bypass -NoLogo -NoProfile -File ".\MCGradle Scripts.ps1" FromCMD
        )
    ) ELSE (
        pwsh -ExecutionPolicy Bypass -NoLogo -NoProfile -Command ". { iwr -useb https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/update.ps1 } | iex"
        if exist "MCGradle Scripts.ps1" (
            pwsh -ExecutionPolicy Bypass -NoLogo -NoProfile -File ".\MCGradle Scripts.ps1" FromCMD
        )
    )
)
