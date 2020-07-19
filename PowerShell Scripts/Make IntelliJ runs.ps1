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
$MCGradleTitle = $MCProjectName + ": IntelliJ IDEA Run Configurations"
[System.Console]::Title = $MCGradleTitle

# Generate the IntelliJ IDEA run configs
$MCTask2Message = "Generating the IntelliJ IDEA run configurations for " + $MCProjectName + "..."
Write-Host $MCTaskMessage
Write-Host ""
.\gradlew genIntellijRuns --warning-mode none
Write-Host ""
$MCExitMessage = "Finished generating the IntelliJ IDEA run configurations for " + $MCProjectName + "."
Write-Host $MCExitMessage

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
