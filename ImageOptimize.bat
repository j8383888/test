@echo off

set "PATH=%~dp0\ImageStudio;%~dp0\ImageStudio\ImageMagick;%~dp0\ImageStudio\crunch;%~dp0\ImageStudio\pngquant;%PATH%"
echo ImageStudio PATH set OK.

"%~dp0\ImageStudio\ImageOptimize.exe" %*
