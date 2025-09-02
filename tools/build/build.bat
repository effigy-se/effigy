@echo off
del "effigy.rsc"
"%~dp0\..\bootstrap\javascript.bat" "%~dp0\build.ts" %*
