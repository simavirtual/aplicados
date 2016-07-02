rem
rem  96.03.15  SETALL.BAT
rem
rem  This batch file is called by the SETxxx.BAT files and sets up
rem  global environment variables to be used by each MAKE.BAT.
rem
rem  If you modify the BLIOBJDIR or BLIOUTDIR settings then make sure
rem  that each path ends with a '\'. E.g. BLIOBJDIR=\MYAPP\OBJ\.
rem

set BLIOBJDIR=.\
set BLIOUTDIR=.\
set BLILNKCMD=blinker
set BLILNKOPT=map s,a

