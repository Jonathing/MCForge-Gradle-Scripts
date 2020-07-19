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
$MyPWSHTitle = $MyProjectName + ": IntelliJ IDEA Workspace"
[System.Console]::Title = $MyPWSHTitle

# Inform user that IntelliJ set up is done by IntelliJ IDEA
$MyIntellijMessage1 = "The IntelliJ IDEA workspace for Forge is no longer set up through a command."
$MyIntellijMessage2 = "To import the project to IntelliJ IDEA, simply open " + [char]0x0022 + "build.gradle" + [char]0x0022 + " as a project."
$MyIntellijMessage3 = "Gradle will do the rest for you as it imports and indexes the project into IntelliJ."
Write-Host $MyIntellijMessage1
Write-Host $MyIntellijMessage2
Write-Host $MyIntellijMessage3
Write-Host ""

# Return to scripts directory
Set-Location '.\Scripts\PowerShell Scripts\'

# END OF SCRIPT
Pause
Write-Host ""
exit 0
