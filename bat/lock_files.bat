@echo off
REM 
REM �t�@�C�������b�N����
REM 
REM �t�@�C�������L���[�h�ŊJ�����b�N���܂�
REM 
REM lock_files.bat file1 file2 ...
REM 

powershell -File %~dp0bin\LockFiles.ps1 %*
