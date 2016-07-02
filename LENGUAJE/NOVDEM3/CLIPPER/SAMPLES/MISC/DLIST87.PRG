

parameters cCommand

SET DATE BRITISH

? "Dir Name     Mod Date Mod Time Owner      Cre Date Cre Time Inh Rights"
? "----------------------------------------------------------------------"

cName = DIRSUBDIRLST( cCommand )

do while !( empty( cName ) )

  ? substr(cName+space(12),1,12),DIRMODDTEGET(),DIRMODTMEGET(),substr(OBJNMEGET(DIROWNIDGET())+space(10),1,10),DIRCREDTEGET(),DIRCRETMEGET(),NOVRGTSTR(DIRIRMSKGET())

  cName = DIRSUBDIRLST("")

enddo

?
