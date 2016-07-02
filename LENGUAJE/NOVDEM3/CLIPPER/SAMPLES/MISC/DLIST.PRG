
// DLIST.PRG lists the directories and their information //
// for a given path                                      //
// typical usage: DLIST SYS:DATA\*                       //

#include "novlib.ch"

Local cName := ""

parameters cCommand

if (TYPE("cCommand")<>"C")
   ? [Usage: DLIST <Netware path>]
   ? [Example: DLIST SYS:DATA\*]
   quit
endif

? "Dir Name     Mod Date Mod Time Owner      Cre Date Cre Time Inh Rights"
? "----------------------------------------------------------------------"

cName := DIRSUBDIRLST( cCommand, "" )

do while !( empty( cName ) )
  ? padr(cName,12),DIRMODDTEGET(),DIRMODTMEGET(),padr(OBJNMEGET(DIROWNIDGET()),10),DIRCREDTEGET(),DIRCRETMEGET(),NOVRGTSTR(DIRIRMSKGET())
  cName := DIRSUBDIRLST("","")
enddo

?
