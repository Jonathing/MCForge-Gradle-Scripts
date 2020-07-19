:: Disable echoing commands onto the console
@ECHO off

:: Get current Windows build
FOR /F "tokens=3" %%A in ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "CurrentBuildNumber"') DO (ECHO %%A) > "CURRENTBUILD"
SET /p MyWin10Build=<"CURRENTBUILD"
DEL "CURRENTBUILD"

:: Decide if Windows is new enough for MCGradle Scripts to check for updates
SET "CANUPDATE="
IF %MyWin10Build% lss 17063 (
    ECHO MCGradle Scripts failed to check for updates!
    ECHO You need to have at least Windows 10 April 2018 Update.
    ECHO.
    SET PWSHPOLICY=1
    exit /B
)

:: Download the update file
curl -o CMDVERSION --fail --silent https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/master/CMDVERSION.txt

IF EXIST "CMDVERSION" (
    REM EMPTY METHOD
) ELSE (
    ECHO MCGradle Scripts failed to check for updates!
    ECHO We weren't able to download the update file from GitHub.
    ECHO If you are connected to the internet without issues, report this to the issue tracker!
    ECHO https://github.com/Jonathing/MCForge-Gradle-Scripts/issues
    ECHO.
    SET PWSHPOLICY=1
    exit /B
)


:: Put the new version in a variable
SET /p MyCMDUpdateVer=<"CMDVERSION"

:: Delete the downloaded update file
DEL "CMDVERSION"

:: Inform the user if MCGradle Scripts can be updated
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


