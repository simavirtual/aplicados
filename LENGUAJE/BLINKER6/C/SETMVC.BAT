@echo off
rem
rem  97.12.17  SETMVC.BAT
echo.
echo This batch file SETMVC.BAT sets up environment variables for a
echo Microsoft Visual C/C++ compile using T.NMK or MAKE.BAT.

if exist SETALL.BAT call SETALL.BAT
if exist ..\SETALL.BAT call ..\SETALL.BAT
if exist ..\..\SETALL.BAT call ..\..\SETALL.BAT

set BLICOMCMD=cl -c -AL -Fo%BLIOBJDIR% -W3
set BLICOMNME=M
set BLIDLLOPT=-GD -Gs
set BLIWINOPT=-GA -Gs

