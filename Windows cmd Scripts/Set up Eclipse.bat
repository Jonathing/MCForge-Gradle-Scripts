:: Disable echoing commands onto the console
@ECHO off

:: Clear the screen
CLS

SET MyCMDAuthor=Jonathing
SET MyCMDVersion=0.4.0

:: Print script information
ECHO MCGradle Scripts (for Windows Command Prompt)
ECHO Version %MyCMDVersion%
ECHO Written and Maintained by Jonathing
ECHO.

:: TODO make proper credits section to credit Bailey

:: Go to root project directory
CD ..\..

:: Check for update
PowerShell -ExecutionPolicy Bypass -NoLogo -NoProfile -File "Scripts\PowerShell Scripts\internal\check_update.ps1" %MyCMDVersion%

:: Get Forge mod name
CALL "Scripts\Windows cmd Scripts\internal\get_name.bat"

:: Set the title of the Command Prompt console
title %MyProjectName%: Eclipse Workspace

:: Set up the initial Eclipse workspace
ECHO Setting up the initial Eclipse workspace for %MyProjectName%...
ECHO.
CALL gradlew.bat eclipse --warning-mode none
ECHO.

:: Generate the Eclipse run configs
ECHO Generating the Eclipse run configurations for %MyProjectName%...
ECHO.
CALL gradlew.bat genEclipseRuns --warning-mode none
ECHO.

ECHO Initial set up for Eclipse complete.
ECHO If you need to generate the run configurations again, run the "Make Eclipse Runs.ps1" script.

:: Return to scripts directory
CD "Scripts\Windows cmd Scripts"

:: END OF SCRIPT
PAUSE
EXIT /B 0
