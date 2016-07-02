#
#  96.03.15  T.MAK
#
#  This sample make file demonstrates how to create a DOS
#  extended EXE which uses a DOS extended DLL.
#

!include ..\..\all.mak                  # Standard make file definitions

ALL       ::        $(OUTDIR)\t.exe
ALL       ::        $(OUTDIR)\d.dll

$(OUTDIR)\t.exe:    $(OBJDIR)\t.obj \
                    t.lnk \
                    t$(COMNME).lnk \
                    d.lib
     $(LNKCMD) @t$(COMNME) out $@ $(LNKOPT)

$(OBJDIR)\t.obj :   $(@B).c
     $(COMCMD) $(DEXOPT) $(@B).c

d.lib :             $(OUTDIR)\d.dll
     BLILIB /ID$? /OL$@ /NP

$(OUTDIR)\d.dll :   $(OBJDIR)\d.obj \
                    d.lnk \
                    d$(COMNME).lnk
     $(LNKCMD) @d$(COMNME) out $@ $(LNKOPT)

$(OBJDIR)\d.obj :   $(@B).c
     $(COMCMD) $(DLLOPT) $(@B).c

