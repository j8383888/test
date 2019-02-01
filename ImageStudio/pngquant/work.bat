@echo off

set workpath=C:\workspace\cocos2d-x\projects\fxjs-cn\Resources\image


for /R %workpath% %%s in (*) do ( 
pngquant.exe --force --verbose --ext .png --quality=45 %%s
)


