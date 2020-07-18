@ECHO off

for /F "tokens=3" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "CurrentBuildNumber"') DO (ECHO %%A) > "CURRENTBUILD"
set /p MyWin10Build=<"CURRENTBUILD"
DEL "CURRENTBUILD"

set "CANUPDATE="
if %MyWin10Build% lss 17063 (
    ECHO MCGradle Scripts will not be able to check for updates.
    ECHO You need to have at least Windows 10 April 2018 Update.
    SET PWSHPOLICY=1
    ECHO.
    exit /B
)

curl -o CMDVERSION --fail --silent https://raw.githubusercontent.com/Jonathing/MCForge-Gradle-Scripts/master/CMDVERSION.txt
set /p MyCMDUpdateVer=<"CMDVERSION"
DEL "CMDVERSION"

set CANUPDATE=1

IF defined CANUPDATE (
    IF %MyCMDVersion%==%MyCMDUpdateVer% (
        REM EMPTY METHOD
    ) ELSE (
        echo An update is available for MCGradle Scripts! The latest version is %MyCMDUpdateVer%
        echo To update, read "UPDATE.md" on how to update the submodule in your repository.
        echo.
    )
)