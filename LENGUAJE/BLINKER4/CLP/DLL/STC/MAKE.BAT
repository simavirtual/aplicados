rem
rem  96.03.15  MAKE.BAT
rem
rem  This batch file compiles and links the sample programs to create
rem  a DOS extended EXE which uses a statically linked DLL.
rem

call ..\..\setclp.bat                   Set the environment variables

%BLICOMCMD% t.prg %BLICOMOPT%
%BLILNKCMD% @t%BLICOMVER% out %BLIOUTDIR%t.exe %BLILNKOPT%

%BLICOMCMD% d.prg %BLICOMOPT%
%BLILNKCMD% @d%BLICOMVER% out %BLIOUTDIR%d.dll %BLILNKOPT%

