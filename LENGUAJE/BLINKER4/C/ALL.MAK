#
#  96.02.14  ALL.MAK
#
#  This generic make file contains Blinker standard definitions which are
#  included by all the C example make files include with Blinker.
#

!if "$(BLXOBJ)" == ""         # If Microsoft
COMNME = M                    # Compiler name suffix for Microsoft
!else
COMNME = B                    # Compiler name suffix for Borland
!endif

OBJDIR = .                    # OBJ file directory
OUTDIR = .                    # EXE and DLL file directory

LNKCMD = blinker              # Link command
LNKOPT = map s,a,x            # Link options

!if "$(COMNME)" == "M"        # If Microsoft
COMCMD = cl -c -AL -Fo$(OBJDIR)\ -W3    # Compile command
COMDBG = -Zi                  # Compiler debugging options
DEXOPT =                      # Compiler options for DOS extended programs
DLLOPT = -GD -Gs              # Compiler options for DLL programs
WINOPT = -GA -Gs              # Compiler options for Windows programs
!elseif "$(COMNME) == "B"     # Else Borland
COMCMD = bcc -c -ml -n$(OBJDIR)\ -w     # Compile command
COMDBG = -v                   # Compiler debugging options
DEXOPT =                      # Compiler options for DOS extended programs
DLLOPT = -tWDE                # Compiler options for DLL programs
WINOPT = -tWE                 # Compiler options for Windows programs
!endif

!ifdef DEBUG                  # Determine if DEBUGging is enabled
COMCMD = $(COMCMD) $(COMDBG)
!endif

ALL::                         # Target to make

%.exe:

