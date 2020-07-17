# PowerShell Scripts for Minecraft Forge Projects
# Works with both Windows PowerShell and PowerShell Core
# Created, updated, and maintained by Jonathing
# Version 0.2.1

Set-Location ..\..

& '.\Scripts\PowerShell Scripts\internal\get_mod_name.ps1'
$MyProjectName = Get-Content '.\Scripts\PowerShell Scripts\internal\MODNAME'
Remove-Item '.\Scripts\PowerShell Scripts\internal\MODNAME'

# Set the title of the Windows PowerShell or PowerShell Core console
$MyPWSHTitle = $MyProjectName + ": Build Project"
[System.Console]::Title = $MyPWSHTitle

# Build Blue Skies
$MyTaskMessage = "Building " + $MyProjectName + "..."
Write-Host $MyTaskMessage
Write-Host ""
.\gradlew build --warning-mode none
Write-Host ""

$MyExitMessage = "Finished building " + $MyProjectName + "."
Write-Host $MyExitMessage
$MyExitMessage2 = "If the build was successful, the output should be located under build\libs"
Write-Host $MyExitMessage2

Set-Location '.\Scripts\PowerShell Scripts\'
Pause
exit 0
