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
    $MCGradleVersion = "0.5.0"

    # Print script information
    $MCGradleGreeting1 = "MCGradle Scripts by " + $MCGradleAuthor
    $MCGradleGreeting2 = "Version " + $MCGradleVersion
    Write-Host $MCGradleGreeting1
    Write-Host $MCGradleGreeting2
    Write-Host ""

    # Go to root project directory
    Set-Location ..\..

    # Check for update
    & '.\Scripts\PowerShell\internal\check_update.ps1' $MCGradleVersion

    # Get Forge mod name
    & '.\Scripts\PowerShell\internal\get_mod_name.ps1'
    $MCProjectName = Get-Content '.\Scripts\PowerShell\internal\MODNAME'
    Remove-Item '.\Scripts\PowerShell\internal\MODNAME'
}

# Set the title of the Windows PowerShell or PowerShell Core console
$MCGradleTitle = $MCProjectName + ": Build Project"
[System.Console]::Title = $MCGradleTitle

# Build the project
$MCTaskMessage = "Building " + $MCProjectName + "..."
Write-Host $MCTaskMessage
Write-Host ""
.\gradlew build --warning-mode none
Write-Host ""
$MCExitMessage = "Finished building " + $MCProjectName + "."
Write-Host $MCExitMessage
$MCExitMessage2 = "If the build was successful, the output should be located under build\libs"
Write-Host $MCExitMessage2

if ($MCGradleArg -ne "FromHub")
{
    # Return to scripts directory
    Set-Location '.\Scripts\PowerShell\'
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
