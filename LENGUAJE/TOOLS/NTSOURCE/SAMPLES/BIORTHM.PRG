*********** Sample programs for Nantucket Tools II / 5.01 ********
*
* Program     : BIORTHM.PRG
* Copyright   : (c) 1991, Nantucket  Corp.  All rights reserved.
* Date        : 01/10/91
* Author      : Lothar Bongartz / Michael Peters
* Description : Calculation of the Biorhythm
* Compiling   : CLIPPER BIORTHM
* Linking     : RTLINK FI BIORTHM LIB NT250
* Remarks     : Value range is between -100 and +100
*
*******************************************************************

  CLS

  SET DATE AMERICAN

  @ 08, 00 SAY CENTER("Please enter your birthdate!")
  dBirthDate := CTOD("  /  /  ")
  @ 10, MAXCOL() /2 -4 GET dBirthDate
  READ

  BioPsy := 0
  BioInt := 0
  BioPhy := 0

  BioRhythm(@BioPsy, @BioInt, @BioPhy, dBirthDate, DATE())

  CLS

  ? "Biorhythm"
  ?
  ? "Psyche  ", BioPsy
  ? "Mind    ", BioInt
  ? "Body    ", BioPhy
  ?
  INKEY(0)
 RETURN

 FUNCTION BioRhythm(BioPsy, BioInt, BioPhy, BirthDate, Today)
   LOCAL DiffDays := Today -BirthDate

   BioPsy := INT(100 *SIN((2 *PI() /28) *DiffDays %28))
   BioInt := INT(100 *SIN((2 *PI() /33) *DiffDays %33))
   BioPhy := INT(100 *SIN((2 *PI() /23) *DiffDays %23))
 RETURN(NIL)

