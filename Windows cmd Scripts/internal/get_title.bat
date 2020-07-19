:: Run the PowerShell script to get the mod name from mods.toml
PowerShell -ExecutionPolicy Bypass -NoLogo -NoProfile -File "Scripts\PowerShell Scripts\internal\get_mod_name.ps1"

:: Get the mod name from the temporary file created by the script
SET /p MyProjectName=<"Scripts\PowerShell Scripts\internal\MODNAME"

:: Delete the temporary file
DEL "Scripts\PowerShell Scripts\internal\MODNAME"