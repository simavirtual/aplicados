/*
 * Some print queue assign/selction routines for Clipper 5.x and NOVLIB 3.x
 *  plus a bonus Novell utility menu look-a-like!
 *
 * Note:
 * These routines will detect AND CAN CHANGE your current CAPTURE settings.
 *
 * By Steve Busey 03/01/95
 *
 * Build:
 *    CLIPPER prttest.prg /n/m/w
 *    BLINKER fi prttest li novlib /q
 *
 */

#include "box.ch"
#include "inkey.ch"
#include "novlib.ch"

STATIC nPrtPort := 0  

// function to test printer selection routines
function Test()
  LOCAL p, cPrompt, nChoice

  cls( 23, chr(176) )

  p := SelectPrinter()

  cPrompt := "You Selected LPT"+ str( p, 1 ) +      ;
    iif( CapActiveTst( p ),             ;
    " "+ ObjNmeGet(CapQueGet( p )),    ;
    " Local Printer")

  nChoice := nMenu( 10, 30, cPrompt, {"Send Test Printout", "Done"},, 2)

  if nChoice == 1
    SET PRINTER TO ("LPT"+str(p,1))
        
    SET PRINTER ON
    SET CONSOLE OFF

    qout("Printer LPT" + str( p, 1 ) + " Selected"+ ;
      iif( CapActiveTst(p),                                     ;
      " - Queue: "+ ObjNmeGet(CapQueGet(p)),                   ;
      " - Local Printer"))
    
    qout("Test print")
    qout("Test print")
    qout("Test print")
    qout("Test print")
    qout("Test print")
    qqout(chr(12))
    CapFlush( p )

    SET PRINTER OFF
    SET CONSOLE ON
  endif 

  return(Nil)

// routine to select print dest and assign queues to ports
FUNCTION SelectPrinter()
  LOCAL i, j, k, aPorts, cScr, cOldColor
  LOCAL cPrtQueue := "", cNewQueue, nChoice := 1, lCancel
  
  cOldColor := setcolor("w+/b")
  cScr      := savescreen(0,0,24,79)
  lCancel   := setcancel(.F.)
  aPorts    := array(3)
  
  do while .T. 
    
    nPrtPort  := 0
    cPrtQueue := ""
    
    for i := 1 to 3
      j := CapQueGet(i)
      if abs(j) > 1 .and. CapActiveTst(i)
        aPorts[i] := "LPT"+str(i,1)+ "  Network: "+ObjNmeGet(j)
      else
        aPorts[i] := "LPT"+str(i,1)+ "  Local Printer"
      endif 
    next 
    
    restscreen( 0, 0, 24, 79, cScr)
    @ 24,0 say padc("<Enter> To Select Print Destination - <Alt-C> To Configure Port", 80)
    
    set key K_ALT_C to ConfigPort
    
    nChoice := nMenu( 7, 10, "Select Destination Printer", aPorts, ;
      "w+/n,b/w,,,b+/n", nChoice )
    
    set key K_ALT_C to 
    
    if nextkey() == 255 
      nPrtPort  := nChoice
      
      // get current active queue
      if CapActiveTst(nPrtPort)
        cPrtQueue := ObjNmeGet(CapQueGet(nPrtPort))
      endif
      // prompt for new queue
      cNewQueue := GetNetPtr( cPrtQueue )
      
      if lastkey() != K_ESC
        // if new queue selected, reassign port to new queue
        if !(cNewQueue == cPrtQueue)
          CapCancel( nPrtPort )
          if !empty( cNewQueue )
            k := QueIdGet( cNewQueue )
            if k != -1
              if CapQueSet( nPrtPort, k) != -1
                if CapSetup( nPrtPort )
                  CapFmFdSet( nPrtPort, .F. )
                  CapBanFlgSet( nPrtPort, .F. )
                  CapStart( nPrtPort )
                endif 
              endif 
            endif 
          endif 
        endif 
      endif 
      loop
    endif 
    
    if nChoice > 0
      nPrtPort  := nChoice
      exit
    endif 
  enddo 
  
  setcancel( lCancel )
  setcolor( cOldColor )
  restscreen( 0, 0, 24, 79, cScr)
  
  return( nPrtPort )

// provide a picklist of current print queues, and return selection
FUNCTION GetNetPtr( cQueue )
  LOCAL i, j, QueGetNam, aQueues, nChoice := 1, cScr
  
  cScr      := savescreen(0,0,24,79)

  aQueues   := {"<Local Printer Port>"}
  QueGetNam := FSObjLst( "*", OT_PRINT_QUEUE, .T. ) && Get first queue name
  do while !empty( QueGetNam )                 && Loop while more
    aadd( aQueues, QueGetNam )
    QueGetNam := FSObjLst("", OT_PRINT_QUEUE, .F.)  && Get next queue name
  enddo
  aQueues   := asort(aQueues)
  
  if !empty(cQueue)
    nChoice := ascan( aQueues, cQueue)
    if nChoice==0
      nChoice := 1
    endif 
  endif 
  
  nChoice := nMenu( 6, 26, "Assign Print Queue To LPT"+str(nPrtPort,1),;
    aQueues, "w+/n,b/w,,,b+/n", nChoice )
  
  restscreen(0,0,24,79, cScr)
  
  if nChoice > 0
    retu(aQueues[nChoice])
  endif 
  
  return("")

// routine to fill the screen with a fill character with specified color attr
FUNCTION cls( nAttr, chFill )
  return( restscreen( 0,0,24,79, repl(chFill+chr(nAttr),2000)))

// Novell utility style menu routine
FUNCTION nMenu( nTop, nLeft, cTitle, aPrompts, cColor, nChoice )
  LOCAL nLen, nWidth, nBottom, nRight, x
  LOCAL colNormal, colHilite, colBox, cOldcolor
  
  if valtype(cColor) != "C"
    cColor := "w+/n,b/w,,,b+/n"
  endif 
  
  colNormal := left( cColor,    at( ",", cColor)-1)
  colHilite := substr( cColor,  at( ",", cColor)+1)
  colHilite := left( colHilite, at( ",", colHilite)-1)
  colBox    := substr( cColor, rat( ",", cColor)+1)
  cOldcolor := setcolor( cColor )
  
  if valtype(nChoice) != "N"
    nChoice := 1
  endif 
  
  nLen   := len( aPrompts ) + 3                  // get box size
  
  nWidth := 0
  aeval( aPrompts, {|e| nWidth := max(nWidth,len(e))}) // get max width
  nWidth := max( nWidth, len(cTitle) )
  
  nBottom := nTop  + nLen
  nRight  := nLeft + nWidth + 3
  
  nBox( nTop, nLeft, nBottom, nRight, cTitle, colBox, colNormal )
  
  for x := 1 to len(aPrompts)
    @ nTop+2+x, nLeft+3 prompt padr( aPrompts[x], nWidth ) 
  next
  
  menu to nChoice
  
  setcolor( cOldColor )
  
  return(nChoice)

// routine to draw Novell utility style box
STATIC FUNCTION nBox( t, l, b, r, cTitle, colBox, colText )
  
  dispbox( t, l, b, r, B_DOUBLE+" ", colBox )        // draw box
  @ t+2,l say "Ì"+repl(chr(205),r-l-1)+"¹" COLOR colBox // draw horiz box bar
  dispbox( t+3, l+2, b-1, l+2, repl(chr(179),4),colText ) // draw vert menu bar
  @ t+1, l+1 say padc( cTitle, (r-l)-1 ) COLOR colBox // write box title
  
  return(Nil)

STATIC PROCEDURE ConfigPort
  clear typeahead
  keyboard chr(13)+chr(255)
  return
