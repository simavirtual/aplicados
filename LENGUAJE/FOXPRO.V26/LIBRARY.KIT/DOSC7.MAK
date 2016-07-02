#
#   Sample MS C/C++ 7 makefile for building a DOS API from a single C
#   module.  Also works with Microsoft's Visual C++.  Usage:
#
#	>nmake PLBNAME=<source without extension> MODEL=<model> /F dosc7.mak
#
#   The following two lines must be edited to reflect the directory
#   structure of your machine.
#
C7DIR  = c:\windev  # where Microsoft C7 is installed
FOXDIR = c:\foxlck  # location of FoxPro API

CC = cl
#
#   Uppercase MODEL because cl options are case sensitive
#
!IF "$(MODEL)" == "s"
MM = S
!ELSE IF "$(MODEL)" == "m"
MM = M
!ELSE IF "$(MODEL)" == "l"
MM = L
!ELSE IF "$(MODEL)" == ""       # default to large if memory model not spec'd
MM = L
!ELSE
MM = $(MODEL)
!ENDIF

CFLAGS = /A$(MM)w /Zp /GW /I$(FOXDIR) /I$(C7DIR)\include /Fs$(PLBNAME).lst

LINKER = $(C7DIR)\bin\link
# LFLAGS = /ONERROR:NOEXE /NOF
LFLAGS = /ONERROR:NOEXE /NOE /NONULLS

OBJS = $(FOXDIR)\api_m$(MM).obj $(PLBNAME).obj
LIBS = $(FOXDIR)\api_m$(MM).lib
MAPFILE = NUL
DEPENDS = $(PLBNAME).obj

all: $(PLBNAME).plb

$(PLBNAME).obj : $(PLBNAME).C $(FOXDIR)\pro_ext.h
	set PATH=$(C7DIR)\bin;%PATH%
	@$(CC) /c $(CFLAGS) /Fo$(PLBNAME).obj $(PLBNAME).C

$(PLBNAME).plb : $(DEPENDS)
	set PATH=$(C7DIR)\bin;%PATH%
	set LIB=$(C7DIR)\lib
	echo > NUL @<<$(PLBNAME).lrf
        $(OBJS: = +^
	)
	$@
	$(MAPFILE)
	$(LIBS: = +^
	)
	$(LFLAGS)
<<
	$(LINKER) @$(PLBNAME).lrf
