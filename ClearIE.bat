rem IE��������
set dest=%LOCALAPPDATA%\Microsoft\Windows\INetCache
pushd %dest%
del /f /s /q *
popd
