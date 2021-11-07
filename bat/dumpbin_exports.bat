@echo off
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
dumpbin.exe /exports %1
pause
