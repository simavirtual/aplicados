
// FLIST.PRG lists files in a given directory and their information //
// typical usage: FLIST SYS:PUBLIC\*.*                              //

function main( )
parameter cCommand

    Local cName := ""
    Local nLine := 1
    Local nKey

   if (TYPE("cCommand")<>"C")
      ? [Usage: FLIST <Netware path>]
      ? [Example: FLIST SYS:DATA\*.*]
      quit
   endif

    ? "File Name    Mod Date Mod Time Owner      Cre Date Cre Time Acc Date InhRights"
    ? "------------------------------------------------------------------------------"

    cName := DIRFILLST( cCommand, "" )

    do while !( empty( cName ) )

      ? padr(cName,12),FILMODDTEGET(),FILMODTMEGET(),padr(OBJNMEGET(FILOWNIDGET()),10),FILCREDTEGET(),FILCRETMEGET(),FILACCDTEGET(),NOVRGTSTR(FILIRMSKGET())

      cName := DIRFILLST("","")

      if( nLine < 23 )
        nLine++
      else
        nLine := 1
        ? "Press any key for more"
        nKey := INKEY(0)
        if( nKey == 27 )
          exit
        endif
      endif
    enddo

    return( nil )
