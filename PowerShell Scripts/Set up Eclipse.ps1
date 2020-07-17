# PowerShell Scripts for Minecraft Forge Projects
# Works with both Windows PowerShell and PowerShell Core
# Created, updated, and maintained by Jonathing
# Version 0.2.1

Set-Location ..\..

& '.\Scripts\PowerShell Scripts\internal\get_mod_name.ps1'
$MyProjectName = Get-Content '.\Scripts\PowerShell Scripts\internal\MODNAME'
Remove-Item '.\Scripts\PowerShell Scripts\internal\MODNAME'

# Set the title of the Windows PowerShell console
$MyPWSHTitle = $MyProjectName + ": Eclipse Workspace"
[System.Console]::Title = $MyPWSHTitle

# Set up the initial Eclipse workspace
$MyTaskMessage = "Setting up the initial Eclipse workspace for " + $MyProjectName + "..."
Write-Host $MyTaskMessage
Write-Host ""
.\gradlew eclipse --warning-mode none
Write-Host""

# Generate the Eclipse run configurations...
$MyTask2Message = "Generating the Eclipse run configurations for " + $MyProjectName + "..."
Write-Host $MyTask2Message
Write-Host ""
.\gradlew genEclipseRuns --warning-mode none
Write-Host ""

$MyExitMessage = "Initial set up for Eclipse complete."
Write-Host $MyExitMessage
$MyExitMessage2 = "If you need to generate the run configurations again, run the " + [char]0x0022 + "Make Eclipse Runs.ps1" + [char]0x0022 + " script."
Write-Host $MyExitMessage2

Set-Location '.\Scripts\PowerShell Scripts\'
Pause
exit 0
