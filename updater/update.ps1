class OldPreferences
{
    $OldActionPreference

    OldPreferences($OldActionPreference)
    {
        $this.OldActionPreference = $OldActionPreference
    }
}

function CheckAndDeleteFolder
{
    param
    (
        [parameter(Mandatory)][string]$PathToDelete
    )
    
    if (Test-Path .\$($PathToDelete)\)
    {
        Remove-Item -Force -Recurse .\$($PathToDelete)\
    }
}

function CheckAndDelete {
    param
    (
        [parameter(Mandatory)][string]$PathToDelete
    )
    
    if (Test-Path .\$($PathToDelete))
    {
        Remove-Item -Force .\$($PathToDelete)
    }
}

class Updater
{
    static [void] RemoveLegacyFiles()
    {
        CheckAndDeleteFolder "Windows"
        CheckAndDeleteFolder "PowerShell"
        CheckAndDeleteFolder "bash"
        CheckAndDelete "MCGradle Scripts.sh"
        CheckAndDelete "CHANGELOG.md"
        CheckAndDelete "README.md"
    }

    static [void] RemoveFiles()
    {
        CheckAndDelete "MCGradle Scripts.bat"
        CheckAndDelete "MCGradle Scripts.ps1"
        CheckAndDelete ".gitignore"
    }

    static [void] DownloadNewFiles()
    {
        try
        {
            # Attempt to download the update file
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/MCGradle%20Scripts.ps1 -OutFile '.\MCGradle Scripts.ps1'
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/warppers/MCGradle%20Scripts.bat -OutFile '.\MCGradle Scripts.bat'
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/wrappers/tasks/build.bat -OutFile '.\build.bat'
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/wrappers/tasks/clean.bat -OutFile '.\clean.bat'
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/wrappers/tasks/createMcpToSrg.bat -OutFile '.\createMcpToSrg.bat'
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/wrappers/tasks/eclipse.bat -OutFile '.\eclipse.bat'
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/wrappers/tasks/genEclipseRuns.bat -OutFile '.\genEclipseRuns.bat'
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/wrappers/tasks/genIntellijRuns.bat -OutFile '.\genIntellijRuns.bat'
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/wrappers/tasks/intellij.bat -OutFile '.\intellij.bat'
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/user-only/.gitignore -OutFile '.\.gitignore'
        }
        catch
        {
            $StatusCode = $_.Exception.MCResponse.StatusCode.value__
            Write-Host "Unable to download MCGradle Scripts!" -ForegroundColor Red
            Write-Host "Recieved an error code of $StatusCode"
            Write-Host ""
            Pause
            Write-Host ""
            exit 1
        }
    }

    static [void] CreateUpdateMarker()
    {
        New-Item -Path . -Name "HAS_UPDATED" -ItemType "file" -Value "This file will be deleted the next time MCGradle Scripts is ran. It is simply here to aid the script in the updating process."
    }
}

Write-Host "Preparing to install MCGradle Scripts..."

$OldPreferences = [OldPreferences]::new($ErrorActionPreference)
$ErrorActionPreference = "SilentlyContinue"
$ProgressPreference = "SilentlyContinue"

Write-Host "Installing MCGradle Scripts..."

[Updater]::RemoveLegacyFiles()
[Updater]::RemoveFiles()
[Updater]::DownloadNewFiles()
[Updater]::CreateUpdateMarker()

Write-Host ""
Write-Host "Finished installing MCGradle Scripts!" -ForegroundColor Green
Write-Host ""

$ErrorActionPreference = $OldPreferences.OldActionPreference
$ProgressPreference = "Continue"
