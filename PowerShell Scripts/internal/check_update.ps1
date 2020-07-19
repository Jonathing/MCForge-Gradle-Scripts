# Get version number from arguments
$MyCurrentVersion = $args[0]

# Write-Host $MyCurrentVersion

# Attempt downloading the update file
try
{
    $MyResponse = Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/master/VERSIONS.txt -OutFile '.\Scripts\PowerShell Scripts\internal\VERSIONS.txt'
    $StatusCode = $MyResponse.StatusCode
}
catch
{
    $StatusCode = $_.Exception.Response.StatusCode.value__
}

if ($StatusCode)
{
    # Inform user that the update check failed.
    $MyUpdFailMsg1 = "MCGradle Scripts failed to check for updates!"
    $MyUpdFailMsg2 = "We got a " + $StatusCode + " error when downloading latest version file."
    $MyUpdFailMsg3 = "Please report this to the MCGradle Scripts issue tracker!"
    $MyUpdFailMsg4 = "https://github.com/Jonathing/MCGradle-Scripts/issues"
    Write-Host $MyUpdFailMsg1
    Write-Host $MyUpdFailMsg2
    Write-Host $MyUpdFailMsg3
    Write-Host $MyUpdFailMsg4
    Write-Host ""
}
else
{
    # Get the LATESTVERSION line from the update file
    $MyUpdateVer = Get-Content '.\Scripts\PowerShell Scripts\internal\VERSIONS.txt' | Where-Object {$_ -like '*LATESTVERSION=*'}

    # Ddelete the update file
    Remove-Item '.\Scripts\PowerShell Scripts\internal\VERSIONS.txt'

    if ($MyUpdateVer)
    {
        # Extract string within double quotes
        $TrueUpdateVer = $MyUpdateVer|%{$_.split('"')[1]}
    }
}

if ($TrueUpdateVer)
{
    if ($TrueUpdateVer -ne $MyCurrentVersion)
    {
        $MyPWSHUpdateMsg1 = "An update is available for MCGradle Scripts! The latest version is " + $TrueUpdateVer
        $MyPWSHUpdateMsg2 = "To update, read " + [char]0x0022 + "UPDATE.md" + [char]0x0022 + " on how to update MCGradle Scripts in your repository."
        Write-Host $MyPWSHUpdateMsg1
        Write-Host $MyPWSHUpdateMsg2
        Write-Host ""
    }
}
else
{
    # Inform user that the update check failed.
    $MyUpdFailMsg1 = "MCGradle Scripts failed to check for updates!"
    $MyUpdFailMsg2 = "Please report this to the MCGradle Scripts issue tracker!"
    $MyUpdFailMsg3 = "https://github.com/Jonathing/MCGradle-Scripts/issues"
    Write-Host $MyUpdFailMsg1
    Write-Host $MyUpdFailMsg2
    Write-Host $MyUpdFailMsg3
    Write-Host ""
}
