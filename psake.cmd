@echo off

if '%1'=='/?' goto help
if '%1'=='-help' goto help
if '%1'=='-h' goto help

powershell -NoProfile -ExecutionPolicy Bypass -Command "Install-Module VSSetup -Scope CurrentUser"

tools\nuget\nuget.exe restore CentauroTech.Utils.CacheTags.sln

powershell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0\packages\psake.4.7.1\tools\psake\psake.ps1' '%~dp0\scripts\build.ps1' %*; if ($psake.build_success -eq $false) { exit 1 } else { exit 0 }"
exit /B %errorlevel%

:help
powershell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0\packages\psake.4.7.1\tools\psake\psake.ps1' -help"
