# Clear the screen
Clear-Host

$MCGradleAuthor = "Jonathing"
$MCGradleVersion = "0.4.1"

# Print script information
$MCGradleGreeting1 = "MCGradle Scripts (for Windows PowerShell and PowerShell Core)"
$MCGradleGreeting2 = "Version " + $MCGradleVersion
$MCGradleGreeting3 = "Written and Maintained by " + $MCGradleAuthor
Write-Host $MCGradleGreeting1
Write-Host $MCGradleGreeting2
Write-Host $MCGradleGreeting3
Write-Host ""

# Go to root project directory
Set-Location ..\..

# Check for update
& '.\Scripts\PowerShell Scripts\internal\check_update.ps1' $MCGradleVersion

# Get Forge mod name
& '.\Scripts\PowerShell Scripts\internal\get_mod_name.ps1'
$MCProjectName = Get-Content '.\Scripts\PowerShell Scripts\internal\MODNAME'
Remove-Item '.\Scripts\PowerShell Scripts\internal\MODNAME'

# Set the title of the Windows PowerShell or PowerShell Core console
$MCGradleTitle = $MCProjectName + ": Eclipse Run Configurations"
[System.Console]::Title = $MCGradleTitle

# Generate the Eclipse run configs
$MCTask2Message = "Generating the Eclipse run configurations for " + $MCProjectName + "..."
Write-Host $MCTask2Message
Write-Host ""
.\gradlew genEclipseRuns --warning-mode none
Write-Host ""
$MCExitMessage = "Finished generating the Eclipse run configurations."
Write-Host $MCExitMessage

# Return to scripts directory
Set-Location '.\Scripts\PowerShell Scripts\'

# END OF SCRIPT
Pause
Write-Host ""
exit 0
