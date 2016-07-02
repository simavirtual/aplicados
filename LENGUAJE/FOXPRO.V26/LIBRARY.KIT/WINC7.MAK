#
#   Sample MS C/C++ 7 makefile for building an FLL from a single C
#   module.  Also works with Microsoft Visual C++.  Usage:
#
#	>nmake FLLNAME=<source without extension> /F winc7.mak
#
#   For further information on building DLLs and the contents of
#   this make file consult the MS C/C++ 7 E&T and Guide to
#   Programming (Ch. 20 DLLs) manuals.
#
#   The following two lines must be edited to reflect the directory
#   structure of your machine.
#
C7DIR  = \windev        # where Microsoft C7 is installed
FOXDIR = \foxlck	# location of FoxPro API libraries and PRO_EXT.H

LIBENTRY = $(C7DIR)\lib\libentry.obj
#
#   Compile setup
#
CC = cl
CFLAGS = /c /ALw  # large memory model; SS != DS; DS not loaded at fn entry
CFLAGS = $(CFLAGS) /DWINVER=0x0300
CFLAGS = $(CFLAGS) /FPc     # calls floating point emulator library
CFLAGS = $(CFLAGS) /GD	    # fn entry code optimized for Windows DLLs
CFLAGS = $(CFLAGS) /Gs	    # suppress stack checking (see GP p. 483)
CFLAGS = $(CFLAGS) /I$(FOXDIR)
CFLAGS = $(CFLAGS) /I$(C7DIR)\include
CFLAGS = $(CFLAGS) /Oegs    # optimizations (optional)
CFLAGS = $(CFLAGS) /W2	    # set warning level as desired
#
#   Link setup
#
MAPFILE  = NUL

LINKER = $(C7DIR)\bin\link
LFLAGS = /ONERROR:NOEXE 	# do not write EXE on error
LFLAGS = $(LFLAGS) /NOF 	# no far call optimization

OBJS  = $(FLLNAME).obj $(LIBENTRY)

LIBS = $(FOXDIR)\proAPImL.LIB
LIBS = $(LIBS) LIBW.LIB
LIBS = $(LIBS) /NOD:LLIBCE LDLLCEW  # use DLL library

DEF_FILE = c7.DEF
FILES = $(OBJS) $(DEF_FILE)	    # link depends

#
#   The pieces come together
#
all: $(FLLNAME).fll

$(FLLNAME).obj : $(FLLNAME).C $(FOXDIR)\pro_ext.h
	set PATH=$(C7DIR)\bin;%PATH%
	@$(CC) @<<$(FLLNAME).rsp
		$(CFLAGS) /Fo$(FLLNAME).obj $(FLLNAME).C
<<

$(FLLNAME).fll : $(FILES)
	set PATH=$(C7DIR)\bin;%PATH%
	set LIB=$(C7DIR)\lib
#
#   Write linker arguments to response file
#
        echo > NUL @<<$(FLLNAME).lrf
	$(OBJS: = +^
	)
	$@
	$(MAPFILE)
	$(LIBS: = +^
	)
	$(DEF_FILE) $(LFLAGS);
<<
	$(LINKER) @$(FLLNAME).lrf
