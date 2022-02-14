Set oShell = CreateObject ("Wscript.Shell") 
Dim strArgs
strArgs = "cmd /c wsl-app-runner.bat google-chrome"
oShell.Run strArgs, 0, false
