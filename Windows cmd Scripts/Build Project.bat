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

:: Set the title of the Command Prompt console
IF defined PWSHPOLICY (title %MyProjectName%: Build Project) ELSE (title Build Project)

:: Build Blue Skies
echo Building %MyProjectName%...
echo.
call gradlew.bat build --warning-mode none
echo.

echo Finished building %MyProjectName%.
echo If the build was successful, the output should be located under build\libs

cd "Scripts\Windows cmd Scripts"
pause
exit /B 0
