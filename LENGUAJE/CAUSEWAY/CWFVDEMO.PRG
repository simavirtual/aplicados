#include "INKEY.CH"
#include "FILEVIEW.CH"

static aColors := { "N", "B", "G", "BG", "R", "RB", "GR", "W" }

static nFore    := 8
static nBack    := 1
static lIntense := .F.

procedure Main( cFile )

local cScreen := saveScreen( 0, 0, maxrow(), maxcol() )

set cursor off

SetColor( aColors[ nFore ] + "/" + aColors[ nBack ] )

cls

CWFileView( cFile, 0, 0,maxrow() - 1,maxcol(), {| _1, _2 | FileProc( _1, _2 )} )

set cursor on

restScreen( 0, 0, maxrow(), maxcol(), cScreen )

return



function FileProc( nRow, nCol )

static nRowCount, nColCount

local nRet := 0
local cColor
local nKey
local cTmp

// The first time this is called, nRow and nCol will contain the total
// number of rows and columns in the display.  Those values are stored
// and the current row and column are set to 1.

if nRowCount == NIL
   nRowCount := nRow
   nColCount := nCol

   nRow := nCol := 1
endif

// A status line will appear on the bottom of the display, and the colors
// will be the inverse of those used to display the file.  Obviously you
// can modify or remove this behavior.

cColor := aColors[ nBack ] + iif( lIntense, "+/", "/" ) + aColors[ nFore ]

// Display the status bar with the current row and column.

dispBegin()

setPos( maxrow(), 0 ) ; dispOut( space( maxcol() + 1 ), cColor )

cTmp := "Line: " + ltrim( str( nRow ) ) + " of " + ltrim( str( nRowCount ) )

setPos( maxrow(), 1 ) ; dispOut( cTmp, cColor )

cTmp := "Column: " + ltrim( str( nCol ) ) + " of " + ltrim( str( nColCount ) )

setPos( maxrow(), maxcol() - len( cTmp ) - 1 ) ; dispOut( cTmp, cColor )

dispEnd()

// Get a keystroke, and use it to tell the file viewer what to do.
//
// This is just an example; the nice thing about the file viewer is
// that you control it by returning a specific value from the codeblock,
// so you can use whatever keystrokes you wish (for that matter, you
// don't even have to use keystrokes -- you can use any method you like
// to determine what value the code block will return).

nKey := inkey( 0 )

do case
   case nKey == K_CTRL_PGUP
      nRet := FV_TOP                   // Go to top of file

   case nKey == K_CTRL_PGDN
      nRet := FV_BOTTOM                // Go to bottom of file

   case nKey == K_HOME
      nRet := FV_LEFTEDGE              // Go to first column

   case nKey == K_END
      nRet := FV_RIGHTEDGE             // Go to last column

   case nKey == K_UP
      nRet := FV_UP                    // Scroll up one row

   case nKey == K_DOWN
      nRet := FV_DOWN                  // Scroll down one row

   case nKey == K_LEFT
      nRet := FV_LEFT                  // Scroll left one column

   case nKey == K_RIGHT
      nRet := FV_RIGHT                 // Scroll right one column

   case nKey == K_PGUP
      nRet := FV_PGUP                  // Scroll up one page

   case nKey == K_PGDN
      nRet := FV_PGDN                  // Scroll down one page

   case nKey == K_CTRL_LEFT
      nRet := FV_PGLEFT                // Scroll right one page

   case nKey == K_CTRL_RIGHT
      nRet := FV_PGRIGHT               // Scroll left one page

   case nKey == K_CTRL_HOME
      nRet := FV_TOP + FV_LEFTEDGE     // Cool!  Behaviors are additive,
                                       // so we can go to first line and
                                       // first column simultaneously.

   case nKey == K_TAB
      nRet := FV_DOWN + FV_RIGHT       // Scroll right & down

   case nKey == K_SH_TAB
      nRet := FV_UP + FV_LEFT          // Scroll left & up

   case nKey == K_F10
      lIntense := .not. lIntense       // Toggle color intensity

   case nKey == K_SH_F10
      nFore++                          // Change foreground color

      if nFore > 8
         nFore := 1
      endif

   case nKey == K_ALT_F10
      nBack++                          // Change background color

      if nBack > 8
         nBack := 1
      endif

   case nKey == K_ESC
      nRet := 65536                    // Time to quit

      nRowCount := nColCount := NIL    // Reset for next time
endcase

SetColor( aColors[ nFore ] + iif( lIntense, "+/", "/" ) + aColors[ nBack ] )

return nRet