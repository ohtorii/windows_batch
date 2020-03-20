@echo off
setlocal
set SRC=%~1
set DST=%~dpn1.right_90%~x1
ffmpeg -i "%SRC%" -acodec copy -vf "transpose=1" "%DST%"
