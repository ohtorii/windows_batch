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
	call :Main %%q
)

pause
exit /b 0


:Main
	pushd %1
	if "!errorlevel!" neq "0" (
		echo %1
		exit /b 1
	)
	
	call :GetDirName %1
	echo !CDN!
	"%CONVERT%" *.* "!CDN!.pdf"
	popd
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