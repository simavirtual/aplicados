/* This is a Clipper program for testing CleanClipper V1.0
*/

function main()

LOCAL m, a, b, c, d, e, f, g
strg := "abcdefghijklmnopqrstuvwxyz"&& this is a test

* code block spacing example
local myblock :={|a,b |a<b }

// loop invariant P0 == 0<=m<3 and alphabet written m*2 times thus far
  m:= 0         // P0 true
 scroll()
  do WHILE m !=3 
        display(m,str) /* call display for writing str */
        m++    && add 1 to m => P0 true
  Enddo  // finished with loop

  // assignment examples to demstrate minimizing/maximizing parentheses
  m:= a.and.b .OR. d.and.e<3 .And. f!=g
  m := (a.and.b) .or. (d.AND.(e>3) .and. (f!=g))  // same as above but with parens
RETURN nil
    

FUNCTION display(m, s)

/* Pre-cond : 0<=m<3 && s = string of alphabet
*  Post-cond: string s written diagonally twice
*/

  local r, c
  * demonstrate "if" constructs
  if m == 0		// check value of m
     c := 0
  ELSEIF m == 1
    c := 10
  else
      c := 20 
  ENDIF       && c = 0, 10 or 20 depending on m 
  

  // demonstrates "for" constructs
  FOR r = 1 to 25
   @ r, c say s[r]
   c++
  next

  * another demonstration of "if" construct
  IF m == 0 
     c := 5
  elseif m == 1
   c := 15
  else
    c := 25
 Endif				/* c = 5, 15 or 25 depending on m */

  // demonstrates of "case" construct
  DO CASE
   case m == 0
   c:= 5
   CASE m==1 .or.m==2
     c:=15
     OTHERWISE
      c:=25
   endcase

  // demonstrates "while" construct
  r := 0
  do WHILE r !=25 		  && loop until r=25
     @ r,c say s[r]   /* position cursor for display */
  c:=c+1  /* print character */
  ENDDO
return nil
