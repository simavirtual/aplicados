rem
rem  96.03.15  SETCLP.BAT
rem
rem  This batch file sets up environment variables for a CA-Clipper
rem  compiler.
rem
rem  Set the version of CA-Clipper in the BLICOMVER variable.
rem
rem  If you modify the BLIOBJDIR or BLIOUTDIR settings then make sure
rem  that each path ends with a '\'. E.g. BLIOBJDIR=\MYAPP\OBJ\.
rem

set BLIOBJDIR=.\
set BLIOUTDIR=.\
set BLILNKCMD=blinker
set BLILNKOPT=map s,a
set BLICOMCMD=clipper.exe
set BLICOMOPT=/m /n /o%BLIOBJDIR%
set BLICOMVER=52

