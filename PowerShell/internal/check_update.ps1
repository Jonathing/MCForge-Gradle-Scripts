# Get version number from arguments
$MCGradleCurrentVer = $args[0]
$MCGradleArgs = $args[1]

try
{
    # Hide download progress from user
    $ProgressPreference = 'SilentlyContinue'

    # Attempt to download the update file
    $MCResponse = Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/master/VERSIONS.txt -OutFile '.\PowerShell\internal\VERSIONS.txt'
    
    # Revert environment variable change
    $ProgressPreference = 'Continue'

    # Get status code from web request
    $StatusCode = $MCResponse.StatusCode
}
catch
{
    $StatusCode = $_.Exception.MCResponse.StatusCode.value__
}

if ($StatusCode)
{
    # Inform user that the update check failed.
    $MCGradleFailMsg1 = "MCGradle Scripts failed to check for updates!"
    $MCGradleFailMsg2 = "We got a " + $StatusCode + " error when downloading latest version file."
    $MCGradleFailMsg3 = "Please report this to the MCGradle Scripts issue tracker!"
    $MCGradleFailMsg4 = "https://github.com/Jonathing/MCGradle-Scripts/issues"
    Write-Host $MCGradleFailMsg1 -ForegroundColor Red
    Write-Host $MCGradleFailMsg2 -ForegroundColor Red
    Write-Host $MCGradleFailMsg3 -ForegroundColor Red
    Write-Host $MCGradleFailMsg4 -ForegroundColor Red
    Write-Host ""
}
else
{
    # Get the LATESTVERSION line from the update file
    $MCGradleUpdateVer = Get-Content '.\PowerShell\internal\VERSIONS.txt' | Where-Object {$_ -like '*LATESTVERSION=*'}

    # Ddelete the update file
    Remove-Item '.\PowerShell\internal\VERSIONS.txt'

    if ($MCGradleUpdateVer)
    {
        # Extract string within double quotes
        $MCTrueUpdateVer = $MCGradleUpdateVer|%{$_.split('"')[1]}
    }
}

if ($MCTrueUpdateVer)
{
    if ($MCGradleArgs -eq "FromHub")
    {
        $MCHubUpdVer = $MCTrueUpdateVer
    }
    else
    {
        if ($MCTrueUpdateVer -ne $MCGradleCurrentVer)
        {
            $MCGradleUpdateMsg1 = "An update is available for MCGradle Scripts! The latest version is " + $MCTrueUpdateVer
            $MCGradleUpdateMsg2 = "To update, run the main script and follow through with the update process."
            Write-Host $MCGradleUpdateMsg1 -ForegroundColor Green
            Write-Host $MCGradleUpdateMsg2 -ForegroundColor Green
            Write-Host ""
        }
    }
}
else
{
    # Inform user that the update check failed.
    $MCGradleFailMsg1 = "MCGradle Scripts failed to check for updates!"
    $MCGradleFailMsg2 = "Please report this to the MCGradle Scripts issue tracker!"
    $MCGradleFailMsg3 = "https://github.com/Jonathing/MCGradle-Scripts/issues"
    Write-Host $MCGradleFailMsg1
    Write-Host $MCGradleFailMsg2
    Write-Host $MCGradleFailMsg3
    Write-Host ""
}
