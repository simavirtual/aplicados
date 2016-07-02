* ÚÄ Program ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
* ³ Application : INITEST.EXE
* ³ Purpose     : oFgIni.lib sample program
* ³ File Name   : INITEST.PRG
* ³ Author      : Felix H. Gonzalez
* ³ Date created: 01-30-94     
* ³ Time created: 07:54:40am   
* ³ Make File   : MAKE.BAT          
* ³ Exec File   : INITEST.EXE
* ³ Copyright   : 1994 by Felix H. Gonzalez
* ³ Compile     : /n /w
* ³ Notes       :
* ³             :
* ³             :
* ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

MEMVAR GETLIST

function Main()

  //create the object and open or create the file
  LOCAL oIni := oFgIni():New():Use("TEST.INI")

  // get a logical value
  LOCAL lValue1 := oIni:GetValue( "SectionName", "LogicalVar", .T., "L" )

  // get a numeric value
  LOCAL nValue2 := oIni:GetValue( "SectionName", "NumberVar", 100, "N" )

  // get a char string
  LOCAL cValue3 := oIni:GetValue( "Section", ;
                                  "CharVar", "ValName", "C", 10 )

  // get a date value
  LOCAL dValue4 := oIni:GetValue("Section","DateVar",  Date(), "D" )

  // using oIni in SetColor()
  SetColor( oIni:GetValue("Color","ScreenColor", "w/b" ) )

  CLEAR SCREEN

  @ 1, 1  SAY "Value1:" GET lValue1 ;
          COLOR oIni:GetValue("Color","BlueWhite", "b/w" )

  @ 2, 1  SAY "Value2:" GET nValue2 PICTURE"99999" ;
          COLOR oIni:GetValue("Color","RedWhite", "r/w" )

  @ 3, 1  SAY "Value3:" GET cValue3 PICTURE "@K";
          COLOR oIni:GetValue("Color","WhiteRed", "w/r" )

  @ 4, 1  SAY "Value4:" GET DValue4

  READ

  SET COLOR TO
  CLEAR SCREEN
  ? lValue1
  ? nValue2
  ? cValue3
  ? dValue4
  ? "see test.ini file"
  ?
  ?

  // save new values. ::SetValue() may be called to build the
  // ini file first before calling GetValue.
  oIni:SetValue( "SectionName", "LogicalVar", lValue1 )
  oIni:SetValue( "SectionName", "NumberVar", nValue2 )

  oIni:SetValue( "Section", "CharVar", cValue3 )
  oIni:SetValue( "Section", "DateVar", dValue4 )


  oIni:Close()  // or oIni:Use(), saves the new values to file
return(NIL)
