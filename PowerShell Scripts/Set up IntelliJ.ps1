# Get arguments
$MCGradleArg = $args[0]

if ($MCGradleArg -ne "FromHub")
{
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

Write-Host ""
exit 0
