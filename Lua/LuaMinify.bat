@echo off
pushd %~dp0
if "%1" == "" (
	echo 请输入要处理的lua文件目录，并做好备份
	goto EOF
)

for /f "tokens=* delims=" %%i in ('dir /b /s "%1\*.lua"') do (
	echo ---- %%i
	pushd "LuaMinify"
	"..\5.1\lua" "CommandLineMinify.lua" "%%i" "%%i.minlua"
	popd
	copy /Y %%i.minlua %%i
	del /Q %%i.minlua
)

:EOF
pause