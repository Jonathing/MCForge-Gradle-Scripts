$MyPWSHAuthor = "Jonathing"
$MyPWSHVersion = "0.4.0"

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
& '.\Scripts\PowerShell Scripts\internal\check_update.ps1'
$PWSHUpdateFile = '.\Scripts\PowerShell Scripts\internal\PWSHVERSION'
if (Test-Path $PWSHUpdateFile -PathType Leaf)
{
    $NewPWSHVersion = Get-Content '.\Scripts\PowerShell Scripts\internal\PWSHVERSION'
    Remove-Item '.\Scripts\PowerShell Scripts\internal\PWSHVERSION'
    if ($NewPWSHVersion -ne $MyPWSHVersion)
    {
        $MyPWSHUpdateMsg1 = "An update is available for MCGradle Scripts! The latest version is " + $NewPWSHVersion
        $MyPWSHUpdateMsg2 = "To update, read " + [char]0x0022 + "UPDATE.md" + [char]0x0022 + " on how to update the submodule in your repository."
        Write-Host $MyPWSHUpdateMsg1
        Write-Host $MyPWSHUpdateMsg2
        Write-Host ""
    }
}

# Get Forge mod name
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

# Generate the Eclipse run configs
$MyTask2Message = "Generating the Eclipse run configurations for " + $MyProjectName + "..."
Write-Host $MyTask2Message
Write-Host ""
.\gradlew genEclipseRuns --warning-mode none
Write-Host ""
$MyExitMessage = "Initial set up for Eclipse complete."
Write-Host $MyExitMessage
$MyExitMessage2 = "If you need to generate the run configurations again, run the " + [char]0x0022 + "Make Eclipse Runs.ps1" + [char]0x0022 + " script."
Write-Host $MyExitMessage2

# Return to scripts directory
Set-Location '.\Scripts\PowerShell Scripts\'

# END OF SCRIPT
Pause
Write-Host ""
exit 0
