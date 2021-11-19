@echo off
REM 
REM ファイルをロックする
REM 
REM ファイルを共有モードで開きロックします
REM 
REM lock_files.bat file1 file2 ...
REM 

powershell -File %~dp0bin\LockFiles.ps1 %*
