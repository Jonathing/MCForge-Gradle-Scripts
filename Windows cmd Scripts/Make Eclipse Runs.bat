:: Disable echoing commands onto the console
@ECHO off

:: Clear the screen
CLS

SET MyCMDAuthor=Jonathing
SET MyCMDVersion=0.4.0

:: Print script information
ECHO MCGradle Scripts (for Windows Command Prompt)
ECHO Version %MyCMDVersion%
ECHO Originally Written by Jonathing and Bailey
ECHO Maintained by %MyCMDAuthor%
ECHO.

:: Go to root project directory
CD ..\..

:: Check for update
PowerShell -ExecutionPolicy Bypass -NoLogo -NoProfile -File "Scripts\PowerShell Scripts\internal\check_update.ps1" %MyCMDVersion%

:: Get Forge mod title
CALL "Scripts\Windows cmd Scripts\internal\get_title.bat"

:: Set the title of the Command Prompt console
title %MyProjectName%: Eclipse Run Configurations

:: Generate the Eclipse run configs
ECHO Generating the Eclipse run configurations for %MyProjectName%...
ECHO.
CALL gradlew.bat genEclipseRuns --warning-mode none
ECHO.

ECHO Finished generating the Eclipse run configurations for %MyProjectName%.

:: Return to scripts directory
CD "Scripts\Windows cmd Scripts"

:: END OF SCRIPT
PAUSE
EXIT /B 0
