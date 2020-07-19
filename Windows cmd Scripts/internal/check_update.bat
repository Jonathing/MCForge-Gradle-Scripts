:: Disable echoing commands onto the console
@ECHO off

:: Get current Windows build
FOR /F "tokens=3" %%A in ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "CurrentBuildNumber"') DO (ECHO %%A) > "CURRENTBUILD"
SET /p MyWin10Build=<"CURRENTBUILD"
DEL "CURRENTBUILD"

:: Decide if Windows is new enough for MCGradle Scripts to check for updates
SET "CANUPDATE="
IF %MyWin10Build% lss 17063 (
    ECHO MCGradle Scripts will not be able to check for updates.
    ECHO You need to have at least Windows 10 April 2018 Update.
    SET PWSHPOLICY=1
    ECHO.
    exit /B
)

:: Download the update file
curl -o CMDVERSION --fail --silent https://raw.githubusercontent.com/Jonathing/MCForge-Gradle-Scripts/master/CMDVERSION.txt

:: Put the new version in a variable
SET /p MyCMDUpdateVer=<"CMDVERSION"

:: Delete the downloaded update file
DEL "CMDVERSION"

:: Inform the user if MCGradle Scripts can be update
SET CANUPDATE=1
IF defined CANUPDATE (
    IF %MyCMDVersion%==%MyCMDUpdateVer% (
        REM EMPTY METHOD
    ) ELSE (
        ECHO An update is available for MCGradle Scripts! The latest version is %MyCMDUpdateVer%
        ECHO To update, read "UPDATE.md" on how to update the submodule in your repository.
        ECHO.
    )
)
