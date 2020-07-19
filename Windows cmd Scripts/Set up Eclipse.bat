:: Disable echoing commands onto the console
@ECHO off

SET MyCMDAuthor=Jonathing
SET MyCMDVersion=0.3.2

:: Print script information
ECHO MCGradle Scripts (for Windows Command Prompt)
ECHO Version %MyCMDVersion%
ECHO Originally Written by Jonathing and Bailey
ECHO Maintained by %MyCMDAuthor%
ECHO.

:: Check for update
CD internal
CALL check_update.bat
CD ..

:: Go to root project directory
CD ..\..

:: Get Forge mod title
CALL "Scripts\Windows cmd Scripts\internal\get_title.bat"

:: Set the title of the Command Prompt console
IF defined PWSHPOLICY (title %MyProjectName%: Eclipse Workspace) ELSE (title Eclipse Workspace)

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
