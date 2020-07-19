:start
PowerShell -NoLogo -NoProfile -Command Get-ExecutionPolicy > "Scripts\PowerShell Scripts\internal\EXECPOLICY"
SET /p MyPWSHExecPolicy=<"Scripts\PowerShell Scripts\internal\EXECPOLICY"
DEL "Scripts\PowerShell Scripts\internal\EXECPOLICY"

SET "PWSHPOLICY="
IF %MyPWSHExecPolicy%==RemoteSigned SET PWSHPOLICY=1
IF %MyPWSHExecPolicy%==Unrestricted SET PWSHPOLICY=1
IF defined PWSHPOLICY (
    PowerShell -NoLogo -NoProfile -File "Scripts\PowerShell Scripts\internal\get_mod_name.ps1"
    SET /p MyProjectName=<"Scripts\PowerShell Scripts\internal\MODNAME"
    :: ECHO %MyProjectName%
    DEL "Scripts\PowerShell Scripts\internal\MODNAME"
    IF EXIST "Scripts\Windows cmd Scripts\internal\CHANGEPOLICY" (
        DEL "Scripts\Windows cmd Scripts\internal\CHANGEPOLICY"
        ECHO Your Windows PowerShell execution policy was changed successfully.
        ECHO MCGradle Scripts will now be able to get your mod's name from mods.toml.
        ECHO The batch script will now continue as normal.
        ECHO.
        PING -n 2 127.0.0.1 > nul
    )
) ELSE (
    REM SET F="Scripts\Windows cmd Scripts\internal\CHANGEPOLICY"
 
    IF EXIST "Scripts\Windows cmd Scripts\internal\CHANGEPOLICY" (
        DEL "Scripts\Windows cmd Scripts\internal\CHANGEPOLICY"
        SET MyProjectName=your Minecraft Forge Mod
        ECHO Windows PowerShell failed to set the execution policy to RemoteSigned.
        ECHO The batch script will now continue as normal.
        ECHO.
        PING -n 2 127.0.0.1 > nul
    ) ELSE (
        ECHO Your Windows PowerShell execution policy is currently set to %MyPWSHExecPolicy%.
        ECHO This means that MCGradle Scripts will not be able to get your mod's name since it uses a PowerShell script.
        ECHO MCGradle Scripts can run a script that requests admin perms and then sets the policy to RemoteSigned for you.

        :startChoice
        SET /P c="Would you like to do this now? (You may need to answer twice) [Y/N] "
        IF /I "%c%" EQU "Y" GOTO :yes
        IF /I "%c%" EQU "N" GOTO :no
        GOTO :startChoice

        :no
        SET MyProjectName=your Minecraft Forge Mod
        ECHO.
        ECHO You have chosen not to change your Windows PowerShell execution policy.
        ECHO The batch script will now continue as normal.
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
    )
)

:continue
