# PowerShell Scripts for Minecraft Forge Projects
# Works with both Windows PowerShell and PowerShell Core
# Created, updated, and maintained by Jonathing
# Version 0.2.1

Set-Location ..\..

& '.\Scripts\PowerShell Scripts\internal\get_mod_name.ps1'
$MyProjectName = Get-Content '.\Scripts\PowerShell Scripts\internal\MODNAME'
Remove-Item '.\Scripts\PowerShell Scripts\internal\MODNAME'

# Set the title of the Windows PowerShell console
$MyPWSHTitle = $MyProjectName + ": IntelliJ IDEA Run Configurations"
[System.Console]::Title = $MyPWSHTitle

# Generate the IntelliJ IDEA run configs
$MyTask2Message = "Generating the IntelliJ IDEA run configurations for " + $MyProjectName + "..."
Write-Host $MyTaskMessage
Write-Host ""
.\gradlew genIntellijRuns --warning-mode none
Write-Host ""

$MyExitMessage = "Finished generating the IntelliJ IDEA run configurations for " + $MyProjectName + "."
Write-Host $MyExitMessage

Set-Location '.\Scripts\PowerShell Scripts\'
Pause
exit 0
