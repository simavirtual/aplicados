# Microsoft Visual C++ generated build script - Do not modify

PROJ = WHO
DEBUG = 1
PROGTYPE = 0
CALLER = 
ARGS = 
DLLS = 
D_RCDEFINES = /d_DEBUG
R_RCDEFINES = /dNDEBUG
ORIGIN = MSVC
ORIGIN_VER = 1.00
PROJPATH =
USEMFC = 1
CC = cl
CPP = cl
CXX = cl
CCREATEPCHFLAG = 
CPPCREATEPCHFLAG = 
CUSEPCHFLAG = 
CPPUSEPCHFLAG = 
FIRSTC = WHO.C       
FIRSTCPP =             
RC = rc
CFLAGS_D_WEXE = /nologo /G2 /W3 /Zi /AL /Od /D "_DEBUG" /FR /GA /Fd"WHO.PDB"
CFLAGS_R_WEXE = /nologo /W3 /AM /O1 /D "NDEBUG" /FR /GA 
LFLAGS_D_WEXE = /NOLOGO /NOD /PACKC:61440 /ALIGN:16 /ONERROR:NOEXE /CO  
LFLAGS_R_WEXE = /NOLOGO /NOD /PACKC:61440 /STACK:10240 /ALIGN:16 /ONERROR:NOEXE  
LIBS_D_WEXE = oldnames libw llibcew commdlg.lib olecli.lib olesvr.lib shell.lib
LIBS_R_WEXE = oldnames libw mlibcew commdlg.lib olecli.lib olesvr.lib shell.lib
RCFLAGS = /nologo
RESFLAGS = /nologo
RUNFLAGS = 
DEFFILE = WHO.DEF
OBJS_EXT = 
LIBS_EXT = NOVIMP.LIB
!if "$(DEBUG)" == "1"
CFLAGS = $(CFLAGS_D_WEXE)
LFLAGS = $(LFLAGS_D_WEXE)
LIBS = $(LIBS_D_WEXE)
MAPFILE = nul
RCDEFINES = $(D_RCDEFINES)
!else
CFLAGS = $(CFLAGS_R_WEXE)
LFLAGS = $(LFLAGS_R_WEXE)
LIBS = $(LIBS_R_WEXE)
MAPFILE = nul
RCDEFINES = $(R_RCDEFINES)
!endif
!if [if exist MSVC.BND del MSVC.BND]
!endif
SBRS = WHO.SBR


WHO_DEP = who.h


WHO_RCDEP = who.ico


NOVIMP_DEP =

all:	$(PROJ).EXE $(PROJ).BSC

WHO.OBJ:	WHO.C $(WHO_DEP)
	$(CC) $(CFLAGS) $(CCREATEPCHFLAG) /c WHO.C

WHO.RES:	WHO.RC $(WHO_RCDEP)
	$(RC) $(RCFLAGS) $(RCDEFINES) -r WHO.RC


$(PROJ).EXE::	WHO.RES

$(PROJ).EXE::	WHO.OBJ $(OBJS_EXT) $(DEFFILE)
	echo >NUL @<<$(PROJ).CRF
WHO.OBJ +
$(OBJS_EXT)
$(PROJ).EXE
$(MAPFILE)
NOVIMP.LIB+
$(LIBS)
$(DEFFILE);
<<
	link $(LFLAGS) @$(PROJ).CRF
	$(RC) $(RESFLAGS) WHO.RES $@
	@copy $(PROJ).CRF MSVC.BND

$(PROJ).EXE::	WHO.RES
	if not exist MSVC.BND 	$(RC) $(RESFLAGS) WHO.RES $@

run: $(PROJ).EXE
	$(PROJ) $(RUNFLAGS)


$(PROJ).BSC: $(SBRS)
	bscmake @<<
/o$@ $(SBRS)
<<
