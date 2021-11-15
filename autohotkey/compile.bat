@echo off
SET EXE="%~dp0TextReplacements.exe"

ECHO Killing old instance...
pskill -nobanner TextReplacements.exe >NUL
TIMEOUT 1 /NOBREAK >NUL

ECHO Deleting old exe...
del "%EXE%"

ECHO Compiling new exe...
ahk2exe /in "%~dp0TextReplacements.ahk" /out "%EXE%" /icon "%~dp0replace.ico" /bin "C:\Program Files\AutoHotkey\Compiler\Unicode 64-bit.bin" /mpress 1
TIMEOUT 1 /NOBREAK >NUL

ECHO Starting new exe...
start "" "%EXE%"

PAUSE