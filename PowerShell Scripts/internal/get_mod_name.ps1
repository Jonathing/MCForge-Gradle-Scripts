$MyModName = Get-Content .\src\main\resources\META-INF\mods.toml | Where-Object {$_ -like '*displayName=*'}
$TrueModName = $MyModName|%{$_.split('"')[1]}
# Write-Host $TrueModName
Set-Content -Path '.\Scripts\PowerShell Scripts\internal\MODNAME' -Value $TrueModName