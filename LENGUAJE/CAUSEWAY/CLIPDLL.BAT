@echo off
rem Demonstration of using DLLs with CA-Clipper 5.2 and
rem  assembly language subroutines
rem
rem Make the TEST DLL, don't give it an extension since the internal module
rem  name is the same name as the binary image.
rem
rem If ML.EXE isn't present, use included TESTDLL.OBJ by default
rem
ml /c /nologo testdll.asm >nul
wl32 /3p testdll,testdll. >nul

rem Rename the file to have a DLL extension after it is built and
rem  CauseWay will search it out.
rem
rem If <module name>.DLL is not found at runtime, CauseWay will then search
rem  for an EXE extension before terminating with an error
rem 
erase testdll.dll
erase testdll.exe
ren testdll. testdll.dll

rem Make the second TEST DLL
rem
ml /c /nologo testdll2.asm >nul
wl32 /3p testdll2,testdll2. >nul
erase testdll2.dll
ren testdll2. testdll2.dll

rem Make an Import OBJ for TEST DLL
rem Use LIB to make an Import library, if preferred
rem
3plib /i testdll.dll testimp.obj >nul

rem Make an Import OBJ for second TEST DLL
rem Use LIB to make an Import library, if preferred
rem
3plib /i testdll2.dll testimp2.obj >nul

rem Compile the calling code routines
rem
clipper clipcall /q >nul
clipper cpcall2 /q >nul
ml /c /nologo clwrap.asm >nul

rem Make the final EXEs which call the TEST DLLs
rem Link calling program with Import OBJs
rem
wl32 /ls clipcall clwrap testimp testimp2,,,lsclp52 >nul
wl32 /ls cpcall2 clwrap testimp testimp2,,,lsclp52 >nul

rem Now show it works
rem
cls
@echo TESTDLL.DLL and TESTDLL2.DLL show initialization messages at startup.
@echo TESTDLL displays value passed to it by CLIPCALL application,
@echo   along with ONEPROC and TWOPROC hello messages.
@echo TESTDLL2 displays THREEPROC and FOURPROC hello messages.
@echo TESTDLL and TESTDLL2 show exiting messages at termination.
clipcall
pause

rem Show that CauseWay will find the DLL with a .EXE extension
ren testdll.dll testdll.exe
cls
@echo TESTDLL.EXE and TESTDLL2.DLL show initialization messages at startup.
@echo TESTDLL displays value passed to it by CLIPCALL application,
@echo   along with ONEPROC and TWOPROC hello messages.
@echo TESTDLL2 displays THREEPROC and FOURPROC hello messages.
@echo TESTDLL and TESTDLL2 show exiting messages at termination.
clipcall
pause

rem Now call the same DLLs with a different application (CPCALL2)
rem
cls
@echo TESTDLL.EXE and TESTDLL2 show initialization messages at startup.
@echo TESTDLL displays value passed to it by CPCALL2 application,
@echo   along with ONEPROC and TWOPROC hello messages.
@echo TESTDLL2 displays THREEPROC and FOURPROC hello messages.
@echo TESTDLL and TESTDLL2 show exiting messages at termination.
cpcall2
pause

rem Get a little fancy, make the alternate TEST DLL
rem and call things again without changing the main program
rem (only works with identical exports)
rem
ml /c /nologo testdll3.asm >nul
wl32 /3p testdll3,testdll. >nul
erase testdll.exe
ren testdll. testdll.dll
cls
@echo New TESTDLL.DLL and old TESTDLL2 show initialization messages at startup.
@echo TESTDLL displays value passed to it by CLIPCALL application,
@echo   along with ONEPROC and TWOPROC hello messages.
@echo TESTDLL2 displays THREEPROC and FOURPROC hello messages.
@echo TESTDLL and TESTDLL2 show exiting messages at termination.
clipcall
