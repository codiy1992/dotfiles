@echo off
for /f "tokens=3 delims=: " %%I in ('netsh interface IPv4 show addresses "vEthernet (WSL)" ^| findstr /C:"IP "') do set ip==%%I
set ipAddress=%ip:~1%
Powershell.exe wsl "DISPLAY='%ipAddress%':0" %1