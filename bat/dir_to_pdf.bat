@echo off

REM 
REM ディレクトリ内の全ファイルをPDFへ変換する
REM 
REM 【使い方】
REM ディレクトリ（複数可）をドロップする
REM 

setlocal enabledelayedexpansion

set CONVERT=%ChocolateyInstall%\bin\convert.exe

for %%q in (%*) do (
REM 	echo %%q
	pushd %%q
	call :GetDirName %%q
	echo !CDN!
	"%CONVERT%" *.* "!CDN!.pdf"
	popd
)

:Exit
pause
exit /b 0



:GetDirName
	REM 
	REM %1   =C:\Document and Setting/foo/workspace
	REM %CDN%=workspace
	REM 
	set CDN=%1
	set CDN=%CDN:"=%
	set CDN=%CDN:/=\%
	if "%CDN:~-1%"=="\" (set CDN=%CDN:~0,-1%)

	:loop_CDN
	set CDN=%CDN:*\=%
	if not "%CDN:*\=%"=="%CDN%" (goto loop_CDN)

	exit /b 0