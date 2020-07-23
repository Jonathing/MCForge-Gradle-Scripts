# Get arguments
$MCGradleArg = $args[0]

if ($MCGradleArg -ne "FromHub")
{
    # Clear the screen
    Clear-Host

    # Get current PowerShell title (Windows Only)
    if ($PSVersionTable.Platform -eq "Win32NT")
    {
        $MCCurrentTitle = [System.Console]::Title
    }
    
    $MCGradleAuthor = "Jonathing"
    $MCGradleVersion = "0.5.3"

    # Print script information
    $MCGradleGreeting1 = "MCGradle Scripts by " + $MCGradleAuthor
    $MCGradleGreeting2 = "Version " + $MCGradleVersion
    Write-Host $MCGradleGreeting1
    Write-Host $MCGradleGreeting2
    Write-Host ""

    # Check for update
    Set-Location ..
    & '.\PowerShell\internal\check_update.ps1' $MCGradleVersion

    # Go to root project directory
    Set-Location ..

    # Get Forge mod name
    & '.\Scripts\PowerShell\internal\get_mod_name.ps1'
    $MCProjectName = Get-Content '.\Scripts\PowerShell\internal\MODNAME'
    Remove-Item '.\Scripts\PowerShell\internal\MODNAME'
}

# Set the title of the Windows PowerShell console
$MCGradleTitle = $MCProjectName + ": Eclipse Workspace"
[System.Console]::Title = $MCGradleTitle

# Set up the initial Eclipse workspace
$MCTaskMessage = "Setting up the initial Eclipse workspace for " + $MCProjectName + "..."
Write-Host $MCTaskMessage
Write-Host ""
.\gradlew eclipse --warning-mode none
[System.Console]::Title = $MCGradleTitle
Write-Host ""

# Generate the Eclipse run configs
$MCTask2Message = "Generating the Eclipse run configurations for " + $MCProjectName + "..."
Write-Host $MCTask2Message
Write-Host ""
.\gradlew genEclipseRuns --warning-mode none
[System.Console]::Title = $MCGradleTitle
Write-Host ""
$MCExitMessage = "Initial set up for Eclipse complete."
Write-Host $MCExitMessage
$MCExitMessage2 = "If you need to generate the run configurations again, run the " + [char]0x0022 + "Make Eclipse Runs.ps1" + [char]0x0022 + " script."
Write-Host $MCExitMessage2

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
    Write-Host "Quitting MCGradle Scripts..." -ForegroundColor Red

    # Return to scripts directory
    if ($MCGradleArg -eq "FromCMD")
    {
        Set-Location '.\Scripts\Windows\'
    }
    else
    {
        Set-Location '.\Scripts\PowerShell\'
    }
    
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

if ($MCGradleArg -ne "FromCMD")
{
    Write-Host ""
}
exit 0
