@echo off
setlocal
set FOLDER=%LOCALAPPDATA%\CrashDumps
set PATH32=HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps
set PATH64=HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\Windows Error Reporting\LocalDumps
set MINIDUMP=1
set FULLDUMP=2

REM ���W�X�g���ɒl�����邩�`�F�b�N����B
REM reg.exe QUERY "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps"

REM �l���Ȃ������Ƃ��ǉ�����p�̃R�}���h
reg.exe add "%PATH32%" /v DumpFolder /t REG_EXPAND_SZ /d "%FOLDER%" /f
reg.exe add "%PATH32%" /v DumpCount /t REG_DWORD /d 10 /f
reg.exe add "%PATH32%" /v DumpType /t REG_DWORD /d %FULLDUMP% /f
 
REM 64bit��PC�͂��������ǉ����܂��傤
reg.exe add "%PATH64%" /v DumpFolder /t REG_EXPAND_SZ /d "%FOLDER%" /f
reg.exe add "%PATH64%" /v DumpCount /t REG_DWORD /d 10 /f
reg.exe add "%PATH64%" /v DumpType /t REG_DWORD /d %FULLDUMP% /f
 