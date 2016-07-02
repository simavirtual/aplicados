

parameters cCommand

SET DATE BRITISH

? "File Name    Mod Date Mod Time Owner      Cre Date Cre Time Acc Date InhRights"
? "------------------------------------------------------------------------------"

cName = DIRFILLST( cCommand )

do while !( empty( cName ) )

  ? substr(cName+space(12),1,12),FILMODDTEGET(),FILMODTMEGET(),substr(OBJNMEGET(FILOWNIDGET())+space(10),1,10),FILCREDTEGET(),FILCRETMEGET(),FILACCDTEGET(),NOVRGTSTR(FILIRMSKGET())

  cName = DIRFILLST("")

enddo

?
