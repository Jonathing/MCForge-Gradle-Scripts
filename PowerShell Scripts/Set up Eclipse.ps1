# Get arguments
$MCGradleArg = $args[0]

if ($MCGradleArg -ne "FromHub")
{
    # Clear the screen
    Clear-Host

    $MCGradleAuthor = "Jonathing"
    $MCGradleVersion = "0.5.0"

    # Get current PowerShell title (Windows Only)
    if ($PSVersionTable.Platform -eq "Win32NT")
    {
        $MCCurrentTitle = [System.Console]::Title
    }

    # Print script information
    $MCGradleGreeting1 = "MCGradle Scripts"
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
}

# Set the title of the Windows PowerShell console
$MCGradleTitle = $MCProjectName + ": Eclipse Workspace"
[System.Console]::Title = $MCGradleTitle

# Set up the initial Eclipse workspace
$MCTaskMessage = "Setting up the initial Eclipse workspace for " + $MCProjectName + "..."
Write-Host $MCTaskMessage
Write-Host ""
.\gradlew eclipse --warning-mode none
Write-Host""

# Generate the Eclipse run configs
$MCTask2Message = "Generating the Eclipse run configurations for " + $MCProjectName + "..."
Write-Host $MCTask2Message
Write-Host ""
.\gradlew genEclipseRuns --warning-mode none
Write-Host ""
$MCExitMessage = "Initial set up for Eclipse complete."
Write-Host $MCExitMessage
$MCExitMessage2 = "If you need to generate the run configurations again, run the " + [char]0x0022 + "Make Eclipse Runs.ps1" + [char]0x0022 + " script."
Write-Host $MCExitMessage2

if ($MCGradleArg -ne "FromHub")
{
    # Return to scripts directory
    Set-Location '.\Scripts\PowerShell Scripts\'
}

# END OF SCRIPT
Pause

if ($MCGradleArg -eq "FromHub")
{
    # Set the title of the Windows PowerShell or PowerShell Core console
    $MCGradleTitle = $MCProjectName + ": MCGradle Scripts Hub"
    [System.Console]::Title = $MCGradleTitle
}
else
{
    # Revert PowerShell title (Windows Only)
    if ($PSVersionTable.Platform -eq "Win32NT")
    {
        [System.Console]::Title = $MCCurrentTitle
    }
    else
    {
        [System.Console]::Title = ""
    }
}

Write-Host ""
exit 0
