try {
    $MyResponse = Invoke-WebRequest -TimeoutSec 10 https://raw.githubusercontent.com/Jonathing/MCForge-Gradle-Scripts/master/VERSIONS.txt -OutFile '.\Scripts\PowerShell Scripts\internal\VERSIONS.txt'
    $StatusCode = $MyResponse.StatusCode
}
catch {
    $StatusCode = $_.Exception.Response.StatusCode.value__
}

if ($StatusCode) {
    $MyUpdFailMsg1 = "Unable to check for updates! Got a " + $StatusCode + " error when downloading latest version file."
    $MyUpdFailMsg2 = "Please report this to the MCGradle Scripts issue tracker!"
    $MyUpdFailMsg3 = "https://github.com/Jonathing/MCForge-Gradle-Scripts/issues"

    Write-Host $MyUpdFailMsg1
    Write-Host $MyUpdFailMsg2
    Write-Host $MyUpdFailMsg3
} else {
    $MyUpdateVer = Get-Content '.\Scripts\PowerShell Scripts\internal\VERSIONS.txt' | Where-Object {$_ -like '*PWSHVERSION=*'}
    $TrueUpdateVer = $MyUpdateVer|%{$_.split('"')[1]}
    # Write-Host $TrueUpdateVer
    Remove-Item '.\Scripts\PowerShell Scripts\internal\VERSIONS.txt'
    Set-Content -Path '.\Scripts\PowerShell Scripts\internal\PWSHVERSION' -Value $TrueUpdateVer
}