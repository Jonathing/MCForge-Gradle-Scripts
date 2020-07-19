:: Disable echoing commands onto the console
@ECHO off

:: Clear the screen
CLS

SET MyCMDAuthor=Jonathing
SET MyCMDVersion=0.4.1

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
title %MyProjectName%: IntelliJ IDEA Run Configurations

:: Generate the IntelliJ IDEA run configs
ECHO Generating the IntelliJ IDEA run configurations for %MyProjectName%...
ECHO.
CALL gradlew.bat genIntellijRuns --warning-mode none
ECHO.

ECHO Finished generating the IntelliJ IDEA run configurations for %MyProjectName%.

:: Return to scripts directory
CD "Scripts\Windows cmd Scripts"

:: END OF SCRIPT
PAUSE
EXIT /B 0
