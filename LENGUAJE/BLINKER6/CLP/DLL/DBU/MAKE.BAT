@echo off
rem
rem  96.03.23  MAKE.BAT
echo.
echo This batch file compiles and links the sample programs to create
echo a DOS extended EXE which uses DBU from a DLL.
echo.

call ..\..\setclp.bat                   Set the environment variables

%BLICOMCMD% t.prg %BLICOMOPT%
%BLILNKCMD% @t out %BLIOUTDIR%t.exe %BLILNKOPT%

%BLILNKCMD% @dbudll out %BLIOUTDIR%dbudll.dll %BLILNKOPT%

