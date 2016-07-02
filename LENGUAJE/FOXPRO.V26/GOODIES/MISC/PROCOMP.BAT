@echo off
REM   PROCOMP.BAT
REM
REM   Uso:
REM
REM      procomp plantilla
REM
REM        - o bien -
REM
REM	 procomp /s plantilla
REM
if %1x == x goto noarg
fls %1 %2 >$files.lst
fox procomp
erase $files.lst
goto alldone
:noarg
echo 
echo Uso:    procomp plantilla_archivo
echo 
:alldone
