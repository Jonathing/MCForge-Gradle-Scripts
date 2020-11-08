class OldPreferences
{
    $OldActionPreference
    $OldProgressPreference

    OldPreferences($OldActionPreference, $OldProgressPreference)
    {
        $this.OldActionPreference = $OldActionPreference
        $this.$OldProgressPreference = $OldProgressPreference
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
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/MCGradle%20Scripts.bat -OutFile '.\MCGradle Scripts.bat'
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/build.bat -OutFile '.\build.bat'
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/clean.bat -OutFile '.\clean.bat'
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/eclipse.bat -OutFile '.\eclipse.bat'
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/genEclipseRuns.bat -OutFile '.\genEclipseRuns.bat'
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/genIntellijRuns.bat -OutFile '.\genIntellijRuns.bat'
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/intellij.bat -OutFile '.\intellij.bat'
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/.gitignore -OutFile '.\.gitignore'
            Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/develop/user-only/.gitignore -OutFile '.\.gitignore'
        }
        catch
        {
            Write-Host "Unable to download MCGradle Scripts!" -ForegroundColor Red
            Write-Host ""
            Pause
            Write-Host ""
            $StatusCode = $_.Exception.MCResponse.StatusCode.value__
        }
    }
}

Write-Host "Preparing to install MCGradle Scripts..."

$OldPreferences = [OldPreferences]::new($ErrorActionPreference, $ProgressPreference)
$ErrorActionPreference = "SilentlyContinue"
$ProgressPreference = "SilentlyContinue"

Write-Host "Installing MCGradle Scripts..."

[Updater]::RemoveLegacyFiles()
[Updater]::RemoveFiles()
[Updater]::DownloadNewFiles()

Write-Host ""
Write-Host "Finished installing MCGradle Scripts!" -ForegroundColor Green
Write-Host ""
Pause
Write-Host ""

$ErrorActionPreference = $OldPreferences.ActionPreference
$ProgressPreference = $OldPreferences.OldProgressPreference
