/***
*
*  Getsys.prg
*
*  Standard Clipper 5.3 GET/READ Subsystem
*
*  Copyright (c) 1991-1994, Computer Associates International, Inc.
*  All rights reserved.
*
*  This version adds the following public functions:
*
*     ReadKill( [<lKill>] )       --> lKill
*     ReadUpdated( [<lUpdated>] ) --> lUpdated
*     ReadFormat( [<bFormat>] )   --> bFormat | NIL
*
*  NOTE: compile with /m /n /w
*
*/

#include "button.ch"
#include "Inkey.ch"
#include "Getexit.ch"
#include "Set.ch"
#include "SetCurs.ch"
#include "tbrowse.ch"
#include "llibg.ch"

/***
*  Nation Message Constants
*  These constants are used with the NationMsg(<msg>) function.
*  The <msg> parameter can range from 1-12 and returns the national
*  version of the system message.
*/
#define _GET_INSERT_ON   7     // "Ins"
#define _GET_INSERT_OFF  8     // "   "
#define _GET_INVD_DATE   9     // "Invalid Date"
#define _GET_RANGE_FROM  10    // "Range: "
#define _GET_RANGE_TO    11    // " - "

#define K_UNDO          K_CTRL_U

//
// State variables for active READ
//
STATIC sbFormat
STATIC slUpdated := .F.
STATIC slKillRead
STATIC slBumpTop
STATIC slBumpBot
STATIC snLastExitState
STATIC snLastPos
STATIC soActiveGet
STATIC scReadProcName
STATIC snReadProcLine
static snNextGet
static snHitCode
static snPos
static OldMessage := NIL
static OldMsgPos := 0

// Format of array used to preserve state variables
//
#define GSV_KILLREAD       1
#define GSV_BUMPTOP        2
#define GSV_BUMPBOT        3
#define GSV_LASTEXIT       4
#define GSV_LASTPOS        5
#define GSV_ACTIVEGET      6
#define GSV_READVAR        7
#define GSV_READPROCNAME   8
#define GSV_READPROCLINE   9
#define GSV_NEXTGET        10
#define GSV_HITCODE        11
#define GSV_POS            12

#define GSV_COUNT          12



/***
*
*  ReadModal()
*
*  Standard modal READ on an array of GETs
*
*/
FUNCTION ReadModal( GetList, nPos, oMenu, nMsgRow, nMsgLeft, nMsgRight, cMsgColor )

   LOCAL oGet
   LOCAL aSavGetSysVars
   local cOldMsg
   local lMsgFlag
   local cSaveColor
   local lColorFlag
   local cMsg := NIL
   local nForeColor
   local nBackColor
   local nAt
   local nMsgPos
   local nFontRow

   IF ( VALTYPE( sbFormat ) == "B" )
      EVAL( sbFormat )
   ENDIF

   IF ( EMPTY( GetList ) )

      // S'87 compatibility
      SETPOS( MAXROW() - 1, 0 )
      RETURN (.F.)                  // NOTE

   ENDIF

   // Preserve state variables
   aSavGetSysVars := ClearGetSysVars()

   // Set these for use in SET KEYs
   scReadProcName := PROCNAME( 1 )
   snReadProcLine := PROCLINE( 1 )

   // Set initial GET to be read
   IF ( VALTYPE( nPos ) == "N" )
      snPos := Settle( GetList, nPos, .T. )
   ELSE
      snPos := Settle( GetList, 0, .T. )
   ENDIF

   if     ( ! ValType( nMsgRow ) == "N" )
      lMsgFlag := .f.

   elseif ( ! ValType( nMsgLeft ) == "N" )
      lMsgFlag := .f.

   elseif ( ! ValType( nMsgRight ) == "N" )
      lMsgFlag := .f.

   else
      lMsgFlag := .t.
      cOldMsg := SaveScreen( nMsgRow, nMsgLeft, nMsgRow, nMsgRight )
      lColorFlag := ( ValType( cMsgColor ) == "C" )

   endif
   snNextGet := 0
   snHitCode := 0

   WHILE !( snPos == 0 )

      oGet := GetList[ snPos ]
      // Get next GET from list and post it as the active GET
         PostActiveGet( oGet )

      if ( lMsgFlag )
         if (! _ISGRAPHIC() )
            if ( lColorFlag )
               cSaveColor := SetColor( cMsgColor )
            endif

            if ( ValType( oGet:Control ) == "O" )
               @ nMsgRow, nMsgLeft ;
               say PadC( oGet:Control:Message, nMsgRight - nMsgLeft + 1 )
            else
               @ nMsgRow, nMsgLeft ;
               say PadC( oGet:Message, nMsgRight - nMsgLeft + 1 )
            endif

            if ( lColorFlag )
               SetColor( cSaveColor )
            endif

         else    // Graphic mode

            if ( ! lColorFlag )
               cMsgColor := SetColor()
            endif

            nForeColor := _GETNUMCOLOR( cMsgColor )
            nAt := AT( "/" , cMsgColor )
            nBackColor := _GETNUMCOLOR( Substr( cMsgColor, nAt + 1, len( cMsgColor ) - nAt) )

            if ( ValType( oGet:Control ) == "O" )
               cMsg := oGet:Control:Message
            else
               cMsg := oGet:Message
            endif

            nMsgPos := int( (nMsgRight - nMsgLeft) / 2) - int ( len( cMsg ) / 2 ) + 1
            nFontRow := gMode() [ LLG_MODE_FONT_ROW ]

            if (OldMessage <> NIL)
               if ( (OldMessage <> cMsg ) .or. ( len( cMsg ) == 0) )
                  gWriteAt( OldMsgPos * 8,;
                            nMsgRow * nFontRow,;
                            OldMessage,;
                            nBackColor,;
                            LLG_MODE_SET )
                  gFrame( nMsgLeft * 8,;
                        ( nMsgRow * nFontRow ) - 1,;
                          nMsgRight * 8,;
                        ((nMsgRow + 1) * nFontRow ) + 1,;
                          nBackColor,;
                          8, 15,;
                          2, 2, 2, 2, LLG_MODE_XOR, LLG_FILL )
               endif
            endif

            if ( (OldMessage <> cMsg) .or. ( len( cMsg ) == 0 ) )
               gFrame( nMsgLeft * 8,;
                     ( nMsgRow * nFontRow) -1,;
                       nMsgRight * 8,;
                     ((nMsgRow + 1) * nFontRow) + 1,;
                       nBackColor,;
                       8, 15,;
                       2, 2, 2, 2, LLG_MODE_XOR, LLG_FILL )
               gWriteAt( nMsgPos * 8,;
                         nMsgRow * nFontRow,;
                         cMsg,;
                         nForeColor,;
                         LLG_MODE_SET )
            endif

            OldMessage := cMsg
            OldMsgPos := nMsgPos

         endif
      endif

      // Read the GET
      IF ( VALTYPE( oGet:reader ) == "B" )
         EVAL( oGet:reader, oGet, GetList, oMenu, nMsgRow, nMsgLeft, nMsgRight, cMsgColor )    // Use custom reader block
      ELSE
         GetReader( oGet, GetList, oMenu, nMsgRow, nMsgLeft, nMsgRight, cMsgColor ) // Use standard reader
      ENDIF

      // Move to next GET based on exit condition
      snPos := Settle( GetList, snPos, .F. )

   ENDDO

   if ( lMsgFlag )
      RestScreen( nMsgRow, nMsgLeft, nMsgRow, nMsgRight, cOldMsg )
   endif

   // Restore state variables
   RestoreGetSysVars( aSavGetSysVars )

   // S'87 compatibility
   SETPOS( MAXROW() - 1, 0 )

   RETURN ( slUpdated )



/***
*
*  GetReader()
*
*  Standard modal read of a single GET
*
*/
PROCEDURE GetReader( oGet, GetList, oMenu, nMsgRow, nMsgLeft, nMsgRight, cMsgColor )

   // Read the GET if the WHEN condition is satisfied

   IF ( GetPreValidate( oGet ) )

      // Activate the GET for reading

      snHitCode := 0
      oGet:setFocus()

      WHILE ( oGet:exitState == GE_NOEXIT .AND. !slKillRead )

         // Check for initial typeout (no editable positions)
         IF ( oGet:typeOut )
            oGet:exitState := GE_ENTER
         ENDIF

         // Apply keystrokes until exit
         WHILE ( oGet:exitState == GE_NOEXIT .AND. !slKillRead )
            GetApplyKey( oGet, inkey( 0 ), GetList, oMenu, nMsgRow, nMsgLeft, nMsgRight, cMsgColor )
         ENDDO

         // Disallow exit if the VALID condition is not satisfied
         IF ( !GetPostValidate( oGet ) )
            oGet:exitState := GE_NOEXIT
         ENDIF
      ENDDO

      // De-activate the GET

      oGet:killFocus()

   ENDIF

   RETURN



/***
*
*  GUIReader()
*
*  Standard modal read of a single GUI-GET
*
*/
PROCEDURE GUIReader( oGet, GetList, oMenu, nMsgRow, nMsgLeft, nMsgRight, cMsgColor )
   local oGUI

   // Read the GET if the WHEN condition is satisfied
   IF ( ! GUIPreValidate( oGet , oGet:Control ) )
   elseif ( ValType( oGet:Control ) == "O" )

      // Activate the GET for reading
      oGUI := oGet:Control
      oGUI:Select( oGet:VarGet() )
      oGUI:setFocus()

      if ( snHitCode > 0 )
         oGUI:Select( snHitCode )

      elseif ( snHitCode == HTCAPTION )
         oGUI:Select()

      elseif ( snHitCode == HTCLIENT )
         oGUI:Select( K_LBUTTONDOWN )

      elseif ( snHitCode == HTDROPBUTTON )
         oGUI:Open()

      elseif ( ( snHitCode >= HTSCROLLFIRST ) .and. ;
               ( snHitCode <= HTSCROLLLAST ) )
         oGUI:Scroll( snHitCode )
      endif

      snHitCode := 0

      WHILE ( oGet:exitState == GE_NOEXIT .AND. !slKillRead )

         // Check for initial typeout (no editable positions)
         IF ( oGUI:typeOut )
            oGet:exitState := GE_ENTER
         ENDIF

         // Apply keystrokes until exit
         WHILE ( oGet:exitState == GE_NOEXIT .AND. !slKillRead )
            GUIApplyKey( oGet, oGUI, GetList, inkey( 0 ), oMenu, nMsgRow, nMsgLeft, nMsgRight, cMsgColor )
         ENDDO

         // Disallow exit if the VALID condition is not satisfied

         IF ( !GUIPostValidate( oGet, oGUI ) )
            oGet:exitState := GE_NOEXIT
         ENDIF
      ENDDO

      // De-activate the GET
      oGet:VarPut( oGUI:Buffer )
      oGUI:killFocus()

      if ( ! oGUI:ClassName() == "LISTBOX" )
      elseif ( ! oGUI:DropDown )
      elseif ( oGUI:IsOpen )
         oGUI:Close()
      endif

   ENDIF

   RETURN



/***
*
*  tBrowseReader()
*
*  Standard modal read of a single tBrowse-GET
*
*/
PROCEDURE tbReader( oGet, GetList, oMenu, nMsgRow, nMsgLeft, nMsgRight, cMsgColor )
   local oTB, nKey, lAutoLite, nCell, nSaveCursor, nProcessed

   // Read the GET if the WHEN condition is satisfied
   IF ( ! GUIPreValidate( oGet, oGet:Control ) )
   elseif ( ValType( oGet:Control ) == "O" )

      nSaveCursor := SetCursor( SC_NONE )

      // Activate the GET for reading

      oTB := oGet:Control

      lAutoLite := oTB:Autolite
      oTB:Autolite := .T.
      oTB:Hilite()

      if ( snHitCode == HTCELL )
         tbMouse( oTB, mRow(), mCol() )
      endif

      snHitCode := 0

      WHILE ( oGet:exitState == GE_NOEXIT )

         // Apply keystrokes until exit
         WHILE ( oGet:exitState == GE_NOEXIT )
            nKey := 0

            WHILE ( ( ! oTB:Stabilize() ) .AND. ( nKey == 0 ) )
               nKey := Inkey()
            ENDDO

            IF ( nKey == 0 )
               nKey := Inkey(0)
            ENDIF

            nProcessed := oTB:ApplyKey( nKey )
            IF ( nProcessed == TBR_EXIT )
               oGet:exitState := GE_ESCAPE
               EXIT

            ELSEIF ( nProcessed == TBR_EXCEPTION )
               tbApplyKey( oGet, oTB, GetList, nKey, oMenu, nMsgRow, nMsgLeft, nMsgRight, cMsgColor )

            ENDIF

         ENDDO

         // Disallow exit if the VALID condition is not satisfied

         IF ( !GUIPostValidate( oGet, oTB ) )
            oGet:exitState := GE_NOEXIT
         ENDIF
      ENDDO

      // De-activate the GET
      oTB:Autolite := lAutoLite
      oTB:DeHilite()
      SetCursor( nSaveCursor )
   ENDIF

   RETURN



static function HitTest( GetList, MouseRow, MouseCol )
   local nCount, nTotal

      snNextGet := 0
      nTotal  := Len( GetList )

      for nCount := 1 to nTotal
         if ( ( snHitCode := GetList[ nCount ]:HitTest( MouseRow, MouseCol ) ) != HTNOWHERE )
            snNextGet := nCount
            exit
         endif
      next

      if ( snNextGet == 0 )
      elseif ( ValType( GetList[ snNextGet ]:Control ) <> "O" )
      elseif ( ! GUIPreValidate( GetList[ snNextGet ], GetList[ snNextGet ]:Control ) )
         snNextGet := 0
      endif

      if ( snNextGet == 0 )
      elseif ( ! GetPrevalidate( GetList[ snNextGet ] ) )
         snNextGet := 0
      endif

   return ( snNextGet != 0 )



static function Accelerator( GetList, nKey )
   local nGet, oGet, nHotPos, cKey, cCaption, nStart, nEnd, nItteration

      if     ( ( nKey >= K_ALT_Q ) .and. ( nKey <= K_ALT_P ) )
         cKey := SubStr( "qwertyuiop", nKey - K_ALT_Q + 1, 1 )

      elseif ( ( nKey >= K_ALT_A ) .and. ( nKey <= K_ALT_L ) )
         cKey := SubStr( "asdfghjkl", nKey - K_ALT_A + 1, 1 )

      elseif ( ( nKey >= K_ALT_Z ) .and. ( nKey <= K_ALT_M ) )
         cKey := SubStr( "zxcvbnm", nKey - K_ALT_Z + 1, 1 )

      elseif ( ( nKey >= K_ALT_1 ) .and. ( nKey <= K_ALT_0 ) )
         cKey := SubStr( "1234567890", nKey - K_ALT_1 + 1, 1 )

      else
         return ( 0 )

      endif


      nStart := snPos + 1
      nEnd  := Len( GetList )

      for nItteration := 1 to 2
         for nGet := nStart to nEnd
            oGet := GetList[ nGet ]

            if ( ValType( oGet:Control ) == "O" .AND. oGet:Control:ClassName() != "TBROWSE" )
               cCaption := oGet:Control:Caption
            else
               cCaption := oGet:Caption
            endif

            if ( ( nHotPos := At( "&", cCaption ) ) == 0 )
            elseif ( nHotPos == Len( cCaption ) )
            elseif ( Lower( SubStr( cCaption, nHotPos + 1, 1 ) ) == cKey )

               if ( ! GetPrevalidate( GetList[ nGet ] ) )
                  return ( 0 )                                   /* NOTE! */
               endif

               return ( nGet )                                 /* NOTE! */
            endif
         next

         nStart := 1
         nEnd := snPos - 1
      next

   return ( 0 )



/***
*
*  GetApplyKey()
*
*  Apply a single INKEY() keystroke to a GET
*
*  NOTE: GET must have focus.
*
*/
PROCEDURE GetApplyKey( oGet, nKey, GetList, oMenu, nMsgRow, nMsgLeft, nMsgRight, cMsgColor )

   LOCAL cKey
   LOCAL bKeyBlock
   local MouseRow, MouseColumn
   local nButton
   local nHotItem

   // Check for SET KEY first
   IF !( ( bKeyBlock := setkey( nKey ) ) == NIL )
      GetDoSetKey( bKeyBlock, oGet )
      RETURN                           // NOTE
   ENDIF

   if ( ( ! GetList == NIL ) .AND. ;
        ( ( nHotItem := Accelerator( GetList, nKey ) ) != 0 ) )
      oGet:ExitState := GE_SHORTCUT
      snNextGet := nHotItem

   elseif ( oMenu == NIL )
   elseif ( ( nHotItem := oMenu:GetAccel( nKey ) ) != 0 )
      MenuModal( oMenu, nHotItem, nMsgRow, nMsgLeft, nMsgRight, cMsgColor )
      nKey := 0
   elseif ( IsShortCut( oMenu, nKey )  )
      nKey := 0
   endif

   DO CASE
   CASE ( nKey == K_UP )
      oGet:exitState := GE_UP

   CASE ( nKey == K_SH_TAB )
      oGet:exitState := GE_UP

   CASE ( nKey == K_DOWN )
      oGet:exitState := GE_DOWN

   CASE ( nKey == K_TAB )
      oGet:exitState := GE_DOWN

   CASE ( nKey == K_ENTER )
      oGet:exitState := GE_ENTER

   CASE ( nKey == K_ESC )
      IF ( SET( _SET_ESCAPE ) )
         oGet:undo()
         oGet:exitState := GE_ESCAPE
      ENDIF

   CASE ( nKey == K_PGUP )
      oGet:exitState := GE_WRITE

   CASE ( nKey == K_PGDN )
      oGet:exitState := GE_WRITE

   CASE ( nKey == K_CTRL_HOME )
      oGet:exitState := GE_TOP


#ifdef CTRL_END_SPECIAL

   // Both ^W and ^End go to the last GET
   CASE ( nKey == K_CTRL_END )
      oGet:exitState := GE_BOTTOM

#else

   // Both ^W and ^End terminate the READ (the default)
   CASE ( nKey == K_CTRL_W )
      oGet:exitState := GE_WRITE

#endif
   CASE ( ( nKey == K_LBUTTONDOWN ) .or. ( nKey == K_LDBLCLK ) )
      MouseRow := mrow()
      MouseColumn := mcol()

      if ( ! ValType( oMenu ) == "O" )
         nButton := 0

      elseif ( ! oMenu:ClassName() == "TOPBARMENU" )
         nButton := 0

      elseif ( ( nButton := oMenu:HitTest( MouseRow, MouseColumn ) ) != 0 )
         MenuModal( oMenu, nButton, nMsgRow, nMsgLeft, nMsgRight, cMsgColor )
         nButton := 1

      endif

      if ( nButton != 0 )

      elseif ( ( nButton := oGet:HitTest( MouseRow, MouseColumn ) ) == HTCLIENT )
         while ( oGet:col + oGet:pos - 1 > MouseColumn )
            oGet:left()
         enddo

         while ( oGet:col + oGet:pos - 1 < MouseColumn )
            oGet:right()
         enddo

      elseif ( ! nButton == HTNOWHERE )
      elseif ( ( ! GetList == NIL ) .AND. ;
               ( HitTest( GetList, MouseRow, MouseColumn ) ) )
         oGet:exitstate := GE_MOUSEHIT
      else
         oGet:exitstate := GE_NOEXIT
      endif

   CASE ( nKey == K_UNDO )
      oGet:undo()

   CASE ( nKey == K_HOME )
      oGet:home()

   CASE ( nKey == K_END )
      oGet:end()

   CASE ( nKey == K_RIGHT )
      oGet:right()

   CASE ( nKey == K_LEFT )
      oGet:left()

   CASE ( nKey == K_CTRL_RIGHT )
      oGet:wordRight()

   CASE ( nKey == K_CTRL_LEFT )
      oGet:wordLeft()

   CASE ( nKey == K_BS )
      oGet:backSpace()

   CASE ( nKey == K_DEL )
      oGet:delete()

   CASE ( nKey == K_CTRL_T )
      oGet:delWordRight()

   CASE ( nKey == K_CTRL_Y )
      oGet:delEnd()

   CASE ( nKey == K_CTRL_BS )
      oGet:delWordLeft()

   CASE ( nKey == K_INS )
      SET( _SET_INSERT, !SET( _SET_INSERT ) )
      ShowScoreboard()

   OTHERWISE

      IF ( nKey >= 32 .AND. nKey <= 255 )

         cKey := CHR( nKey )

         IF ( oGet:type == "N" .AND. ( cKey == "." .OR. cKey == "," ) )
            oGet:toDecPos()
         ELSE

            IF ( SET( _SET_INSERT ) )
               oGet:insert( cKey )
            ELSE
               oGet:overstrike( cKey )
            ENDIF

            IF ( oGet:typeOut )
               IF ( SET( _SET_BELL ) )
                  ?? CHR(7)
               ENDIF

               IF ( !SET( _SET_CONFIRM ) )
                  oGet:exitState := GE_ENTER
               ENDIF
            ENDIF

         ENDIF

      ENDIF

   ENDCASE

   RETURN



/***
*
*  GUIApplyKey()
*
*  Apply a single INKEY() keystroke to a GET
*
*  NOTE: GET and GUI must have focus.
*
*/
PROCEDURE GUIApplyKey( oGet, oGUI, GetList, nKey, oMenu, nMsgRow, nMsgLeft, nMsgRight, cMsgColor )

   LOCAL cKey
   LOCAL bKeyBlock
   local MouseRow, MouseColumn
   local nButton
   local TheClass
   local nHotItem
   local lClose

   // Check for SET KEY first
   IF !( ( bKeyBlock := setkey( nKey ) ) == NIL )
      GetDoSetKey( bKeyBlock, oGet )
      RETURN                           // NOTE
   ENDIF

   if ( ( nHotItem := Accelerator( GetList, nKey ) ) != 0 )
      oGet:ExitState := GE_SHORTCUT
      snNextGet := nHotItem

   elseif ( oMenu == NIL )
   elseif ( ( nHotItem := oMenu:GetAccel( nKey ) ) != 0 )
      MenuModal( oMenu, nHotItem, nMsgRow, nMsgLeft, nMsgRight, cMsgColor )
      nKey := 0
   elseif ( IsShortCut( oMenu, nKey )  )
      nKey := 0
   endif

   if ( nKey == 0 )
   elseif ( ( TheClass := oGUI:ClassName() ) == "RADIOGROUP" )
      if  ( nKey == K_UP )
         oGUI:PrevItem()
         nKey := 0

      elseif ( nKey == K_DOWN )
         oGUI:NextItem()
         nKey := 0

      elseif ( ( nHotItem := oGUI:GetAccel( nKey ) ) != 0 )
         oGUI:Select( nHotItem )

      endif

   elseif ( TheClass == "CHECKBOX" )
      if ( nKey == K_SPACE )
         oGUI:Select()

      endif

   elseif ( TheClass == "PUSHBUTTON" )
      if ( nKey == K_SPACE )
         oGUI:Select( K_SPACE )

      elseif ( nKey == K_ENTER )
         oGUI:Select()
         nKey := 0

      endif

   elseif ( TheClass == "LISTBOX" )
      if  ( nKey == K_UP )
         oGUI:PrevItem()
         nKey := 0

      elseif ( nKey == K_DOWN )
         oGUI:NextItem()
         nKey := 0

      elseif ( nKey == K_SPACE )
         if ( ! oGUI:DropDown )
         elseif ( ! oGUI:IsOpen )
            oGUI:Open()
            nKey := 0
         endif

      elseif ( ( nButton := oGUI:FindText( Chr( nKey ), oGUI:Value + 1, ;
                                           .f., .f. ) ) != 0 )
         oGUI:Select( nButton )

      endif

   endif

   DO CASE
   CASE ( nKey == K_UP )
      oGet:exitState := GE_UP

   CASE ( nKey == K_SH_TAB )
      oGet:exitState := GE_UP

   CASE ( nKey == K_DOWN )
      oGet:exitState := GE_DOWN

   CASE ( nKey == K_TAB )
      oGet:exitState := GE_DOWN

   CASE ( nKey == K_ENTER )
      oGet:exitState := GE_ENTER

   CASE ( nKey == K_ESC )
      IF ( SET( _SET_ESCAPE ) )
         oGet:exitState := GE_ESCAPE
      ENDIF

   CASE ( nKey == K_PGUP )
      oGet:exitState := GE_WRITE

   CASE ( nKey == K_PGDN )
      oGet:exitState := GE_WRITE

   CASE ( nKey == K_CTRL_HOME )
      oGet:exitState := GE_TOP


#ifdef CTRL_END_SPECIAL

   // Both ^W and ^End go to the last GET
   CASE ( nKey == K_CTRL_END )
      oGet:exitState := GE_BOTTOM

#else

   // Both ^W and ^End terminate the READ (the default)
   CASE ( nKey == K_CTRL_W )
      oGet:exitState := GE_WRITE

#endif
   CASE ( ( nKey == K_LBUTTONDOWN ) .or. ( nKey == K_LDBLCLK ) )
      MouseRow := mrow()
      MouseColumn := mcol()

      if ( ! ValType( oMenu ) == "O" )
         nButton := 0

      elseif ( ! oMenu:ClassName() == "TOPBARMENU" )
         nButton := 0

      elseif ( ( nButton := oMenu:HitTest( MouseRow, MouseColumn ) ) != 0 )
         MenuModal( oMenu, nButton, nMsgRow, nMsgLeft, nMsgRight, cMsgColor )
         nButton := 1

      endif

      lClose := .t.

      if ( nButton != 0 )
      elseif ( ( nButton := oGUI:HitTest( MouseRow, MouseColumn ) ) == HTNOWHERE )
         if ( HitTest( GetList, MouseRow, MouseColumn ) )
            oGet:exitstate := GE_MOUSEHIT
         else
            oGet:exitstate := GE_NOEXIT
         endif

      elseif ( nButton >= HTCLIENT )
         oGUI:Select( nButton )

      elseif ( nButton == HTDROPBUTTON )
         if ( ! oGUI:IsOpen )
            oGUI:Open()
            lClose := .f.

         endif

      elseif ( ( nButton >= HTSCROLLFIRST ) .and. ;
               ( nButton <= HTSCROLLLAST ) )
         oGUI:Scroll( nButton )
         lClose := .f.

      endif

      if ( ! lClose )
      elseif ( ! TheClass == "LISTBOX" )
      elseif ( ! oGUI:DropDown )
      elseif ( oGUI:IsOpen )
         oGUI:Close()
         oGUI:Display()
      endif

   ENDCASE

   RETURN



/***
*
*  tBrowseApplyKey()
*
*  default handler for Applying a single INKEY() keystroke to a tBrowse.
*
*  NOTE: GET and tBrowse ought to have focus.
*
*/
PROCEDURE tbApplyKey( oGet, oTB, GetList, nKey, oMenu, nMsgRow, nMsgLeft, nMsgRight, cMsgColor )

   LOCAL cKey
   LOCAL bKeyBlock
   local MouseRow, MouseColumn
   local nButton
   local nHotItem

   // Check for SET KEY first
   IF !( ( bKeyBlock := setkey( nKey ) ) == NIL )
      GetDoSetKey( bKeyBlock, oGet )
      RETURN                           // NOTE
   ENDIF

   if ( ( nHotItem := Accelerator( GetList, nKey ) ) != 0 )
      oGet:ExitState := GE_SHORTCUT
      snNextGet := nHotItem

   elseif ( oMenu == NIL )
   elseif ( ( nHotItem := oMenu:GetAccel( nKey ) ) != 0 )
      MenuModal( oMenu, nHotItem, nMsgRow, nMsgLeft, nMsgRight, cMsgColor )
      nKey := 0

   elseif ( IsShortCut( oMenu, nKey )  )
      nKey := 0

   endif

   DO CASE
   CASE ( nKey == K_TAB )
      oGet:exitState := GE_DOWN

   CASE ( nKey == K_SH_TAB )
      oGet:exitState := GE_UP

   CASE ( nKey == K_ENTER )
      oGet:exitState := GE_ENTER

   CASE ( nKey == K_ESC )
      IF ( SET( _SET_ESCAPE ) )
         oGet:exitState := GE_ESCAPE
      ENDIF

#ifdef CTRL_END_SPECIAL

   // Both ^W and ^End go to the last GET
   CASE ( nKey == K_CTRL_END )
      oGet:exitState := GE_BOTTOM

#else

   // Both ^W and ^End terminate the READ (the default)
   CASE ( nKey == K_CTRL_W )
      oGet:exitState := GE_WRITE

#endif
   CASE ( ( nKey == K_LBUTTONDOWN ) .or. ( nKey == K_LDBLCLK ) )
      MouseRow := mrow()
      MouseColumn := mcol()

      if ( ! ValType( oMenu ) == "O" )
         nButton := 0

      elseif ( ! oMenu:ClassName() == "TOPBARMENU" )
         nButton := 0

      elseif ( ( nButton := oMenu:HitTest( MouseRow, MouseColumn ) ) != 0 )
         MenuModal( oMenu, nButton, nMsgRow, nMsgLeft, nMsgRight, cMsgColor )
         nButton := 1

      endif

      if ( nButton != 0 )
      elseif ( ( nButton := oTB:HitTest( MouseRow, MouseColumn ) ) == HTNOWHERE )
         if ( HitTest( GetList, MouseRow, MouseColumn ) )
            oGet:exitstate := GE_MOUSEHIT
         else
            oGet:exitstate := GE_NOEXIT
         endif
      endif
   ENDCASE

   RETURN



/***
*
*  GetPreValidate()
*
*  Test entry condition (WHEN clause) for a GET
*
*/
FUNCTION GetPreValidate( oGet )

   LOCAL lSavUpdated
   LOCAL lWhen := .T.

   IF !( oGet:preBlock == NIL )

      lSavUpdated := slUpdated

      lWhen := EVAL( oGet:preBlock, oGet )

      oGet:display()

      ShowScoreBoard()
      slUpdated := lSavUpdated

   ENDIF

   IF ( slKillRead )

      lWhen := .F.
      oGet:exitState := GE_ESCAPE       // Provokes ReadModal() exit

   ELSEIF ( !lWhen )

      oGet:exitState := GE_WHEN         // Indicates failure

   ELSE

      oGet:exitState := GE_NOEXIT       // Prepares for editing

   ENDIF

   RETURN ( lWhen )



/***
*
*  GetPostValidate()
*
*  Test exit condition (VALID clause) for a GET
*
*  NOTE: Bad dates are rejected in such a way as to preserve edit buffer
*
*/
FUNCTION GetPostValidate( oGet )

   LOCAL lSavUpdated
   LOCAL lValid := .T.


   IF ( oGet:exitState == GE_ESCAPE )
      RETURN ( .T. )                   // NOTE
   ENDIF

   IF ( oGet:badDate() )
      oGet:home()
      DateMsg()
      ShowScoreboard()
      RETURN ( .F. )                   // NOTE
   ENDIF

   // If editing occurred, assign the new value to the variable
   IF ( oGet:changed )
      oGet:assign()
      slUpdated := .T.
   ENDIF

   // Reform edit buffer, set cursor to home position, redisplay
   oGet:reset()

   // Check VALID condition if specified
   IF !( oGet:postBlock == NIL )

      lSavUpdated := slUpdated

      // S'87 compatibility
      SETPOS( oGet:row, oGet:col + LEN( oGet:buffer ) )

      lValid := EVAL( oGet:postBlock, oGet )

      // Reset S'87 compatibility cursor position
      SETPOS( oGet:row, oGet:col )

      ShowScoreBoard()
      oGet:updateBuffer()

      slUpdated := lSavUpdated

      IF ( slKillRead )
         oGet:exitState := GE_ESCAPE      // Provokes ReadModal() exit
         lValid := .T.

      ENDIF
   ENDIF

   RETURN ( lValid )


/***
*
*  GUIPreValidate()
*
*  Test entry condition (WHEN clause) for a GET:GUI
*
*/
FUNCTION GUIPreValidate( oGet, oGUI )

   LOCAL lSavUpdated
   LOCAL lWhen := .T.

   IF !( oGet:preBlock == NIL )
      lSavUpdated := slUpdated

      lWhen := EVAL( oGet:preBlock, oGet )

      IF (! ( oGUI:ClassName == "TBROWSE" ) )
         oGUI:Display()
      ENDIF

      ShowScoreBoard()

      slUpdated := lSavUpdated
   ENDIF

   IF (slKillRead)

      lWhen := .F.
      oGet:exitState := GE_ESCAPE

   ELSEIF ( !lWhen )

      oGet:exitState := GE_WHEN

   ELSE

      oGet:exitState := GE_NOEXIT

   ENDIF

   RETURN (lWhen)


/***
*
*  GUIPostValidate()
*
*  Test exit condition (VALID clause) for a GET:GUI
*
*/
FUNCTION GUIPostValidate( oGet, oGUI )

   LOCAL lSavUpdated
   LOCAL lValid := .T.
   LOCAL uOldData, uNewData


   IF ( oGet:exitState == GE_ESCAPE )
      RETURN ( .T. )                   // NOTE
   ENDIF

   IF ( ! ( oGUI:ClassName == "TBROWSE" ) )
      uOldData := oGet:VarGet()
      uNewData := oGUI:Buffer
   ENDIF

   // If editing occurred, assign the new value to the variable
   IF ( ! ( uOldData == uNewData ) )
      oGet:VarPut( uNewData )
      slUpdated := .T.
   ENDIF

   // Check VALID condition if specified
   IF !( oGet:postBlock == NIL )

      lSavUpdated := slUpdated

      lValid := EVAL( oGet:postBlock, oGet )

      // Reset S'87 compatibility cursor position
      SETPOS( oGet:row, oGet:col )

      ShowScoreBoard()
      IF ( ! ( oGUI:ClassName == "TBROWSE" ) )
         oGUI:Select( oGet:VarGet() )
      ENDIF

      slUpdated := lSavUpdated

      IF ( slKillRead )
         oGet:exitState := GE_ESCAPE      // Provokes ReadModal() exit
         lValid := .T.

      ENDIF
   ENDIF

   RETURN ( lValid )



/***
*
*  GetDoSetKey()
*
*  Process SET KEY during editing
*
*/
PROCEDURE GetDoSetKey( keyBlock, oGet )

   LOCAL lSavUpdated

   // If editing has occurred, assign variable
   IF ( oGet:changed )
      oGet:assign()
      slUpdated := .T.
   ENDIF

   lSavUpdated := slUpdated

   EVAL( keyBlock, scReadProcName, snReadProcLine, ReadVar() )

   ShowScoreboard()
   oGet:updateBuffer()

   slUpdated := lSavUpdated

   IF ( slKillRead )
      oGet:exitState := GE_ESCAPE      // provokes ReadModal() exit
   ENDIF

   RETURN





/***
*              READ services
*/



/***
*
*  Settle()
*
*  Returns new position in array of Get objects, based on:
*     - current position
*     - exitState of Get object at current position
*
*  NOTES: return value of 0 indicates termination of READ
*         exitState of old Get is transferred to new Get
*
*/
STATIC FUNCTION Settle( GetList, nPos, lInit )

   LOCAL nExitState

   IF ( nPos == 0 )
      nExitState := GE_DOWN
   ELSEIF ( nPos > 0 .and. lInit)
      nExitState := GE_NOEXIT
   ELSE
      nExitState := GetList[ nPos ]:exitState
   ENDIF

   IF ( nExitState == GE_ESCAPE .or. nExitState == GE_WRITE )
      RETURN ( 0 )               // NOTE
   ENDIF

   IF !( nExitState == GE_WHEN )
      // Reset state info
      snLastPos := nPos
      slBumpTop := .F.
      slBumpBot := .F.
   ELSE
      // Re-use last exitState, do not disturb state info
      nExitState := snLastExitState
   ENDIF

   //
   // Move
   //
   DO CASE
   CASE ( nExitState == GE_UP )
      nPos--

   CASE ( nExitState == GE_DOWN )
      nPos++

   CASE ( nExitState == GE_TOP )
      nPos       := 1
      slBumpTop  := .T.
      nExitState := GE_DOWN

   CASE ( nExitState == GE_BOTTOM )
      nPos       := LEN( GetList )
      slBumpBot  := .T.
      nExitState := GE_UP

   CASE ( nExitState == GE_ENTER )
      nPos++

   CASE ( nExitState == GE_SHORTCUT )
      return ( snNextGet )

   CASE ( nExitState == GE_MOUSEHIT )
      return ( snNextGet )

   ENDCASE

   //
   // Bounce
   //
   IF ( nPos == 0 )                       // Bumped top
      IF ( !ReadExit() .and. !slBumpBot )
         slBumpTop  := .T.
         nPos       := snLastPos
         nExitState := GE_DOWN
      ENDIF

   ELSEIF ( nPos == len( GetList ) + 1 )  // Bumped bottom
      IF ( !ReadExit() .and. !( nExitState == GE_ENTER ) .and. !slBumpTop )
         slBumpBot  := .T.
         nPos       := snLastPos
         nExitState := GE_UP
      ELSE
         nPos := 0
      ENDIF
   ENDIF

   // Record exit state
   snLastExitState := nExitState

   IF !( nPos == 0 )
      GetList[ nPos ]:exitState := nExitState
   ENDIF

   RETURN ( nPos )



/***
*
*  PostActiveGet()
*
*  Post active GET for ReadVar(), GetActive()
*
*/
STATIC PROCEDURE PostActiveGet( oGet )

   GetActive( oGet )
   ReadVar( GetReadVar( oGet ) )

   ShowScoreBoard()

   RETURN



/***
*
*  ClearGetSysVars()
*
*  Save and clear READ state variables. Return array of saved values
*
*  NOTE: 'Updated' status is cleared but not saved (S'87 compatibility)
*/
STATIC FUNCTION ClearGetSysVars()

   LOCAL aSavSysVars[ GSV_COUNT ]

   // Save current sys vars
   aSavSysVars[ GSV_KILLREAD ]     := slKillRead
   aSavSysVars[ GSV_BUMPTOP ]      := slBumpTop
   aSavSysVars[ GSV_BUMPBOT ]      := slBumpBot
   aSavSysVars[ GSV_LASTEXIT ]     := snLastExitState
   aSavSysVars[ GSV_LASTPOS ]      := snLastPos
   aSavSysVars[ GSV_ACTIVEGET ]    := GetActive( NIL )
   aSavSysVars[ GSV_READVAR ]      := ReadVar( "" )
   aSavSysVars[ GSV_READPROCNAME ] := scReadProcName
   aSavSysVars[ GSV_READPROCLINE ] := snReadProcLine
   aSavSysVars[ GSV_NEXTGET ]      := snNextGet
   aSavSysVars[ GSV_HITCODE ]      := snHitCode
   aSavSysVars[ GSV_POS ]          := snPos

   // Re-init old ones
   slKillRead      := .F.
   slBumpTop       := .F.
   slBumpBot       := .F.
   snLastExitState := 0
   snLastPos       := 0
   scReadProcName  := ""
   snReadProcLine  := 0
   slUpdated       := .F.
   snNextGet       := 0
   snHitCode       := 0
   snPos           := 0

   RETURN ( aSavSysVars )



/***
*
*  RestoreGetSysVars()
*
*  Restore READ state variables from array of saved values
*
*  NOTE: 'Updated' status is not restored (S'87 compatibility)
*
*/
STATIC PROCEDURE RestoreGetSysVars( aSavSysVars )

   slKillRead      := aSavSysVars[ GSV_KILLREAD ]
   slBumpTop       := aSavSysVars[ GSV_BUMPTOP ]
   slBumpBot       := aSavSysVars[ GSV_BUMPBOT ]
   snLastExitState := aSavSysVars[ GSV_LASTEXIT ]
   snLastPos       := aSavSysVars[ GSV_LASTPOS ]

   snNextGet       := aSavSysVars[ GSV_NEXTGET ]
   snHitCode       := aSavSysVars[ GSV_HITCODE ]
   snPos           := aSavSysVars[ GSV_POS ]

   GetActive( aSavSysVars[ GSV_ACTIVEGET ] )

   ReadVar( aSavSysVars[ GSV_READVAR ] )

   scReadProcName  := aSavSysVars[ GSV_READPROCNAME ]
   snReadProcLine  := aSavSysVars[ GSV_READPROCLINE ]

   RETURN



/***
*
*  GetReadVar()
*
*  Set READVAR() value from a GET
*
*/
STATIC FUNCTION GetReadVar( oGet )

   LOCAL cName := UPPER( oGet:name )
   LOCAL i

   // The following code includes subscripts in the name returned by
   // this FUNCTIONtion, if the get variable is an array element
   //
   // Subscripts are retrieved from the oGet:subscript instance variable
   //
   // NOTE: Incompatible with Summer 87
   //
   IF !( oGet:subscript == NIL )
      FOR i := 1 TO LEN( oGet:subscript )
         cName += "[" + LTRIM( STR( oGet:subscript[i] ) ) + "]"
      NEXT
   END

   RETURN ( cName )





/***
*              System Services
*/



/***
*
*  __SetFormat()
*
*  SET FORMAT service
*
*/
PROCEDURE __SetFormat( b )
   sbFormat := IF( VALTYPE( b ) == "B", b, NIL )
   RETURN



/***
*
*  __KillRead()
*
*  CLEAR GETS service
*
*/
PROCEDURE __KillRead()
   slKillRead := .T.
   RETURN



/***
*
*  GetActive()
*
*  Retrieves currently active GET object
*/
FUNCTION GetActive( g )

   LOCAL oldActive := soActiveGet

   IF ( PCOUNT() > 0 )
      soActiveGet := g
   ENDIF

   RETURN ( oldActive )



/***
*
*  Updated()
*
*/
FUNCTION Updated()
   RETURN slUpdated



/***
*
*  ReadExit()
*
*/
FUNCTION ReadExit( lNew )
   RETURN ( SET( _SET_EXIT, lNew ) )



/***
*
*  ReadInsert()
*
*/
FUNCTION ReadInsert( lNew )
   RETURN ( SET( _SET_INSERT, lNew ) )



/***
*              Wacky Compatibility Services
*/


// Display coordinates for SCOREBOARD
#define SCORE_ROW      0
#define SCORE_COL      60


/***
*
*  ShowScoreboard()
*
*/
STATIC PROCEDURE ShowScoreboard()

   LOCAL nRow
   LOCAL nCol

   IF ( SET( _SET_SCOREBOARD ) )
      nRow := ROW()
      nCol := COL()

      SETPOS( SCORE_ROW, SCORE_COL )
      DISPOUT( IF( SET( _SET_INSERT ), NationMsg(_GET_INSERT_ON),;
                                       NationMsg(_GET_INSERT_OFF)) )

      SETPOS( nRow, nCol )
   ENDIF

   RETURN



/***
*
*  DateMsg()
*
*/
STATIC PROCEDURE DateMsg()

   LOCAL nRow
   LOCAL nCol

   IF ( SET( _SET_SCOREBOARD ) )

      nRow := ROW()
      nCol := COL()

      SETPOS( SCORE_ROW, SCORE_COL )
      DISPOUT( NationMsg(_GET_INVD_DATE) )
      SETPOS( nRow, nCol )

      WHILE ( NEXTKEY() == 0 )
      END

      SETPOS( SCORE_ROW, SCORE_COL )
      DISPOUT( LEN( NationMsg(_GET_INVD_DATE) ) )
      SETPOS( nRow, nCol )

   ENDIF

   RETURN



/***
*
*  RangeCheck()
*
*  NOTE: Unused second param for 5.00 compatibility.
*
*/
FUNCTION RangeCheck( oGet, junk, lo, hi )

   LOCAL cMsg, nRow, nCol
   LOCAL xValue

   IF ( !oGet:changed )
      RETURN ( .T. )          // NOTE
   ENDIF

   xValue := oGet:varGet()

   IF ( xValue >= lo .and. xValue <= hi )
      RETURN ( .T. )          // NOTE
   ENDIF

   IF ( SET(_SET_SCOREBOARD) )

      cMsg := NationMsg(_GET_RANGE_FROM) + LTRIM( TRANSFORM( lo, "" ) ) + ;
              NationMsg(_GET_RANGE_TO) + LTRIM( TRANSFORM( hi, "" ) )

      IF ( LEN( cMsg ) > MAXCOL() )
         cMsg := SUBSTR( cMsg, 1, MAXCOL() )
      ENDIF

      nRow := ROW()
      nCol := COL()

      SETPOS( SCORE_ROW, MIN( 60, MAXCOL() - LEN( cMsg ) ) )
      DISPOUT( cMsg )
      SETPOS( nRow, nCol )

      WHILE ( NEXTKEY() == 0 )
      END

      SETPOS( SCORE_ROW, MIN( 60, MAXCOL() - LEN( cMsg ) ) )
      DISPOUT( SPACE( LEN( cMsg ) ) )
      SETPOS( nRow, nCol )

   ENDIF

   RETURN ( .F. )



/***
*
*  ReadKill()
*
*/
FUNCTION ReadKill( lKill )

   LOCAL lSavKill := slKillRead

   IF ( PCOUNT() > 0 )
      slKillRead := lKill
   ENDIF

   RETURN ( lSavKill )



/***
*
*  ReadUpdated()
*
*/
FUNCTION ReadUpdated( lUpdated )

   LOCAL lSavUpdated := slUpdated

   IF ( PCOUNT() > 0 )
      slUpdated := lUpdated
   ENDIF

   RETURN ( lSavUpdated )



/***
*
*  ReadFormat()
*
*/
FUNCTION ReadFormat( b )

   LOCAL bSavFormat := sbFormat

   IF ( PCOUNT() > 0 )
      sbFormat := b
   ENDIF

   RETURN ( bSavFormat )




