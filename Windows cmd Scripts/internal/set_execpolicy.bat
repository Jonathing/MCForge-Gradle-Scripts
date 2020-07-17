::::::::::::::::::::::::::::::::::::::::::::
:: Automatically check & get admin rights V2
::::::::::::::::::::::::::::::::::::::::::::
@echo off
REM CLS
REM ECHO.
REM ECHO =============================
REM ECHO Running Admin shell
REM ECHO =============================

:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
REM ECHO.
REM ECHO Requesting administrator privileges...

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

::::::::::::::::::::::::::::
::START
::::::::::::::::::::::::::::
REM Run shell as admin (example) - put here code as you like
REM ECHO %batchName% Arguments: %1 %2 %3 %4 %5 %6 %7 %8 %9

ECHO Setting RemoteSigned execution policy for scope CurrentUser...
PowerShell -NoLogo -NoProfile -Command "& {Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser}"
ECHO Setting RemoteSigned execution policy for scope LocalMachine...
PowerShell -NoLogo -NoProfile -Command "& {Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine}"

exit /B