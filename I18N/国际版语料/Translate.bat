@echo off
set delta=diff
for %%c in (ar,en,ja,ko,th,vi) do (
	echo Translating %delta%.%%c.txt
	..\Tools\Translator.exe zh-CHS %%c %delta%.txt
)
echo OK
pause