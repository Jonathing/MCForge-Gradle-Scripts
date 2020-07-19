# Clear the screen
Clear-Host

$MyPWSHAuthor = "Jonathing"
$MyPWSHVersion = "0.4.1"

# Print script information
$MyPWSHGreeting1 = "MCGradle Scripts (for Windows PowerShell and PowerShell Core)"
$MyPWSHGreeting2 = "Version " + $MyPWSHVersion
$MyPWSHGreeting3 = "Written and Maintained by " + $MyPWSHAuthor
Write-Host $MyPWSHGreeting1
Write-Host $MyPWSHGreeting2
Write-Host $MyPWSHGreeting3
Write-Host ""

# Go to root project directory
Set-Location ..\..

# Check for update
& '.\Scripts\PowerShell Scripts\internal\check_update.ps1' $MyPWSHVersion

# Get Forge mod name
& '.\Scripts\PowerShell Scripts\internal\get_mod_name.ps1'
$MyProjectName = Get-Content '.\Scripts\PowerShell Scripts\internal\MODNAME'
Remove-Item '.\Scripts\PowerShell Scripts\internal\MODNAME'

# Set the title of the Windows PowerShell or PowerShell Core console
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

# Return to scripts directory
Set-Location '.\Scripts\PowerShell Scripts\'

# END OF SCRIPT
Pause
Write-Host ""
exit 0
