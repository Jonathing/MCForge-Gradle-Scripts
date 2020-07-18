:: Disable echoing commands onto the console
@echo off

set MyCMDAuthor=Jonathing
set MyCMDVersion=0.3.2

:: Print script information
echo MCGradle Scripts (for Windows Command Prompt)
echo Version %MyCMDVersion%
echo Originally Written by Jonathing and Bailey
echo Maintained by %MyCMDAuthor%
echo.

:: Check for update
cd internal
call check_update.bat
cd ..

cd ..\..

call "Scripts\Windows cmd Scripts\internal\get_title.bat"

IF defined PWSHPOLICY (title %MyProjectName%: IntelliJ IDEA Workspace) ELSE (title IntelliJ IDEA Workspace)
echo The IntelliJ IDEA workspace for Forge is no longer set up through a command.
echo To import the project to IntelliJ IDEA, simply open the "build.gradle" file as a project.
echo Gradle will do the rest for you as it imports and indexes the project into IntelliJ.
echo.

cd "Scripts\Windows cmd Scripts"
pause
exit /b