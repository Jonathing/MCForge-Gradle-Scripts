# PowerShell Scripts for Minecraft Forge Projects
# Works with both Windows PowerShell and PowerShell Core
# Created, updated, and maintained by Jonathing
# Version 0.2.1

Set-Location ..\..

& '.\Scripts\PowerShell Scripts\internal\get_mod_name.ps1'
$MyProjectName = Get-Content '.\Scripts\PowerShell Scripts\internal\MODNAME'
Remove-Item '.\Scripts\PowerShell Scripts\internal\MODNAME'

# Set the title of the Windows PowerShell console
$MyPWSHTitle = $MyProjectName + ": IntelliJ IDEA Workspace"
[System.Console]::Title = $MyPWSHTitle

$MyIntellijMessage1 = "The IntelliJ IDEA workspace for Forge is no longer set up through a command."
$MyIntellijMessage2 = "To import the project to IntelliJ IDEA, simply open the " + [char]0x0022 + "build.gradle" + [char]0x0022 + " file as a project."
$MyIntellijMessage3 = "Gradle will do the rest for you as it imports and indexes the project into IntelliJ."

Write-Host $MyIntellijMessage1
Write-Host $MyIntellijMessage2
Write-Host $MyIntellijMessage3
Write-Host ""

Set-Location '.\Scripts\PowerShell Scripts\'

Pause
exit 0
