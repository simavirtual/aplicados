#
#	Sample WATCOM makefile for building DOS 2.5 PLBs.  Usage:
#
#	    >wmake /f doswat.mak PLBNAME=<name> MODEL=<model>
#
#	where <name> does NOT include a file extension and <model> is
#	one of s, m, l, or c.
#
WATDIR = \foxpro\200\lck	# where the WATCOM is installed
FOXDIR = \foxlck		# location of FoxPro API
				# libraries,  API_m.OBJ files, and PRO_EXT.H

!ifeq MODEL
!undef	MODEL
MODEL=L
!endif

CFLAGS = /ol /of /s /m$(MODEL) /zu /d2 /fpc /i=$(FOXDIR);$(WATDIR)\h
#
#   /ol           optimizations (optional)
#   /of 	  entry code
#   /s		  suppress stack checking (optional)
#   /zu 	  SS != DS
#   /fpc	  use floating point calls
#
$(PLBNAME).plb : $(PLBNAME).OBJ $(PLBNAME).lnk
	set path=$(WATDIR)\bin;$(WATDIR)\binb;%PATH%
	set watcom=$(WATDIR)
	wlink @$(PLBNAME).lnk
	wc2ms < $(PLBNAME).wat > $(PLBNAME).map
#
#   Build linker response file
#
$(PLBNAME).lnk : $(FOXDIR)\doswat.mak
	set path=$(WATDIR)\bin;$(WATDIR)\binb;%PATH%
	set watcom=$(WATDIR)
	%create $(PLBNAME).lnk
	@%append $(PLBNAME).lnk debug all
	@%append $(PLBNAME).lnk file $(FOXDIR)\api_$(MODEL), $(PLBNAME)
	@%append $(PLBNAME).lnk lib $(FOXDIR)\proapi_$(MODEL).lib
	@%append $(PLBNAME).lnk lib $(WATDIR)\lib286\dos\clib$(MODEL)
	@%append $(PLBNAME).lnk lib $(WATDIR)\lib286\math$(MODEL)
	@%append $(PLBNAME).lnk option map=$(PLBNAME).wat
	@%append $(PLBNAME).lnk option symfile=$(PLBNAME).sym
	@%append $(PLBNAME).lnk name $(PLBNAME).plb

.c.obj : $(PLBNAME).c $(FOXDIR)\doswat.mak
	set path=$(WATDIR)\bin;$(WATDIR)\binb;%PATH%
	set watcom=$(WATDIR)
	wcc $(CFLAGS) $[*

