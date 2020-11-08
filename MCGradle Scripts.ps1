class ScriptInfo
{
    [string]$ScriptTitle
    [string]$ScriptAuthor
    [string]$ScriptVersion

    ScriptInfo()
    {
        $this.ScriptTitle = "MCGradle Scripts"
        $this.ScriptAuthor = "Jonathing"
        $this.ScriptVersion = "0.6.0"
    }

    [void] print()
    {
        Write-Host "$($this.ScriptTitle) by $($this.ScriptAuthor)"
        Write-Host "Version $($this.ScriptVersion)"
    }

    [string] getScriptTitle()
    {
        return $this.ScriptTitle
    }

    [string] getScriptAuthor()
    {
        return $this.ScriptAuthor
    }

    [string] getScriptVersion()
    {
        return $this.ScriptVersion
    }
}

class SessionInfo
{
    [bool]$IsFromCMD
    [string]$PSSessionEdition
    [string]$PSSessionPlatform
    [string]$OldTitle

    SessionInfo([string]$StartupArg, [string]$PSSessionEdition, [string]$PSSessionPlatform)
    {
        if ($StartupArg -eq "FromCMD")
        {
            $this.IsFromCMD = 1
        }

        $this.PSSessionEdition = $PSSessionEdition
        $this.PSSessionPlatform = $PSSessionPlatform

        if (!$this.isOnWindows())
        {
            $this.OldTitle = ""
        }
        else
        {
            $this.OldTitle = [System.Console]::Title
        }
    }

    [string] getSessionTerminal()
    {
        [string]$Terminal = ""

        # Get PowerShell version
        if ($this.PSSessionEdition -eq "Desktop")
        {
            $Terminal = "Windows PowerShell"
        }
        else
        {
            $Terminal = "PowerShell Core"
        }

        if ($this.IsFromCMD)
        {
            $Terminal += " via Windows Command Prompt"
        }

        return $Terminal
    }

    [bool] isOnWindows()
    {
        if ($this.PSSessionPlatform -eq "Win32NT" -xor $this.PSSessionEdition -eq "Desktop")
        {
            return 1
        }
        else
        {
            return 0
        }
    }

    [string] getOldTitle()
    {
        return $this.OldTitle
    }
}

function FinalTask
{
    param
    (
        [parameter(Mandatory)][string]$OldWindowTitle
    )

    Write-Host "Quitting MCGradle Scripts..." -ForegroundColor Red
    
    # Go back to scripts
    Set-Location .\Scripts\

    # Revert old title (on Mac and Linux, give empty title)
    ChangeWindowTitle $OldWindowTitle

    Write-Host ""

    exit 0
}

class GradleCommandInfo
{
    [string]$CommandCall
    [string]$CommandStartupMessage
    [string]$ModName

    GradleCommandInfo([string]$CommandCall, [string]$ModName)
    {
        $this.CommandCall = $CommandCall
        $this.ModName = $ModName
    }

    [string] getCall()
    {
        return $this.CommandCall
    }

    [string] getWindowTitle()
    {
        switch ($this.CommandCall)
        {
            "build"
            {
                return "$($this.ModName): Build Project"
            }
            "eclipse"
            {
                return "$($this.ModName): Eclipse Workspace"
            }
            "genEclipseRuns"
            {
                return "$($this.ModName): Eclipse Run Configurations"
            }
            "genIntellijRuns"
            {
                return "$($this.ModName): IntelliJ IDEA Run Configurations"
            }
            "createMcpToSrg"
            {
                return "$($this.ModName): MCP to Searge Mappings"
            }
            Default
            {
                return "$($this.ModName): $($this.CommandCall)"
            }
        }

        return ""
    }

    [void] printStartupMessages()
    {
        switch ($this.CommandCall)
        {
            "build"
            {
                Write-Host "Building $($this.ModName)...";
                Break
            }
            "eclipse"
            {
                Write-Host "Setting up the initial Eclipse workspace for $($this.ModName)..."
                Break
            }
            "genEclipseRuns"
            {
                Write-Host "Generating the Eclipse run configurations for $($this.ModName)..."
                Break
            }
            "genIntellijRuns"
            {
                Write-Host "Generating the IntelliJ IDEA run configurations for $($this.ModName)..."
                Break
            }
            "createMcpToSrg"
            {
                Write-Host "Generating the Searge mappings from the MCP mappings..."
            }
            Default
            {
                Write-Host "Running a custom command ($($this.CommandCall)) for $($this.ModName)..."
                Break
            }
        }

        Write-Host ""
    }

    [void] printSuccessMessages()
    {
        Write-Host ""

        switch ($this.CommandCall)
        {
            "build"
            {
                Write-Host "Finished building $($this.ModName)." -ForegroundColor Green
                Write-Host "You should be able to find your build artifacts in 'build/libs'." -ForegroundColor Green
                Break
            }
            "eclipse"
            {
                Write-Host "Finished setting up the Eclipse workspace for $($this.ModName)." -ForegroundColor Green
                Break
            }
            "genEclipseRuns"
            {
                Write-Host "Finished generating the Eclipse run configurations for $($this.ModName)." -ForegroundColor Green
                Break
            }
            "genIntellijRuns"
            {
                Write-Host "Finished generating the IntelliJ IDEA configurations for $($this.ModName)." -ForegroundColor Green
                Break
            }
            "createMcpToSrg"
            {
                Write-Host "Finished generating the Searge mappings from the MCP mappings." -ForegroundColor Green
            }
            Default
            {
                Write-Host "Finished the custom task for $($this.ModName)." -ForegroundColor Green
            }
        }

        Write-Host ""
    }

    [void] printFailureMessages()
    {
        Write-Host ""

        switch ($this.CommandCall)
        {
            "build"
            {
                Write-Host "Gradle failed to build $($this.ModName)!" -ForegroundColor Red
                Write-Host "Make sure you check the error that Gradle threw before trying again." -ForegroundColor Red
                Break
            }
            "eclipse"
            {
                Write-Host "Gradle failed to set up the Eclipse workspace for $($this.ModName)!" -ForegroundColor Red
                Write-Host "Make sure you check the error that Gradle threw before trying again." -ForegroundColor Red
                Break
            }
            "genEclipseRuns"
            {
                Write-Host "Gradle failed to generate the Eclipse run configurations for $($this.ModName)!" -ForegroundColor Red
                Write-Host "Make sure you check the error that Gradle threw before trying again." -ForegroundColor Red
                Break
            }
            "genIntellijRuns"
            {
                Write-Host "Gradle failed to generate the IntelliJ IDEA run configurations for $($this.ModName)!" -ForegroundColor Red
                Write-Host "Make sure you check the error that Gradle threw before trying again." -ForegroundColor Red
                Break
            }
            "createMcpToSrg"
            {
                Write-Host "Gradle failed to generate the Searge mappings from the MCP mappings!" -ForegroundColor Red
                Write-Host "Make sure you check the error that Gradle threw before trying again." -ForegroundColor Red
                Break
            }
            Default
            {
                Write-Host "Gradle failed to complete the custom command for $($this.ModName)!" -ForegroundColor Red
                Write-Host "Make sure you check the error that Gradle threw before trying again." -ForegroundColor Red
                Break
            }
        }

        Write-Host ""
    }

    static [void] promptToOpenBuildFolder([bool]$IsOnWindows)
    {
        if ($IsOnWindows)
        {
            Write-Host "Would you like to open the 'build/libs' folder now? " -ForegroundColor Yellow -NoNewline
            Write-Host "[ y/N ] " -ForegroundColor Yellow -NoNewline
        
            if ($(Read-Host) -eq "y")
            {
                Start-Process .\build\libs
                Write-Host "The 'build/libs' folder should now be open in Windows Explorer." -ForegroundColor Yellow
            }

            Write-Host ""
        }
    }
}

# This class exists mainly as a way to save memory.
class GradleCommands
{
    [GradleCommandInfo]$BuildCommand
    [GradleCommandInfo]$EclipseCommand
    [GradleCommandInfo]$GenEclipseRunsCommand
    [GradleCommandInfo]$GenIntellijRunsCommand
    [GradleCommandInfo]$CreateMcpToSrg

    [string]$ModName

    GradleCommands([string]$ModName)
    {
        $this.ModName = $ModName

        $this.BuildCommand = [GradleCommandInfo]::new("build", $this.ModName)
        $this.EclipseCommand = [GradleCommandInfo]::new("eclipse", $this.ModName)
        $this.GenEclipseRunsCommand = [GradleCommandInfo]::new("genEclipseRuns", $this.ModName)
        $this.GenIntellijRunsCommand = [GradleCommandInfo]::new("genIntellijRuns", $this.ModName)
        $this.CreateMcpToSrg = [GradleCommandInfo]::new("createMcpToSrg", $this.ModName)
    }

    [GradleCommandInfo] getCommand([string]$CommandCall)
    {
        switch ($CommandCall)
        {
            "build"
            {
                return $this.BuildCommand
            }
            "eclipse"
            {
                return $this.EclipseCommand
            }
            "genEclipseRuns"
            {
                return $this.GenEclipseRunsCommand
            }
            "genIntellijRuns"
            {
                return $this.GenIntellijRunsCommand
            }
            "createMcpToSrg"
            {
                return $this.CreateMcpToSrg
            }
            Default
            {
                return [GradleCommandInfo]::new("$($CommandCall)", $this.ModName)
            }
        }

        return [GradleCommandInfo]::new("$($CommandCall)", $this.ModName)
    }
}

class ModInfo
{
    # 0 for ForgeGradle 3, 1 for ForgeGradle 2, 2 for Fabric
    [int]$ToolchainID

    [string]$ModName

    ModInfo([int]$ToolchainID)
    {
        $this.ToolchainID = $ToolchainID

        if ($this.ToolchainID -eq 0)
        {
            $this.ModName = $(Get-Content .\src\main\resources\META-INF\mods.toml | Where-Object { $_ -like '*displayName=*' }) | ForEach-Object { $_.split('"')[1] }
        }
        else
        {
            if ($this.ToolchainID -eq 1)
            {
                # TODO Get mod name from mcmod.info
                $this.ModName = "UNKNOWN MOD"
            }
            else
            {
                if ($this.ToolchainID -eq 2)
                {
                    # TODO Get mod name from fabric.mod.json
                    $this.ModName = "UNKNOWN MOD"
                }
                else
                {
                    $this.ModName = "UNKNOWN MOD"
                }
            }
        }
    }

    static [int] getToolchainId([string]$ScriptTitle, [string]$OldWindowTitle)
    {
        if ($(Get-Content .\build.gradle | Where-Object { $_ -like '*classpath*' }) -like "*ForgeGradle', version: '3*" -or $(Get-Content .\build.gradle | Where-Object { $_ -like '*classpath*' }) -like "*ForgeGradle:3*")
        {
            Write-Host "Detected a workspace using Forge since 14.23.5.2851 or since Minecraft 1.13.2."
            return 0
        }
        else
        {
            if ($(Get-Content .\build.gradle | Where-Object { $_ -like '*classpath*' }) -like "*classpath 'net.minecraftforge.gradle:ForgeGradle:2*" -or $(Get-Content .\build.gradle | Where-Object { $_ -like '*classpath*' }) -like "*ForgeGradle', version: '2*")
            {
                Write-Host "Detected a workspace using Forge prior to 14.23.5.2847 or Minecraft 1.12.2 and below."
                Write-Host ""
                Write-Host "$ScriptTitle has not yet added support for workspaces using ForgeGradle 2." -ForegroundColor Red
                Write-Host "Support will be added in a future update. Until then, please use a ForgeGradle 3 workspace." -ForegroundColor Red
                Write-Host ""
                Pause
                Write-Host ""
                FinalTask $OldWindowTitle
                return 1
            }
            else
            {
                if ($(Get-Content .\build.gradle | Where-Object { $_ -like "*id 'fabric-loom'*" }) -like "*id 'fabric-loom' version*")
                {
                    Write-Host "Detected a workspace using Fabric."
                    Write-Host ""
                    Write-Host "$ScriptTitle has not yet added support for workspaces using Fabric." -ForegroundColor Red
                    Write-Host "Support will be added in a future update. Until then, please use a ForgeGradle 3 workspace." -ForegroundColor Red
                    Write-Host ""
                    Pause
                    Write-Host ""
                    FinalTask $OldWindowTitle
                    return 2
                }
                else
                {
                    Write-Host "$ScriptTitle was unable to find a valid Forge or Fabric workspace!" -ForegroundColor Red
                    Write-Host ""
                    Pause
                    Write-Host ""
                    FinalTask $OldWindowTitle
                    exit 1
                }
            }
        }
    }

    [string] getModName()
    {
        return $this.ModName
    }
}

class Hub
{
    static [void] printInitialGreeting()
    {
        Write-Host "What would you like to do today?"
        Write-Host ""
    }

    static [void] printHubOptions([string]$ModName)
    {
        Write-Host "Gradle Commands"
        Write-Host "1. Build $ModName"
        Write-Host "2. Set up your Eclipse workspace"
        Write-Host "3. Set up your IntelliJ IDEA workspace"
        Write-Host "4. Generate the Eclipse run configurations"
        Write-Host "5. Generate the IntelliJ IDEA run configurations"
        Write-Host "6. Do a full cleanup of the workspace"
        Write-Host "7. Generate Searge mappings from MCP (fixes potential mapping issues)"
        Write-Host "8. Run a different gradle command"
        Write-Host ""
        Write-Host "MCGradle Scripts Options"
        Write-Host "C. Clear the screen"
        Write-Host "R. Show the options again"
        Write-Host "A. About MCGradle Scripts"
        Write-Host "Q. Quit MCGradle Scripts"
        Write-Host ""
    }

    static [void] printAboutInfo([ScriptInfo]$ScriptInfo, [SessionInfo]$SessionInfo)
    {
        Write-Host $ScriptInfo.getScriptTitle()
        Write-Host "Version $($ScriptInfo.getScriptVersion())"
        Write-Host "Written and Maintained by $($ScriptInfo.getScriptAuthor())"
        Write-Host "Running on $($SessionInfo.getSessionTerminal())"
        Write-Host ""
        Write-Host "Original Windows batch scripts written by Bailey (KingPhygieBoo)"
        Write-Host ""

        Pause

        Write-Host ""
    }
}

function ChangeWindowTitle
{
    param
    (
        [parameter(Mandatory)][string]$NewTitle
    )
    
    [System.Console]::Title = $NewTitle
}

function CheckForUpdates
{
    param
    (
        [parameter(Mandatory)][string]$CurrentVersion,
        [parameter(Mandatory)][string]$OldWindowTitle,
        [parameter(Mandatory)][bool]$IsFromCMD,
        [bool]$ShouldNotUpdate
    )
    
    try
    {
        # Hide download progress from user
        $ProgressPreference = 'SilentlyContinue'

        # Attempt to download the update file
        $UpdateFile = Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/master/VERSIONS.txt -OutFile '.\VERSIONS.txt'
        
        # Revert environment variable change
        $ProgressPreference = 'Continue'

        # Get status code from web request
        $StatusCode = $UpdateFile.StatusCode
    }
    catch
    {
        $StatusCode = $_.Exception.UpdateFile.StatusCode.value__
    }

    if ($StatusCode)
    {
        # Inform user that the update check failed.
        Write-Host "MCGradle Scripts failed to check for updates!"
        Write-Host "We got a $StatusCode error when downloading latest version file."
        Write-Host "Please report this to the MCGradle Scripts issue tracker!"
        Write-Host "https://github.com/Jonathing/MCGradle-Scripts/issues"

        if (Test-Path .\VERSIONS.txt)
        {
            Remove-Item -Force .\VERSIONS.txt
        }
    }
    else
    {
        $VersionFileContents = Get-Content '.\VERSIONS.txt' | Where-Object {$_ -like '*REWRITEVERSION=*'}

        Remove-Item -Force .\VERSIONS.txt

        if ($VersionFileContents)
        {
            # Extract string within double quotes
            $LatestVersion = $VersionFileContents|ForEach-Object{$_.split('"')[1]}
        }
    }

    if ($LatestVersion)
    {
        if ($LatestVersion -ne $CurrentVersion)
        {
            Write-Host "An update is available for MCGradle Scripts! The latest version is $LatestVersion" -ForegroundColor Green
            if (!$ShouldNotUpdate)
            {
                Write-Host "Would you like to update now? [ y/N ] " -ForegroundColor Yellow -NoNewline
                $UserInput = Read-Host
                Switch ($UserInput)
                {
                    Y
                    {
                        Write-Host ""
                        . { Invoke-WebRequest -useb https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/master/updater/update.ps1 } | Invoke-Expression
                        if ($IsFromCMD)
                        {
                            Write-Host "Restarting MCGradle Scripts..." -ForegroundColor Red
                        }
                        else
                        {
                            Remove-Item -Force .\HAS_UPDATED
                            Pause
                            Write-Host "Quitting MCGradle Scripts..." -ForegroundColor Red
                        }

                        ChangeWindowTitle $OldWindowTitle

                        Write-Host ""

                        exit 0
                    }
                    Default
                    {
                        Write-Host ""
                        if ($UserInput -ne "n")
                        {
                            Write-Host "Unknown option selected, assuming that we do not want to update." -ForegroundColor Yellow
                        }
                        Write-Host "Continuing to MCGradle Scripts..." -ForegroundColor Yellow
                        Write-Host ""
                        Break
                    }
                }
            }
            else
            {
                Write-Host "To update, run the main script and follow through with the update process." -ForegroundColor Green
                Write-Host ""
            }
        }
    }
    else
    {
        Write-Host "MCGradle Scripts failed to check for updates!" -ForegroundColor Red
        Write-Host "Please report this to the MCGradle Scripts issue tracker!" -ForegroundColor Red
        Write-Host "https://github.com/Jonathing/MCGradle-Scripts/issues" -ForegroundColor Red
        Write-Host ""
    }
}

function RunGradleCommand
{
    param
    (
        [parameter(Mandatory)][GradleCommandInfo]$CommandInfo,
        [parameter(Mandatory)][bool]$IsOnWindows,
        [parameter(Mandatory)][string]$OldWindowTitle
    )
    
    ChangeWindowTitle $CommandInfo.getWindowTitle()

    $CommandInfo.printStartupMessages()

    .\gradlew $($CommandInfo.getCall()) --warning-mode none

    if ($?)
    {
        $CommandInfo.printSuccessMessages()
        if ($CommandInfo.getCall() -eq "build")
        {
            [GradleCommandInfo]::promptToOpenBuildFolder($IsOnWindows)
        }
    }
    else
    {
        $CommandInfo.printFailureMessages()
    }

    ChangeWindowTitle $OldWindowTitle

    Pause
    Write-Host ""
}

# Get session information
$SessionInfo = [SessionInfo]::new($args[0], $PSVersionTable.PSEdition, $PSVersionTable.Platform)

# Get script information
$ScriptInfo = [ScriptInfo]::new()

# Change window title
ChangeWindowTitle "MCGradle Scripts"

# Print script information
$ScriptInfo.print()
Write-Host ""

if ([string]::IsNullOrEmpty($args[2]) -or $args[2] -ne "NoUpdate")
{
    CheckForUpdates $ScriptInfo.getScriptVersion() $SessionInfo.getOldTitle() $SessionInfo.IsFromCMD
}
else
{
    CheckForUpdates $ScriptInfo.getScriptVersion() $SessionInfo.getOldTitle() $SessionInfo.IsFromCMD 1
}

# Go to root project directory
Set-Location ..

if (!$(Test-Path -Path .\build.gradle))
{
    Write-Host "$($ScriptInfo.getScriptTitle()) was unable to find a build.gradle file!" -ForegroundColor Red
    Write-Host "Make sure that $($ScriptInfo.getScriptTitle()) is located in a folder called 'Scripts' in your root directory!" -ForegroundColor Red
    exit 1
}

$ModInfo = [ModInfo]::new([ModInfo]::getToolchainId($ScriptInfo.getScriptTitle(), $SessionInfo.getOldTitle()))
Write-Host ""

ChangeWindowTitle "$($ModInfo.getModName()): MCGradle Scripts"

$GradleCommands = [GradleCommands]::new($ModInfo.getModName())

if ([string]::IsNullOrEmpty($args[1]))
{
    [Hub]::printInitialGreeting()

    [bool]$ShowOptionsAgain = 1
    [bool]$HasChosen = 0
    [int]$ScriptOption = 0

    do
    {
        do
        {
            if ($ShowOptionsAgain)
            {
                [Hub]::printHubOptions($ModInfo.getModName())
            }
            else
            {
                Write-Host "Press R to see the options again." -ForegroundColor Yellow
            }
            $ShowOptionsAgain = 0
            Write-Host "Please pick an option [ 1-8, R, Q, ... ] " -ForegroundColor Yellow -NoNewline

            Switch ($(Read-Host))
            { 
                1 { $HasChosen = 1; $ScriptOption = 1 }
                2 { $HasChosen = 1; $ScriptOption = 2 }
                3 { $HasChosen = 1; $ScriptOption = 3 }
                4 { $HasChosen = 1; $ScriptOption = 4 }
                5 { $HasChosen = 1; $ScriptOption = 5 }
                6 { $HasChosen = 1; $ScriptOption = 6 }
                7 { $HasChosen = 1; $ScriptOption = 7 }
                8 { $HasChosen = 1; $ScriptOption = 8 }
                C { $HasChosen = 1; $ScriptOption = 97; $ShowOptionsAgain = 1 }
                A { $HasChosen = 1; $ScriptOption = 98 }
                Q { $HasChosen = 1; $ScriptOption = 99 }
                R { $HasChosen = 0; $ShowOptionsAgain = 1 }
                Default { $HasChosen = 0; $ScriptOption = 0 }
            }

            Write-Host ""

            if (!$HasChosen -and !$ShowOptionsAgain)
            {
                Write-Host "That's not a valid option." -ForegroundColor Yellow
            }
        }
        while (!$HasChosen)

        switch ($ScriptOption)
        {
            1
            {
                RunGradleCommand $GradleCommands.getCommand("build") $SessionInfo.isOnWindows() "$($ModInfo.getModName()): MCGradle Scripts"
                Break
            }
            2
            {
                RunGradleCommand $GradleCommands.getCommand("eclipse") $SessionInfo.isOnWindows() "$($ModInfo.getModName()): MCGradle Scripts"
                Write-Host "Would you also like to generate the Eclipse run configurations? " -ForegroundColor Yellow -NoNewline
                Write-Host "[ y/N ] " -ForegroundColor Yellow -NoNewline
            
                if ($(Read-Host) -eq "y")
                {
                    RunGradleCommand $GradleCommands.getCommand("genEclipseRuns") $SessionInfo.isOnWindows() "$($ModInfo.getModName()): MCGradle Scripts"
                }
                Break
            }
            3
            {
                ChangeWindowTitle "$($ModInfo.getModName()): IntelliJ IDEA Workspace"
                Write-Host "The IntelliJ IDEA workspace for Forge is no longer set up through a command."
                Write-Host "To import the project to IntelliJ IDEA, simply open your workspace folder as a project."
                Write-Host "Gradle will do the rest for you as it imports and indexes the project into IntelliJ."
                Write-Host ""
                Pause
                Write-Host ""
                ChangeWindowTitle "$($ModInfo.getModName()): MCGradle Scripts"
                Break
            }
            4
            {
                RunGradleCommand $GradleCommands.getCommand("genEclipseRuns") $SessionInfo.isOnWindows() "$($ModInfo.getModName()): MCGradle Scripts"
            }
            5
            {
                RunGradleCommand $GradleCommands.getCommand("genIntellijRuns") $SessionInfo.isOnWindows() "$($ModInfo.getModName()): MCGradle Scripts"
            }
            6
            {
                ChangeWindowTitle "$($ModInfo.getModName()): Clean Up Workspace"
                Write-Host "This option will be re-added soon..." -ForegroundColor Yellow
                Write-Host ""
                Pause
                Write-Host ""
                ChangeWindowTitle "$($ModInfo.getModName()): MCGradle Scripts"
                Break
            }
            7
            {
                RunGradleCommand $GradleCommands.getCommand("createMcpToSrg") $SessionInfo.isOnWindows() "$($ModInfo.getModName()): MCGradle Scripts"
            }
            8
            {
                Write-Host "Enter the command you would like to run below..."
                Write-Host ".\gradlew " -NoNewline

                $CustomCommand = $(Read-Host)
                Write-Host ""
            
                RunGradleCommand $GradleCommands.getCommand($CustomCommand) $SessionInfo.isOnWindows() "$($ModInfo.getModName()): MCGradle Scripts"
                Break
            }
            97
            {
                Clear-Host
                $ScriptInfo.print()
                Write-Host ""
                Break
            }
            98
            {
                ChangeWindowTitle "About MCGradle Scripts"
                [Hub]::printAboutInfo($ScriptInfo, $SessionInfo)
                ChangeWindowTitle "$($ModInfo.getModName()): MCGradle Scripts"
                Break
            }
            99
            {
                Break
            }
            Default
            {
                Write-Host "An unknown error has occurred..." -ForegroundColor Red
                Break
            }
        }
    }
    while ($ScriptOption -ne 99)

    FinalTask $SessionInfo.getOldTitle()
}
else 
{
    switch ($args[1])
    {
        "eclipse"
        {
            RunGradleCommand $GradleCommands.eclipse() $SessionInfo.isOnWindows() "$($ModInfo.getModName()): MCGradle Scripts"
            Write-Host "Would you also like to generate the Eclipse run configurations? " -ForegroundColor Yellow -NoNewline
            Write-Host "[ y/N ] " -ForegroundColor Yellow -NoNewline
        
            if ($(Read-Host) -eq "y")
            {
                RunGradleCommand $GradleCommands.genEclipseRuns() $SessionInfo.isOnWindows() "$($ModInfo.getModName()): MCGradle Scripts"
            }

            FinalTask $SessionInfo.getOldTitle()
        }
        "intellij"
        {
            ChangeWindowTitle "$($ModInfo.getModName()): IntelliJ IDEA Workspace"
            Write-Host "The IntelliJ IDEA workspace for Forge is no longer set up through a command."
            Write-Host "To import the project to IntelliJ IDEA, simply open your workspace folder as a project."
            Write-Host "Gradle will do the rest for you as it imports and indexes the project into IntelliJ."
            Write-Host ""
            Pause
            Write-Host ""
            ChangeWindowTitle "$($ModInfo.getModName()): MCGradle Scripts"
            FinalTask $SessionInfo.getOldTitle()
        }
        "clean"
        {
            ChangeWindowTitle "$($ModInfo.getModName()): Clean Up Workspace"
            Write-Host "This option will be re-added soon..." -ForegroundColor Yellow
            Write-Host ""
            Pause
            Write-Host ""
            ChangeWindowTitle "$($ModInfo.getModName()): MCGradle Scripts"
            FinalTask $SessionInfo.getOldTitle()
        }
        Default
        {
            RunGradleCommand $GradleCommands.getCommand($args[1]) $SessionInfo.isOnWindows() "$($ModInfo.getModName()): MCGradle Scripts"
            FinalTask $SessionInfo.getOldTitle()
        }
    }
}
