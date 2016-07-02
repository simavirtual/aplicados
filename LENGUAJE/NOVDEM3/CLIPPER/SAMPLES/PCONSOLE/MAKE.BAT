@echo off

if "%1%" == "DEL" goto delold
if "%1%" == "Del" goto delold
if "%1%" == "del" goto delold
if "%2%" == "DEL" goto delold
if "%2%" == "Del" goto delold
if "%2%" == "del" goto delold
goto make

:delold
del pconsol2.exe > NUL
del *.obj > NUL
del *.bif > NUL

:make
rmake pconsol2.rmk

if errorlevel == 1 goto end
if "%1%" == "ONLY" goto end
if "%1%" == "Only" goto end
if "%1%" == "only" goto end
if "%2%" == "ONLY" goto end
if "%2%" == "Only" goto end
if "%2%" == "only" goto end

@echo on
pconsol2

:end
