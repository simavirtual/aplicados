rem
rem  96.03.15  SETBCP.BAT
rem
rem  This batch file sets up environment variables for a Borland C/C++
rem  compile
rem

call SETALL.BAT
set BLICOMCMD=bcc -c -ml -n%BLIOBJDIR% -w -I%INCLUDE%
set BLICOMNME=B
set BLIDLLOPT=-tWDE
set BLIWINOPT=-tWE

