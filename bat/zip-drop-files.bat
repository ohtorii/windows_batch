@echo off
REM 
REM dropしたファイルル、フォルダをzipに固める
REM 

setlocal enabledelayedexpansion
for %%q in (%*) do call :Main %%q

pause
exit /b 0

:Main
	call :GetDirName %1
	set PARENT_DIR=%~dp1
	7z.exe a "!PARENT_DIR!\!CDN!.zip" %1
	exit /b 0

:GetDirName
	REM 
	REM %1   =C:\Document and Setting/foo/workspace
	REM %CDN%=workspace
	REM 
	set CDN=%1
	set CDN=%CDN:"=%
	set CDN=%CDN:/=\%
	if "%CDN:~-1%"=="\" set CDN=%CDN:~0,-1%

	:loop_CDN
	set CDN=%CDN:*\=%
	if not "%CDN:*\=%"=="%CDN%" goto loop_CDN

	exit /b 0