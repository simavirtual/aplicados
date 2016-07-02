#
#   WATCOM C makefile for building FPATH.FLL
#
#   The following two lines must be edited to reflect the directory
#   structure of your machine.
#
WATDIR = \w9		# where the WATCOM C is installed
FOXDIR = \foxlck	# location of FoxPro API libraries and PRO_EXT.H

LIBENTRY =  $(WATDIR)\lib286\win\libentry.obj

CFLAGS = /fpc /s /zu /ml /zW /zc /I$(FOXDIR);$(WATDIR)\h

FLLLNK = fpath.lnk

OBJS = fpath.obj $(WATDIR)\lib286\win\libentry.obj

fpath.fll : $(OBJS) $(FLLLNK)
	set PATH=$(WATDIR)\bin;$(WATDIR)\binb
	set WATCOM=$(WATDIR)
    wlink @$(FLLLNK)
	$(WATDIR)\binb\rc -30 fpath.exe
    @copy /b fpath.exe+fpath.sym
	@del fpath.fll
	@rename fpath.exe fpath.fll
    @del fpath.sym

$(FLLLNK) :
    %create $(FLLLNK)
    @%append $(FLLLNK) debug all
    @%append $(FLLLNK) sys windows dll
    @%append $(FLLLNK) lib $(WATDIR)\lib286\win\clibL
    @%append $(FLLLNK) lib $(WATDIR)\lib286\mathL
    @%append $(FLLLNK) lib $(WATDIR)\lib286\win\windows
    @%append $(FLLLNK) lib $(FOXDIR)\proapiwL
    @%append $(FLLLNK) import printdlg commdlg.printdlg
    @%append $(FLLLNK) name fpath.exe
    @%append $(FLLLNK) option symfile = fpath.sym
    @%append $(FLLLNK) option heapsize=5k
    @%append $(FLLLNK) option map
    @%append $(FLLLNK) option oneautodata
    @for %i in ($(OBJS)) do @%append $(FLLLNK) file %i

.c.obj :
	set PATH=$(WATDIR)\bin;$(WATDIR)\binb
	set WATCOM=$(WATDIR)
	wccp $(CFLAGS) $[*

