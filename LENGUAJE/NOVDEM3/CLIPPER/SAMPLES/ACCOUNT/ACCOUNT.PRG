* Account browser
#include "inkey.ch"

public axCols, cObjectName, nBalance, nLimit

CLS

if WSCONNUMGET() <= 0
  ?
  ? "Error: You are not connected to a network."
  ?
else
  if SETPRPIDTST(WSLOGNMEGET(),1,"SUPERVISOR",1,"SECURITY_EQUALS") .OR. ( WSLOGNMEGET() = "SUPERVISOR" )

    Browser()

  else
    ?
    ? "Error: To run this program, you must have Supervisor equivalence."
    ?
  endif
endif

quit


function Browser()

local oB, nN, nKey, nTime, bIansBlock, GetList, lConfirm, cBindCode


IansFunction()

bIansBlock := { || IansFunction() }


nN := 1
lConfirm := SET( _SET_CONFIRM, .t. )
GetList  := {}
@ 03,19 to 16,61 double
oB := TBrowseNew( 04, 20, 15, 60 )
oB:colSep  := " ³ "
oB:headSep := "ÄÂÄ"
oB:addColumn( TBColumnNew( "Name    ", { || axCols[ nN, 1 ] } ) )
oB:addColumn( TBColumnNew( "Balance ", { || axCols[ nN, 2 ] } ) )
oB:addColumn( TBColumnNew( "Limit   ", { || axCols[ nN, 3 ] } ) )
oB:goTopBlock    := { || nN := 1 }
oB:goBottomBlock := { || nN := LEN( axCols ) }
oB:skipBlock     := { | n, nS | nS := MySkipBlock( n, nN, axCols ), nN += nS, nS }


nTime            := 0

do while ( nKey := INKEY() ) != K_ESC
        if ( oB:stabilize() )
                DISPEND()
        endif
        do case
        case ( nKey == K_RETURN .and. oB:stable() )

           if ( oB:colPos > 1 )
             nTmp = axCols[ nN, oB:colPos ]
             @ ROW(), COL() GET nTmp
             READ
             axCols[ nN, oB:colPos ] = nTmp
             nTEST := SETPRPVALSET( rtrim(axCols[ nN, 1]), 1, "ACCOUNT_BALANCE",oB:colPos-1,;
                            axCols[ nN, oB:colPos ] )


             @ 24,0 say str(NWERRORGET())

             oB:refreshCurrent()

           endif

        case ( nKey == K_DOWN )
           oB:down()

        case ( nKey == K_UP )
                oB:up()

        case ( nKey == K_PGDN )
                oB:pageDown()

        case ( nKey == K_PGUP )
                oB:pageUp()

        case ( nKey == K_CTRL_PGUP )
                oB:goTop()

        case ( nKey == K_CTRL_PGDN )
                oB:goBottom()

        case ( nKey == K_RIGHT )
                oB:right()

        case ( nKey == K_LEFT )
                oB:left()

        case ( nKey == K_HOME )
                oB:home()

        case ( nKey == K_END )
                oB:end()

        case ( nKey == K_CTRL_LEFT )
                oB:panLeft()

        case ( nKey == K_CTRL_RIGHT )
                oB:panRight()

        case ( nKey == K_CTRL_HOME )
                oB:panHome()

        case ( nKey == K_CTRL_END )
                oB:panEnd()

        otherwise
        if ( SECONDS() > nTime )


                nTime := SECONDS() + 1
                EVAL( bIansBlock )
                DISPBEGIN()
                oB:refreshAll()

        endif

        endcase
enddo

SET( _SET_CONFIRM, lConfirm )

return( Nil )


function MySkipBlock( n, nN, axCols )

local nSize, nToSkip

nSize := LEN( axCols )
if ( ( nToSkip := nN + n ) < 1 )
        nToSkip := -nN + 1
elseif ( nToSkip > nSize )
        nToSkip := nSize - nN
else
   nToSkip := n
endif

return( nToSkip )




FUNCTION IansFunction()

LOCAL nCounter

axCols := {}

cBindCode := {||l := FSOBJLST("*",1, .T.),;
             cBindCode := {||FSOBJLST("*",1,.F.)},l}

do while !empty(cObjectName := eval(cBindCode))

  aadd( axCols, { cObjectName, NIL, NIL } )

enddo

for nCounter =  1 to len( axCols )

  nBalance := SETPRPVALGET(axCols[nCounter],1,"ACCOUNT_BALANCE",1)
  nLimit   := SETPRPVALGET(axCols[nCounter],1,"ACCOUNT_BALANCE",2)

  nBalance := if( nBalance > 0, nBalance, 0 )
  nLimit   := if( nLimit > 0, nLimit, 0 )

  axCols[nCounter,2] := nBalance
  axCols[nCounter,3] := nLimit

next

return NIL
