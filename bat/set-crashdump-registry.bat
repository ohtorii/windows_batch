@echo off
setlocal
set FOLDER=%LOCALAPPDATA%\CrashDumps
set PATH32=HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps
set PATH64=HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\Windows Error Reporting\LocalDumps
set MINIDUMP=1
set FULLDUMP=2

REM レジストリに値があるかチェックする。
REM reg.exe QUERY "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps"

REM 値がなかったとき追加する用のコマンド
reg.exe add "%PATH32%" /v DumpFolder /t REG_EXPAND_SZ /d "%FOLDER%" /f
reg.exe add "%PATH32%" /v DumpCount /t REG_DWORD /d 10 /f
reg.exe add "%PATH32%" /v DumpType /t REG_DWORD /d %FULLDUMP% /f
 
REM 64bitのPCはこっちも追加しましょう
reg.exe add "%PATH64%" /v DumpFolder /t REG_EXPAND_SZ /d "%FOLDER%" /f
reg.exe add "%PATH64%" /v DumpCount /t REG_DWORD /d 10 /f
reg.exe add "%PATH64%" /v DumpType /t REG_DWORD /d %FULLDUMP% /f
 