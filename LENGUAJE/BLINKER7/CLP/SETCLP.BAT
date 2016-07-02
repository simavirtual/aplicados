@echo off
rem
rem  96.03.23  SETCLP.BAT
echo.
echo This batch file SETCLP.BAT sets up environment variables for a
echo CA-Clipper compiler.
echo.
echo Set the version of CA-Clipper in the BLICOMVER variable.
echo.
echo If you modify the BLIOBJDIR or BLIOUTDIR settings then make sure
echo that each path ends with a '\'. E.g. BLIOBJDIR=\MYAPP\OBJ\.
echo.

set BLIOBJDIR=.\
set BLIOUTDIR=.\
set BLILNKCMD=blinker
set BLILNKOPT=map s,a
set BLICOMCMD=clipper.exe
set BLICOMOPT=/m /n /o%BLIOBJDIR%
set BLICOMVER=52

