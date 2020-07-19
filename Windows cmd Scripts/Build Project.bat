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

:: Check for update
CD internal
CALL check_update.bat
CD ..

:: Go to root project directory
CD ..\..

:: Get Forge mod title
CALL "Scripts\Windows cmd Scripts\internal\get_title.bat"

:: Set the title of the Command Prompt console
title %MyProjectName%: Build Project

:: Build the project
ECHO Building %MyProjectName%...
ECHO.
CALL gradlew.bat build --warning-mode none
ECHO.
ECHO Finished building %MyProjectName%.
ECHO If the build was successful, the output should be located under build\libs

:: Return to scripts directory
CD "Scripts\Windows cmd Scripts"

:: END OF SCRIPT
PAUSE
EXIT /B 0
