@echo off
rem
rem  96.03.23  MAKE.BAT
echo.
echo This batch file compiles and links the sample programs to create
echo a DOS extended EXE which uses a dynamically linked DLL.
echo.

call ..\..\setclp.bat                   Set the environment variables

%BLICOMCMD% t.prg %BLICOMOPT%
%BLILNKCMD% @t%BLICOMVER% out %BLIOUTDIR%t.exe %BLILNKOPT%

%BLICOMCMD% d.prg %BLICOMOPT%
%BLILNKCMD% @d%BLICOMVER% out %BLIOUTDIR%d.dll %BLILNKOPT%

