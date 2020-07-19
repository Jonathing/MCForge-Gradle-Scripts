# Get displayName line from mods.toml
$MyModName = Get-Content .\src\main\resources\META-INF\mods.toml | Where-Object {$_ -like '*displayName=*'}

# Extract string within double quotes
$TrueModName = $MyModName|%{$_.split('"')[1]}

# Create file with the mod name
Set-Content -Path '.\Scripts\PowerShell Scripts\internal\MODNAME' -Value $TrueModName