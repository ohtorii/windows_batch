@echo off
setlocal
set SRC=%~1
set DST=%~dpn1.silent%~x1
ffmpeg -i "%SRC%" -vcodec copy -an "%DST%"
