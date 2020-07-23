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
$MCGradleTitle = $MCProjectName + ": Clean Up Workspace"
[System.Console]::Title = $MCGradleTitle

Write-Host "WARNING: THIS ACTION WILL DELETE YOUR BUILD FOLDER, ECLIPSE/INTELLIJ WORKSPACE, AND ANY RUN CONFIGURATIONS!" -ForegroundColor Yellow
Write-Host "THE RUN FOLDER WILL NOT BE DELETED BECAUSE IT IS NOT REQUIRED FOR A FULL CLEANUP." -ForegroundColor Yellow
Write-Host "ARE YOU SURE YOU WANT TO DO THIS?" -ForegroundColor Yellow -NoNewline
Write-Host " THIS ACTION CANNOT BE UNDONE! " -ForegroundColor RED -NoNewline
Write-Host "[ y/N ] " -ForegroundColor Yellow -NoNewline
$Readhost = Read-Host
Switch ($ReadHost)
{
    Y { $MCHasConfirmed = 1}
    Default { $MCHasConfirmed = 0}
}

if ($MCHasConfirmed -eq 1)
{
    Write-Host ""

    # Delete all run configs for eclipse
    Write-Host "Deleting Eclipse run configs and other cache files..."
    Remove-Item '.\*.launch'
    if (Test-Path -Path './.settings' -Type Container) { Remove-Item -Force -Recurse './.settings' }

    # Delete IntelliJ IDEA run configs and other build files
    Write-Host "Deleting IntelliJ IDEA run configs and other cache files..."
    if (Test-Path -Path './.idea/runConfigurations' -Type Container) { Remove-Item -Recurse './.idea/runConfigurations' }
    if (Test-Path -Path './out' -Type Container) { Remove-Item -Recurse './out' }
    if (Test-Path -Path './.idea/modules' -Type Container) { Remove-Item -Recurse './.idea/modules' }
    if (Test-Path -Path './.idea/$CACHE_FILE$' -Type Leaf) { Remove-Item './.idea/$CACHE_FILE$' }
    if (Test-Path -Path './.idea/*.xml' -Type Leaf) { Remove-Item './.idea/*.xml' }
    if (Test-Path -Path './.idea/.name' -Type Leaf) { Remove-Item './.idea/.name' }
    if (Test-Path -Path './*.ipr' -Type Leaf) { Remove-Item './*.ipr' }
    if (Test-Path -Path './*.iws' -Type Leaf) { Remove-Item './*.iws' }
    if (Test-Path -Path './*.iml' -Type Leaf) { Remove-Item './*.iml' }

    $MCHasBuildFolder = 0
    $MCHasEclipse = 0

    if (Test-Path -Path './build' -Type Container)
    {
        $MCHasBuildFolder = 1
    }
    
    if (Test-Path -Path './.classpath' -Type Leaf)
    {
        $MCHasEclipse = 1
    }

    if ($MCHasBuildFolder -eq 1 -And $MCHasEclipse -eq 1)
    {
        # Delete the folders via Gradle
        $MCTaskMessage = "Calling Gradle to clean up the Eclipse workspace and build output..."
        Write-Host $MCTaskMessage
        Write-Host ""
        .\gradlew clean cleanEclipse --warning-mode none
        [System.Console]::Title = $MCGradleTitle
        Write-Host ""
    }
    elseif ($MCHasBuildFolder -eq 1)
    {
        # Delete the build folder via Gradle
        $MCTaskMessage = "Calling Gradle to clean up the build output..."
        Write-Host $MCTaskMessage
        Write-Host ""
        .\gradlew clean --warning-mode none
        [System.Console]::Title = $MCGradleTitle
        Write-Host ""
    }
    elseif ($MCHasEclipse -eq 1)
    {
        # Delete the eclipse folder via Gradle
        $MCTaskMessage = "Calling Gradle to clean up the Eclipse workspace..."
        Write-Host $MCTaskMessage
        Write-Host ""
        .\gradlew cleanEclipse --warning-mode none
        [System.Console]::Title = $MCGradleTitle
        Write-Host ""
    }
    else
    {
        # EMPTY METHOD
    }

    # END OF SCRIPT
    Pause
}

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
