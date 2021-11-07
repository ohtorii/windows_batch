REM 
REM VisualStudioの開発者用コマンドプロンプトのパスを見付ける
REM 
REM 返値
REM 環境変数（VSDEVCMD）でパスを返します。
REM 
@echo off
setlocal
set VS2019=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\VsDevCmd.bat
set VS2017=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\VsDevCmd.bat

if exist %VS2019% (
    endlocal && set VSDEVCMD=%VS2019%
    exit /b 0
)

if exist %VS2017% (
    endlocal && set VSDEVCMD=%VS2017%
    exit /b 0
)