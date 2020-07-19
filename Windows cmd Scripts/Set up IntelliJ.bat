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
IF defined PWSHPOLICY (title %MyProjectName%: IntelliJ IDEA Workspace) ELSE (title IntelliJ IDEA Workspace)

ECHO The IntelliJ IDEA workspace for Forge is no longer set up through a command.
ECHO To import the project to IntelliJ IDEA, simply open the "build.gradle" file as a project.
ECHO Gradle will do the rest for you as it imports and indexes the project into IntelliJ.
ECHO.

:: Return to scripts directory
CD "Scripts\Windows cmd Scripts"

:: END OF SCRIPT
PAUSE
EXIT /B 0
