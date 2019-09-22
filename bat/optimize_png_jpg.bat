@echo off

REM
REM png,jpgのファイルサイズを小さくする
REM
REM 【使い方】
REM png,jpgファイル（複数可）をドロップする
REM 

setlocal

pushd "%~dp1"
if "%errorlevel%" NEQ "0" goto Exit

for %%q in (%*) do (
	echo TARGET FILE : %%~nxq
	if /I "%%~xq" == ".png" call :OPTIMIZE_PNG %%~nxq
	if /I "%%~xq" == ".jpg" call :OPTIMIZE_JPG %%~nxq
)
popd

:Exit
pause
exit /b 0



REM *** SUBROUTINE ***

:OPTIMIZE_PNG
	pngquant.exe --force --verbose --floyd=1 --speed=1 --output quantized_%1 --quality=40-60 "%1"
	REM Node.jsのbatchコマンドなのでcallで呼び出す
	call zopflipng.cmd -y --lossy_transparent --lossy_8bit --iterations=15 --filters=0me "quantized_%1" "optimized_%1"
	del /F "quantized_%1"
	exit /b


:OPTIMIZE_JPG
	setlocal
	set ORIENTATION=0
	for /f "usebackq tokens=*" %%i in (`identify -format "%%[EXIF:Orientation]" %1`) do set ORIENTATION=%%i
	if %ORIENTATION% == 6 (
		convert -strip %1 tmp_%1
		convert tmp_%1 -rotate +90 strip_%1
	) else (
		convert -strip %1 strip_%1
	)
	endlocal
	cjpeg-static -quality 80 -outfile optimized_%1 strip_%1
	if exist tmp_%1 ( del /F tmp_%1 )
	del /F strip_%1
	exit /b


