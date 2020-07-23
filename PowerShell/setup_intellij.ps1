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
$MCGradleTitle = $MCProjectName + ": IntelliJ IDEA Workspace"
[System.Console]::Title = $MCGradleTitle

# Inform user that IntelliJ set up is done by IntelliJ IDEA
$MCIntellijMessage1 = "The IntelliJ IDEA workspace for Forge is no longer set up through a command."
$MCIntellijMessage2 = "To import the project to IntelliJ IDEA, simply open " + [char]0x0022 + "build.gradle" + [char]0x0022 + " as a project."
$MCIntellijMessage3 = "Gradle will do the rest for you as it imports and indexes the project into IntelliJ."
Write-Host $MCIntellijMessage1
Write-Host $MCIntellijMessage2
Write-Host $MCIntellijMessage3
Write-Host ""

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
