:: Windows Batch Files for Minecraft Forge Projects
:: Created by Jonathing
:: Updated and maintained by Bailey and Jonathing
:: Version 0.3.2

:: Disable echoing commands onto the console
@echo off

cd ..\..

:start
PowerShell -NoLogo -NoProfile -Command Get-ExecutionPolicy > "Scripts\PowerShell Scripts\internal\EXECPOLICY"
set /p MyPWSHExecPolicy=<"Scripts\PowerShell Scripts\internal\EXECPOLICY"
DEL "Scripts\PowerShell Scripts\internal\EXECPOLICY"

set "PWSHPOLICY="
IF %MyPWSHExecPolicy%==RemoteSigned set PWSHPOLICY=1
IF %MyPWSHExecPolicy%==Unrestricted set PWSHPOLICY=1
IF defined PWSHPOLICY (
    PowerShell -NoLogo -NoProfile -File "Scripts\PowerShell Scripts\internal\get_mod_name.ps1"
    set /p MyProjectName=<"Scripts\PowerShell Scripts\internal\MODNAME"
    :: echo %MyProjectName%
    DEL "Scripts\PowerShell Scripts\internal\MODNAME"
    IF EXIST "Scripts\Windows cmd Scripts\internal\CHANGEPOLICY" (
        DEL "Scripts\Windows cmd Scripts\internal\CHANGEPOLICY"
        ECHO Your Windows PowerShell execution policy was changed successfully.
        ECHO The Windows cmd Scripts will now be able to get your mod's name from mods.toml.
        ECHO The Windows cmd Script will now run as normal.
        ECHO.
        PING -n 2 127.0.0.1 > nul
    )
) ELSE (
    REM SET F="Scripts\Windows cmd Scripts\internal\CHANGEPOLICY"
 
    IF EXIST "Scripts\Windows cmd Scripts\internal\CHANGEPOLICY" (
        DEL "Scripts\Windows cmd Scripts\internal\CHANGEPOLICY"
        set MyProjectName=your Minecraft Forge Mod
        ECHO Windows PowerShell failed to set the execution policy to RemoteSigned.
        ECHO The Windows cmd Script will now run as normal.
        ECHO.
        PING -n 2 127.0.0.1 > nul
    ) ELSE (
        echo Your Windows PowerShell execution policy is currently set to %MyPWSHExecPolicy%.
        echo This means that the cmd Script will not be able to get your mod's name since it uses a PowerShell script.
        echo We can run a script that requests admin perms and then sets the policy to RemoteSigned for you.

        :startChoice
        SET /P c="Would you like to do this now? (You may need to answer twice) [Y/N] "
        IF /I "%c%" EQU "Y" goto :yes
        IF /I "%c%" EQU "N" goto :no
        goto :startChoice

        :no
        SET MyProjectName=your Minecraft Forge Mod
        ECHO.
        ECHO You have chosen not to change your Windows PowerShell execution policy.
        ECHO The Windows cmd Script will now run as normal.
        ECHO.
        PING -n 2 127.0.0.1 > nul
        GOTO continue

        :yes
        ECHO PLACEHOLDER > "Scripts\Windows cmd Scripts\internal\CHANGEPOLICY"
        CALL "Scripts\Windows cmd Scripts\internal\set_execpolicy.bat"
        ECHO.
        ECHO Attempting to change the Windows PowerShell execution policy...
        PING -n 3 127.0.0.1 > nul
        GOTO start

        REM set MyProjectName=your Minecraft Forge Mod
    )
    REM set MyProjectName=your Minecraft Forge Mod
)

:continue

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
