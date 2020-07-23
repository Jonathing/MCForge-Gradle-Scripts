# Clear the screen
Clear-Host

# Get arguments
$MCGradleArg = $args[0]

# Get PowerShell version
if ($PSVersionTable.PSVersion.Major -le 5)
{
    $MCGradlePlatform = "Windows PowerShell"
}
else
{
    $MCGradlePlatform = "PowerShell Core"
}

if ($MCGradleArg -eq "FromCMD")
{
    $MCGradlePlatform += " via Windows Command Prompt"
}

# Get current PowerShell title (Windows Only)
if ($PSVersionTable.Platform -eq "Win32NT")
{
    $MCCurrentTitle = [System.Console]::Title
}

# Set the title of the Windows PowerShell or PowerShell Core console
$MCGradleTitle = "MCGradle Scripts"
[System.Console]::Title = $MCGradleTitle

$MCGradleAuthor = "Jonathing"
$MCGradleVersion = "0.5.3"

# Print script information
$MCGradleGreeting1 = "MCGradle Scripts by " + $MCGradleAuthor
$MCGradleGreeting2 = "Version " + $MCGradleVersion
Write-Host $MCGradleGreeting1
Write-Host $MCGradleGreeting2
Write-Host ""

# Check for update
. .\PowerShell\internal\check_update.ps1 $MCGradleVersion "FromHub"

if ($MCHubUpdVer -ne $MCGradleVersion)
{
    $MCWantsToUpdate = 0
    $MCHasUpdated = 0
    $MCGradleUpdateMsg1 = "An update is available for MCGradle Scripts! The latest version is " + $MCHubUpdVer
    Write-Host $MCGradleUpdateMsg1 -ForegroundColor Green
    do
    {
        Write-Host "Would you like to update now? This might take some time. [ y/N ] " -ForegroundColor Yellow -NoNewline
        $Readhost = Read-Host
        Switch ($ReadHost)
        {
            Y { $MCHasChosen = 1; $MCWantsToUpdate = 1 }
            N { $MCHasChosen = 1 }
            Default { $MCHasChosen = 0 }
        }

        Write-Host ""

        if ($MCHasChosen -eq 0)
        {
            Write-Host "That's not a valid option." -ForegroundColor Yellow
        }
    }
    while ($MCHasChosen -eq 0)

    if ($MCWantsToUpdate -eq 1)
    {
        Write-Host "We want to update."

        $MCOldPreference = $ErrorActionPreference
        $ErrorActionPreference = "SilentlyContinue"

        if (Get-Command git)
        {
            # Set the title of the Windows PowerShell or PowerShell Core console
            $MCGradleTitle = "Updating MCGradle Scripts..."
            [System.Console]::Title = $MCGradleTitle

            Write-Host "Downloading MCGradle Scripts..."
            git clone https://github.com/Jonathing/MCGradle-Scripts.git update -q

            Write-Host "Installing MCGradle Scripts..."
            Remove-Item -Force -Recurse '.\Windows\'
            Remove-Item -Force -Recurse '.\PowerShell\'
            Remove-Item -Force -Recurse '.\bash\'
            Remove-Item -Force '.\MCGradle Scripts.bat'
            Remove-Item -Force '.\MCGradle Scripts.ps1'
            Remove-Item -Force '.\MCGradle Scripts.sh'
            Remove-Item -Force '.\CHANGELOG.md'
            Remove-Item -Force '.\README.md'
            Remove-Item -Force '.\UPDATE.md'
            Remove-Item -Force '.\.gitignore'

            Move-Item -Force '.\update\Windows\' '.\Windows\'
            Move-Item -Force '.\update\PowerShell\' '.\PowerShell\'
            Move-Item -Force '.\update\bash\' '.\bash\'
            Move-Item -Force '.\update\MCGradle Scripts.bat' '.\MCGradle Scripts.bat'
            Move-Item -Force '.\update\MCGradle Scripts.ps1' '.\MCGradle Scripts.ps1'
            Move-Item -Force '.\update\MCGradle Scripts.sh' '.\MCGradle Scripts.sh'
            Move-Item -Force '.\update\CHANGELOG.md' '.\CHANGELOG.md'
            Move-Item -Force '.\update\README.md' '.\README.md'
            Move-Item -Force '.\update\UPDATE.md' '.\UPDATE.md'
            Move-Item -Force '.\update\.gitignore' '.\.gitignore'

            Write-Host "Cleaning up..."
            Remove-Item -Force -Recurse .\update\

            Write-Host ""
            Write-Host "MCGradle Scripts has been successfully updated!"
            Write-Host "Restarting MCGradle Scripts..."

            Start-Sleep -s 3

            $MCHasUpdated = 1

            & '.\MCGradle Scripts.ps1'
        }
        else
        {
            Write-Host "We weren't able to find git on your system!"
            Write-Host "MCGradle Scripts will not be able to update."
            Write-Host ""
        }

        $ErrorActionPreference = $MCOldPreference
    }
    else
    {
        Write-Host "You have decided not to update MCGradle Scripts."
        Write-Host "If you change your mind, run the main script again."
        Write-Host "Continuing to the hub..."
        Write-Host ""
    }
}

if ($MCHasUpdated -ne 1)
{
    # Go to root project directory
    Set-Location ..

    # Get Forge mod name
    & '.\Scripts\PowerShell\internal\get_mod_name.ps1'
    $MCProjectName = Get-Content '.\Scripts\PowerShell\internal\MODNAME'
    Remove-Item '.\Scripts\PowerShell\internal\MODNAME'

    # Set the title of the Windows PowerShell or PowerShell Core console
    $MCGradleTitle = $MCProjectName + ": MCGradle Scripts Hub"
    [System.Console]::Title = $MCGradleTitle

    $MCGradleOptionInfo1 = "Gradle Commands"
    $MCGradleOption1 = "1. Build " + $MCProjectName
    $MCGradleOption2 = "2. Set up your Eclipse workspace"
    $MCGradleOption3 = "3. Set up your IntelliJ IDEA workspace"
    $MCGradleOption4 = "4. Generate the Eclipse run configurations"
    $MCGradleOption5 = "5. Generate the IntelliJ IDEA run configurations"
    $MCGradleOption6 = "6. Do a full cleanup of the workspace"
    $MCGradleOptionInfo2 = "MCGradle Scripts Options"
    $MCGradleOptionC = "C. Clear the screen"
    $MCGradleOptionR = "R. Show the options again"
    $MCGradleOptionA = "A. About MCGradle Scripts"
    $MCGradleOptionQ = "Q. Quit MCGradle Scripts"
    Write-Host "What would you like to do today?"
    Write-Host ""
    $MCShowOptionsAgain = 1

    do
    {
        do
        {
            if ($MCShowOptionsAgain -eq 1)
            {
                Write-Host $MCGradleOptionInfo1
                Write-Host $MCGradleOption1
                Write-Host $MCGradleOption2
                Write-Host $MCGradleOption3
                Write-Host $MCGradleOption4
                Write-Host $MCGradleOption5
                Write-Host $MCGradleOption6
                Write-Host ""
                Write-Host $MCGradleOptionInfo2
                Write-Host $MCGradleOptionC
                Write-Host $MCGradleOptionR
                Write-Host $MCGradleOptionA
                Write-Host $MCGradleOptionQ
                Write-Host ""
            }
            else
            {
                Write-Host "Press R to see the options again." -ForegroundColor Yellow
            }
            $MCShowOptionsAgain = 0
            Write-Host "Please pick an option [ 1-6, R, Q, ... ] " -ForegroundColor Yellow -NoNewline
            $Readhost = Read-Host
            Switch ($ReadHost)
            { 
                1 { $MCHasChosen = 1; $MCGradleCommand = 1 }
                2 { $MCHasChosen = 1; $MCGradleCommand = 2 }
                3 { $MCHasChosen = 1; $MCGradleCommand = 3 }
                4 { $MCHasChosen = 1; $MCGradleCommand = 4 }
                5 { $MCHasChosen = 1; $MCGradleCommand = 5 }
                6 { $MCHasChosen = 1; $MCGradleCommand = 6 }
                C { $MCHasChosen = 1; $MCGradleCommand = 97; $MCShowOptionsAgain = 1 }
                A { $MCHasChosen = 1; $MCGradleCommand = 98 }
                Q { $MCHasChosen = 1; $MCGradleCommand = 99 }
                R { $MCHasChosen = 0; $MCShowOptionsAgain = 1 }
                Default { $MCHasChosen = 0; $MCGradleCommand = 0 }
            }

            Write-Host ""

            if ($MCHasChosen -eq 0 -And $MCShowOptionsAgain -eq 0)
            {
                Write-Host "That's not a valid option." -ForegroundColor Yellow
            }
        }
        while ($MCHasChosen -eq 0)

        Switch ($MCGradleCommand)
        {
            1 { & '.\Scripts\PowerShell\build.ps1' "FromHub" }
            2 { & '.\Scripts\PowerShell\setup_eclipse.ps1' "FromHub" }
            3 { & '.\Scripts\PowerShell\setup_intellij.ps1' "FromHub" }
            4 { & '.\Scripts\PowerShell\genEclipseRuns.ps1' "FromHub" }
            5 { & '.\Scripts\PowerShell\genIntellijRuns.ps1' "FromHub" }
            6 { & '.\Scripts\PowerShell\full_clean.ps1' "FromHub" }
            97 { Clear-Host }
            98
            {
                $MCGradleAbout1 = "MCGradle Scripts"
                $MCGradleAbout2 = "Written and Maintained by " + $MCGradleAuthor
                $MCGradlePlatformMsg = "Running on " + $MCGradlePlatform

                $MCGradleThanks1 = "Original Windows batch scripts written by Bailey (KingPhygieBoo)"

                Write-Host $MCGradleAbout1
                Write-Host $MCGradleGreeting2
                Write-Host $MCGradlePlatformMsg
                Write-Host $MCGradleAbout2
                Write-Host ""
                Write-Host $MCGradleThanks1
                Write-Host ""

                Pause

                Write-Host ""
            }
            99 { Write-Host "Quitting MCGradle Scripts..." -ForegroundColor Red }
            Default { Write-Host "An error has occured." -ForegroundColor Red }
        }
    }
    while ($MCGradleCommand -ne 99)

    # Return to scripts directory
    Set-Location .\Scripts\

    # Revert PowerShell title (Windows Only)
    if ($PSVersionTable.Platform -eq "Win32NT")
    {
        [System.Console]::Title = $MCCurrentTitle
    }
    else
    {
        [System.Console]::Title = ""
    }

    Write-Host ""
}

exit 0
