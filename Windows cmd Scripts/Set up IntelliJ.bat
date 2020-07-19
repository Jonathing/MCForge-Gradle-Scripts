:: Disable echoing commands onto the console
@ECHO off

:: Clear the screen
CLS

SET MCGradleAuthor=Jonathing
SET MCGradleVersion=0.4.1

:: Print script information
ECHO MCGradle Scripts (for Windows Command Prompt)
ECHO Version %MCGradleVersion%
ECHO Written and Maintained by %MCGradleAuthor%
ECHO.

:: TODO make proper credits section to credit Bailey

:: Go to root project directory
CD ..\..

:: Check for update
PowerShell -ExecutionPolicy Bypass -NoLogo -NoProfile -File "Scripts\PowerShell Scripts\internal\check_update.ps1" %MCGradleVersion%

:: Get Forge mod name
CALL "Scripts\Windows cmd Scripts\internal\get_name.bat"

:: Set the title of the Command Prompt console
title %MCProjectName%: IntelliJ IDEA Workspace

ECHO The IntelliJ IDEA workspace for Forge is no longer set up through a command.
ECHO To import the project to IntelliJ IDEA, simply open the "build.gradle" file as a project.
ECHO Gradle will do the rest for you as it imports and indexes the project into IntelliJ.
ECHO.

:: Return to scripts directory
CD "Scripts\Windows cmd Scripts"

:: END OF SCRIPT
PAUSE
EXIT /B 0
