@echo off
setlocal
REM 
REM 実行ファイルの依存関係を表示する
REM 
call %~dp0bin\FindVsDevCmd.bat
if "%VSDEVCMD%"=="" (
    echo VisualStudio開発者用コマンドプロンプトのバッチファイルが見つかりません。
    pause
    exit /b 1
)
call "%VSDEVCMD%"
dumpbin.exe /dependents %1
pause
