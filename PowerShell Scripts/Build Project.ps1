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
$MyPWSHTitle = $MyProjectName + ": Build Project"
[System.Console]::Title = $MyPWSHTitle

# Build the project
$MyTaskMessage = "Building " + $MyProjectName + "..."
Write-Host $MyTaskMessage
Write-Host ""
.\gradlew build --warning-mode none
Write-Host ""
$MyExitMessage = "Finished building " + $MyProjectName + "."
Write-Host $MyExitMessage
$MyExitMessage2 = "If the build was successful, the output should be located under build\libs"
Write-Host $MyExitMessage2

# Return to scripts directory
Set-Location '.\Scripts\PowerShell Scripts\'

# END OF SCRIPT
Pause
Write-Host ""
exit 0
