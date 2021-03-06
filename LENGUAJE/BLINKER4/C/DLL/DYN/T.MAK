#
#  96.02.22  T.MAK
#
#  This sample make file demonstrates how to create a DOS
#  extended EXE which uses a dynamically linked DLL.
#

!include ..\..\all.mak                  # Standard make file definitions

ALL       ::        $(OUTDIR)\t.exe
ALL       ::        $(OUTDIR)\d.dll
ALL       ::        $(OUTDIR)\tw.exe

$(OUTDIR)\t.exe:    $(OBJDIR)\t.obj \
                    t.lnk \
                    t$(COMNME).lnk
     $(LNKCMD) @t$(COMNME) out $@ $(LNKOPT)

$(OUTDIR)\tw.exe :  $(OBJDIR)\tw.obj \
                    tw.lnk \
                    tw$(COMNME).lnk
     $(LNKCMD) @tw$(COMNME) out $@ $(LNKOPT)

$(OBJDIR)\t.obj :   $(@B).c
     $(COMCMD) $(DEXOPT) $(@B).c

$(OBJDIR)\tw.obj :  $(@B).c
     $(COMCMD) $(WINOPT) $(@B).c

$(OUTDIR)\d.dll :   $(OBJDIR)\d.obj \
                    dw.def \
                    dw.lnk \
                    dw$(COMNME).lnk
     $(LNKCMD) @dw$(COMNME) out $@ $(LNKOPT)

$(OBJDIR)\d.obj :   $(@B).c
     $(COMCMD) $(DLLOPT) $(@B).c

