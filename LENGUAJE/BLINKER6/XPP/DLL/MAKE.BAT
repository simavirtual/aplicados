:
:  MAKE.BAT         Blinker batch file to make Xbase++ DLL example
:
xpp -q -OMF /b /dDEBUG /dll XDLL1.PRG
xppfilt XDLL1.OBJ -f:XDLL1.DEF
aimplib -OMF XDLL1.DEF /oXDLL1.LIB
xpp -q -OMF /b /dDEBUG /dll XDLL2.PRG
xppfilt XDLL2.OBJ -f:XDLL2.DEF
aimplib -OMF XDLL2.DEF /oXDLL2.LIB
xpp -q -OMF /b /dDEBUG MAIN.PRG
blinker @xdll1
blinker @xdll2
blinker @main
