@echo off
rem
rem  97.12.17  MAKE.BAT
echo.
echo This batch file compiles and links the sample programs to create
echo a DOS extended EXE which uses a dynamically linked Windows DLL.
echo.
if not "%BLICOMCMD%" == "" goto ok
echo.
echo First run BLINKER\C\SETMVC.BAT to set up Microsoft Visual C++ environment
echo        or BLINKER\C\SETBCP.BAT to set up Borland C++ environment
echo.
goto exit
:ok
%BLICOMCMD% t.c
%BLILNKCMD% @t%BLICOMNME% out %BLIOUTDIR%t.exe %BLILNKOPT%

%BLICOMCMD% %BLIDLLOPT% d.c
%BLILNKCMD% @dw%BLICOMNME% out %BLIOUTDIR%d.dll %BLILNKOPT%

%BLICOMCMD% %BLIWINOPT% tw.c
%BLILNKCMD% @tw%BLICOMNME% out %BLIOUTDIR%tw.exe %BLILNKOPT%
:exit
