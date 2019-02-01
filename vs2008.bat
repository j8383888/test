@echo off
set devenv_setup=%VS90COMNTOOLS:Common7\Tools\=VC\vcvarsall.bat%
call "%devenv_setup%" x86
title Microsoft Visual Studio 2008