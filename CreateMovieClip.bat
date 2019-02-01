@echo off

set CreateMovieClip="%~dp0\ImageStudio\CreateMovieClip\CreateMovieClip.exe"
if "%1"=="" (
echo CreateMovieClip
%CreateMovieClip%
pause
)else (
call ImageStudio
call ImagePack egret * -margin:1
%CreateMovieClip% %*
)