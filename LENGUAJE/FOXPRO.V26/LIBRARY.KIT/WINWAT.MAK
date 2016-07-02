#
#   Sample WATCOM C makefile for building an FLL from a single C
#   module.  Usage:
#
#	>wmake /f winwat.mak FLLNAME=<source name w/o extension>
#
#   For further information on building DLLs and the contents of
#   this make file consult your WATCOM C manuals.
#
#   The following two lines must be edited to reflect the directory
#   structure of your machine.
#
WATDIR = \w9		# where the WATCOM C is installed
FOXDIR = \foxlck	# location of FoxPro API libraries and PRO_EXT.H

LIBENTRY =  $(WATDIR)\lib286\win\libentry.obj

CFLAGS = /fpc /s /zu /ml /zW /zc /I$(FOXDIR);$(WATDIR)\h

FLLLNK = $(FLLNAME).lnk

OBJS = $(FLLNAME).obj $(WATDIR)\lib286\win\libentry.obj

$(FLLNAME).fll : $(OBJS) $(FLLLNK)
	set PATH=$(WATDIR)\bin;$(WATDIR)\binb
	set WATCOM=$(WATDIR)
    wlink @$(FLLLNK)
	$(WATDIR)\binb\rc -30 $(FLLNAME).exe
    @copy /b $(FLLNAME).exe+$(FLLNAME).sym
	@del $(FLLNAME).fll
	@rename $(FLLNAME).exe $(FLLNAME).fll
    @del $(FLLNAME).sym

$(FLLLNK) : winwat.mak
    %create $(FLLLNK)
    @%append $(FLLLNK) debug all
    @%append $(FLLLNK) sys windows dll
    @%append $(FLLLNK) lib $(WATDIR)\lib286\win\clibL
    @%append $(FLLLNK) lib $(WATDIR)\lib286\mathL
    @%append $(FLLLNK) lib $(WATDIR)\lib286\win\windows
    @%append $(FLLLNK) lib $(FOXDIR)\proapiwL
    @%append $(FLLLNK) name $(FLLNAME).exe
    @%append $(FLLLNK) option symfile = $(FLLNAME).sym
    @%append $(FLLLNK) option heapsize=5k
    @%append $(FLLLNK) option map
    @%append $(FLLLNK) option oneautodata
    @for %i in ($(OBJS)) do @%append $(FLLLNK) file %i

.c.obj :
	set PATH=$(WATDIR)\bin;$(WATDIR)\binb
	set WATCOM=$(WATDIR)
	wccp $(CFLAGS) $[*

