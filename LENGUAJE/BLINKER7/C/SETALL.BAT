@echo off
rem
rem  97.12.17  SETALL.BAT
echo.
echo This batch file SETALL.BAT is called by the SETxxx.BAT files and sets
echo up global environment variables to be used by each MAKE.BAT.
echo.
echo If you modify the BLIOBJDIR or BLIOUTDIR settings then make sure
echo that each path ends with a '\'. E.g. BLIOBJDIR=\MYAPP\OBJ\
echo.

set BLIOBJDIR=.\
set BLIOUTDIR=.\
set BLILNKCMD=blinker
set BLILNKOPT=map s,a

