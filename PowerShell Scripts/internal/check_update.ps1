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
    $MyUpdFailMsg4 = "https://github.com/Jonathing/MCForge-Gradle-Scripts/issues"
    Write-Host $MyUpdFailMsg1
    Write-Host $MyUpdFailMsg2
    Write-Host $MyUpdFailMsg3
    Write-Host $MyUpdFailMsg4
}
else
{
    # Get the PWSHVERSION line from the update file
    $MyUpdateVer = Get-Content '.\Scripts\PowerShell Scripts\internal\VERSIONS.txt' | Where-Object {$_ -like '*PWSHVERSION=*'}

    # Extract string within double quotes
    $TrueUpdateVer = $MyUpdateVer|%{$_.split('"')[1]}
    
    # Delete the downloaded update file
    Remove-Item '.\Scripts\PowerShell Scripts\internal\VERSIONS.txt'

    # Create a new file with the updated versions
    Set-Content -Path '.\Scripts\PowerShell Scripts\internal\PWSHVERSION' -Value $TrueUpdateVer
}