rem
rem  96.03.15  SETMVC.BAT
rem
rem  This batch file sets up environment variables for a Microsoft C/C++
rem  compile
rem

call SETALL.BAT
set BLICOMCMD=cl -c -AL -Fo%BLIOBJDIR% -W3
set BLICOMNME=M
set BLIDLLOPT=-GD -Gs
set BLIWINOPT=-GA -Gs

