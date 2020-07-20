# Get displayName line from mods.toml
$MCModName = Get-Content .\src\main\resources\META-INF\mods.toml | Where-Object {$_ -like '*displayName=*'}

# Extract string within double quotes
$TrueModName = $MCModName|%{$_.split('"')[1]}

# Create file with the mod name
Set-Content -Path '.\Scripts\PowerShell\internal\MODNAME' -Value $TrueModName
