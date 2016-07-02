@echo off
rem
rem  97.12.17  SETBCP.BAT
echo.
echo This batch file SETBCP.BAT sets up environment variables for a
echo Borland C/C++ compile using MAKE.BAT.
echo.
echo Remember to set the version number in the names of the Blinker DOS
echo extender files C0LPnn and BLXBCPnn in the .EXE link files TB.LNK.

if exist SETALL.BAT call SETALL.BAT
if exist ..\SETALL.BAT call ..\SETALL.BAT
if exist ..\..\SETALL.BAT call ..\..\SETALL.BAT

set BLICOMCMD=bcc -c -ml -n%BLIOBJDIR% -w -I%INCLUDE%
set BLICOMNME=B
set BLIDLLOPT=-tWDE
set BLIWINOPT=-tWE

