@echo off
REM 
REM ���s�t�@�C���̈ˑ��֌W��\������
REM 
call %~dp0bin\FindVsDevCmd.bat
if "%VSDEVCMD%"=="" (
    echo VisualStudio�J���җp�R�}���h�v�����v�g�̃o�b�`�t�@�C����������܂���B
    pause
    exit /b 1
)
call "%VSDEVCMD%"
dumpbin.exe /exports %1
pause
