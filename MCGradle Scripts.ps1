# Clear the screen
Clear-Host

# Get arguments
$MCGradleArg = $args[0]

$MCGradleAuthor = "Jonathing"
$MCGradleVersion = "0.4.1"

# Print script information
$MCGradleGreeting1 = "MCGradle Scripts"
$MCGradleGreeting2 = "Version " + $MCGradleVersion
$MCGradleGreeting3 = "Written and Maintained by " + $MCGradleAuthor
Write-Host $MCGradleGreeting1
Write-Host $MCGradleGreeting2
Write-Host $MCGradleGreeting3
Write-Host ""

# Go to root project directory
Set-Location ..

# Check for update
& '.\Scripts\PowerShell Scripts\internal\check_update.ps1' $MCGradleVersion

# Get Forge mod name
& '.\Scripts\PowerShell Scripts\internal\get_mod_name.ps1'
$MCProjectName = Get-Content '.\Scripts\PowerShell Scripts\internal\MODNAME'
Remove-Item '.\Scripts\PowerShell Scripts\internal\MODNAME'

# Set the title of the Windows PowerShell or PowerShell Core console
$MCGradleTitle = $MCProjectName + ": MCGradle Scripts Hub"
[System.Console]::Title = $MCGradleTitle

$MCGradleOptionInfo1 = "Gradle Commands"
$MCGradleOption1 = "1. Build " + $MCProjectName
$MCGradleOption2 = "2. Set up your Eclipse workspace"
$MCGradleOption3 = "3. Set up your IntelliJ IDEA workspace"
$MCGradleOption4 = "4. Generate the Eclipse run configurations"
$MCGradleOption5 = "5. Generate the IntelliJ IDEA run configurations"
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
        Write-Host "Please pick an option [ 1-5, R, Q, ... ] " -ForegroundColor Yellow -NoNewline
        $Readhost = Read-Host
        Switch ($ReadHost)
        { 
            1 { $MCHasChosen = 1; $MCGradleCommand = 1 }
            2 { $MCHasChosen = 1; $MCGradleCommand = 2 }
            3 { $MCHasChosen = 1; $MCGradleCommand = 3 }
            4 { $MCHasChosen = 1; $MCGradleCommand = 4 }
            5 { $MCHasChosen = 1; $MCGradleCommand = 5 }
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
        1 { & '.\Scripts\PowerShell Scripts\Build Project.ps1' "FromHub" }
        2 { & '.\Scripts\PowerShell Scripts\Set up Eclipse.ps1' "FromHub" }
        3 { & '.\Scripts\PowerShell Scripts\Set up IntelliJ.ps1' "FromHub" }
        4 { & '.\Scripts\PowerShell Scripts\Make Eclipse Runs.ps1' "FromHub" }
        5 { & '.\Scripts\PowerShell Scripts\Make IntelliJ Runs.ps1' "FromHub" }
        97 { Clear-Host }
        98
        {
            $MCGradleAbout1 = "MCGradle Scripts is available on the following platforms:"
            $MCGradleAbout2 = "Windows - Windows Commant Prompt, Windows PowerShell, PowerShell Core"
            $MCGradleAbout3 = "macOS - PowerShell Core, GNU bash"
            $MCGradleAbout4 = "GNU/Linux - PowerShell Core, GNU bash"

            $MCGradleThanks1 = "Original Windows batch scripts written by Bailey (KingPhygieBoo)"

            Write-Host $MCGradleGreeting1
            Write-Host $MCGradleGreeting2
            Write-Host $MCGradleGreeting3
            Write-Host ""
            Write-Host $MCGradleThanks1
            Write-Host ""
            Write-Host $MCGradleAbout1
            Write-Host $MCGradleAbout2
            Write-Host $MCGradleAbout3
            Write-Host $MCGradleAbout4
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

Write-Host ""
exit 0
