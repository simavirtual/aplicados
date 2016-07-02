@echo off
rem
rem  96.03.23  MAKE.BAT
echo.
echo This batch file compiles and links the sample programs to create
echo a DOS extended EXE which uses a DOS extended DLL.
echo.
if not "%BLICOMCMD%" == "" goto ok
echo.
echo First run BLINKER\C\SETMVC.BAT to set up Microsoft Visual C++ environment
echo        or BLINKER\C\SETBCP.BAT to set up Borland C++ environment
echo.
goto exit
:ok
%BLICOMCMD% t.c

%BLICOMCMD% %BLIDLLOPT% d.c
%BLILNKCMD% @d%BLICOMNME% out %BLIOUTDIR%d.dll %BLILNKOPT%

BLILIB /ID %BLIOUTDIR%d.dll /OL %BLIOUTDIR%d.lib /SM /NP

%BLILNKCMD% @t%BLICOMNME% out %BLIOUTDIR%t.exe %BLILNKOPT%
:exit
