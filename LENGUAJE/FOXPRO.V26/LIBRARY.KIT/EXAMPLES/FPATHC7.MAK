#
#   MS C/C++ 7 makefile for building an FPATH.FLL
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

OBJS  = fpath.obj $(LIBENTRY)

LIBS = $(FOXDIR)\proAPImL.LIB
LIBS = $(LIBS) LIBW.LIB COMMDLG.LIB
LIBS = $(LIBS) /NOD:LLIBCE LDLLCEW  # use DLL library

DEF_FILE = $(FOXDIR)\c7.DEF
FILES = $(OBJS) $(DEF_FILE)	    # link depends

#
#   The pieces come together
#
all: fpath.fll

fpath.obj : fpath.C $(FOXDIR)\pro_ext.h
	set PATH=$(C7DIR)\bin;%PATH%
	@$(CC) @<<fpath.rsp
		$(CFLAGS) /Fofpath.obj fpath.C
<<

fpath.fll : $(FILES)
	set PATH=$(C7DIR)\bin;%PATH%
	set LIB=$(C7DIR)\lib
#
#   Write linker arguments to response file
#
	echo > NUL @<<fpath.lrf
	$(OBJS: = +^
	)
	$@
	$(MAPFILE)
	$(LIBS: = +^
	)
	$(DEF_FILE) $(LFLAGS);
<<
	$(LINKER) @fpath.lrf
