/*****************************************************************************
*
*  Memosys.prg
*
*  Standard Clipper 5.3 memo Subsystem
*
*  Copyright (c) 1991-1993, Computer Associates International, Inc.
*  All rights reserved.
*
*  NOTE: compile with /m /n /w
*
*/

#include "memosys.ch"
#include "box.ch"


/*  OpenMemo(aInfo, indexEntry, indexSavescr)
* Opens a memo, calls MemoEdit and restores the screen
*
*/
FUNCTION OpenMemo(aInfo, indexEntry, indexSavescr, lModify)

      DrawMemoArea(aInfo, indexSavescr)
      EditMemo(aInfo, indexEntry, indexSavescr, lModify)
      RestoreMemoArea(aInfo, indexSavescr)

   RETURN .T.


/*  EditMemo(aInfo, indexEntry, indexSavescr, lModify)
* Edits a memo
*
*/
FUNCTION EditMemo(aInfo, indexEntry, indexSavescr, lModify)

      IF (aInfo[indexSavescr][MEMO__FRAME] == .T.)
         aInfo[indexEntry] := MemoEdit(aInfo[indexEntry],                   ;
                                       aInfo[indexSavescr][MEMO__TOP]+1,    ;
                                       aInfo[indexSavescr][MEMO__LEFT]+1,   ;
                                       aInfo[indexSavescr][MEMO__BOTTOM]-1, ;
                                       aInfo[indexSavescr][MEMO__RIGHT]-1,  ;
                                       lModify)
      ELSE
         aInfo[indexEntry] := MemoEdit(aInfo[indexEntry],                 ;
                                       aInfo[indexSavescr][MEMO__TOP],    ;
                                       aInfo[indexSavescr][MEMO__LEFT],   ;
                                       aInfo[indexSavescr][MEMO__BOTTOM], ;
                                       aInfo[indexSavescr][MEMO__RIGHT],  ;
                                       lModify)
      ENDIF

   RETURN .T.


/*  DrawMemoArea(aInfo, indexSavescr)
* Save, clear and frame entry window for future MemoEdit call
*
*/
FUNCTION DrawMemoArea(aInfo, indexSavescr)
   local top, left, bottom, right

      top    := aInfo[indexSavescr][MEMO__TOP]
      left   := aInfo[indexSavescr][MEMO__LEFT]
      bottom := aInfo[indexSavescr][MEMO__BOTTOM]
      right  := aInfo[indexSavescr][MEMO__RIGHT]

      aInfo[indexSavescr][MEMO__SAVESCR] := SaveScreen(top, left, bottom, right)
      Scroll(top, left, bottom, right, 0)
      IF (aInfo[indexSavescr][MEMO__FRAME] == .T.)
         @ top, left, bottom, right BOX B_SINGLE
      ENDIF

   RETURN .T.


/*  RestoreMemoArea(aInfo,indexSavescr)
* Restores the screen area covered by a memo
*
*/
FUNCTION RestoreMemoArea(aInfo, indexSavescr)

      RestScreen(aInfo[indexSavescr][MEMO__TOP],    ;
                 aInfo[indexSavescr][MEMO__LEFT],   ;
                 aInfo[indexSavescr][MEMO__BOTTOM], ;
                 aInfo[indexSavescr][MEMO__RIGHT],  ;
                 aInfo[indexSavescr][MEMO__SAVESCR] )

   RETURN .T.


/*  CloseMemo()
* manages the VALID clause for the memo entry fields
*
*/
FUNCTION CloseMemo()

   RETURN .T.


