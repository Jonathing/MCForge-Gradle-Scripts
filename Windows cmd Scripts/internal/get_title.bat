PowerShell -ExecutionPolicy Bypass -NoLogo -NoProfile -File "Scripts\PowerShell Scripts\internal\get_mod_name.ps1"
SET /p MyProjectName=<"Scripts\PowerShell Scripts\internal\MODNAME"
DEL "Scripts\PowerShell Scripts\internal\MODNAME"
SET "PWSHPOLICY=1"