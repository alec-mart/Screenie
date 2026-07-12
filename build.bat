@echo off
rem Build Screenie with the C# compiler that ships with Windows (.NET Framework 4.x)
set CSC=%WINDIR%\Microsoft.NET\Framework64\v4.0.30319\csc.exe
if not exist "%CSC%" set CSC=%WINDIR%\Microsoft.NET\Framework\v4.0.30319\csc.exe
"%CSC%" /nologo /target:winexe /out:"%~dp0Screenie.exe" /r:System.dll /r:System.Drawing.dll /r:System.Windows.Forms.dll "%~dp0Screenie.cs"
if %errorlevel%==0 (echo Built Screenie.exe) else (echo BUILD FAILED)
