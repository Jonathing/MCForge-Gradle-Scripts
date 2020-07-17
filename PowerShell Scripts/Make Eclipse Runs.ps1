# PowerShell Scripts for Minecraft Forge Projects
# Works with both Windows PowerShell and PowerShell Core
# Created, updated, and maintained by Jonathing
# Version 0.2.1

Set-Location ..\..

& '.\Scripts\PowerShell Scripts\internal\get_mod_name.ps1'
$MyProjectName = Get-Content '.\Scripts\PowerShell Scripts\internal\MODNAME'
Remove-Item '.\Scripts\PowerShell Scripts\internal\MODNAME'

# Set the title of the Windows PowerShell console
$MyPWSHTitle = $MyProjectName + ": Eclipse Run Configurations"
[System.Console]::Title = $MyPWSHTitle

# Generate the Eclipse run configs
$MyTask2Message = "Generating the Eclipse run configurations for " + $MyProjectName + "..."
Write-Host $MyTask2Message
Write-Host ""
.\gradlew genEclipseRuns --warning-mode none
Write-Host ""

$MyExitMessage = "Finished generating the Eclipse run configurations."
Write-Host $MyExitMessage

Set-Location '.\Scripts\PowerShell Scripts\'
Pause
exit 0
