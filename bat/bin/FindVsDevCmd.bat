REM 
REM VisualStudio�̊J���җp�R�}���h�v�����v�g�̃p�X�����t����
REM 
REM �Ԓl
REM ���ϐ��iVSDEVCMD�j�Ńp�X��Ԃ��܂��B
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