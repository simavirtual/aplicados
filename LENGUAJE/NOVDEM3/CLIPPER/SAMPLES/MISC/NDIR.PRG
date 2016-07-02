
// a sort of NDIR type program
//
// by Goth
//

LOCAL cName, cScanPath
PUBLIC aStack, cPath

parameters cCommand

SET DATE BRITISH
SET PRINTER TO NDIR.LOG
SET PRINTER ON

aStack := {}

cPath := DRVPTHGET( DrvCurGet() )

cPath := strtran( cPath, "/", "\" )

if ( cCommand == NIL )
  cName := "\*.*"
else
  if !( "\" $ cCommand )
    cName := "\"+upper(cCommand)
  else
    cPath := upper(left( cCommand, rat( "\", cCommand ) - 1 ))
    cName := upper(substr( cCommand, rat( "\", cCommand ) ))
  endif
endif

do while .T.

  cScanPath := cPath + cName    // cScanPath is the currently used directory

  FindDir( cPath + "\*" )       // get all sub directories and push to stack

  DispFile( cScanPath )         // list files from current directory

  cPath := PopStack()           // get next directory

  if empty( cPath )             // if nothing left on stack
    exit                        // exit loop
  endif

enddo

?

SET PRINTER OFF
SET PRINTER TO


FUNCTION PushStack( cElement )   // pushes directory onto directory stack

aadd( aStack, "" )
ains( aStack, 1 )
aStack[1] := cElement

return( NIL )


FUNCTION PopStack()             // pops next directory from directory stack

LOCAL cElement

cElement := aStack[1]
adel( aStack, 1 )

return( cElement )


FUNCTION FindDir( cScanPath )        // gets next list of directories and
                                     // pushes them on directory stack
LOCAL cName, nCounter

nCounter := 0

cName := DIRSUBDIRLST( cScanPath )

do while !( empty( cName ) )

  nCounter++

  PushStack( cPath +"\"+ cName )

  cName := DIRSUBDIRLST()

enddo

asort( aStack, 1, nCounter )         // sort them into alphabetical order

return( NIL )


FUNCTION DispFile( cScanPath )

LOCAL cName, aFiles, nCounter, nOffset, nRow

aFiles := {}

?

nRow := row()

?? "  "+FSNMEGET()+"/"+cPath

cName := DIRFILLST( cScanPath )

do while !( empty( cName ) )

  @ nRow, 0 say Wheel()             // it looks pretty !

  nOffset := at( ".", cName )

  cName := ( padr( left( cName, nOffset -1 ), 8 )+substr( cName, nOffset ) )

  aadd( aFiles, cName )             // fill array with file names

  cName := DIRFILLST()

enddo

@ nRow, 0 say " "

?

asort( aFiles )                     // sort them into alphabetical order

for nCounter = 1 to len( aFiles )

  ? "    "+aFiles[nCounter]

next

?

return( NIL )


FUNCTION Wheel()

LOCAL cValue
STATIC nCounter := 1

DO CASE
  CASE nCounter == 1
    cValue := "-"
  CASE nCounter == 2
    cValue := "\"
  CASE nCounter == 3
    cValue := "|"
  CASE nCounter == 4
    cValue := "/"
ENDCASE

nCounter := if( nCounter == 4, 1, ++nCounter )

return( cValue )

