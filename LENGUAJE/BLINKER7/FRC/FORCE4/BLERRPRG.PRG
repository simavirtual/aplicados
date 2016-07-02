/*****************************************************************
*
*  Program  : BLERRPRG.PRG
*           : Blinker / Force 4.0 error handler
*  Date     : 98.10.31
*
*
*  Note     : Overlaying of this file is NOT recommended, because
*           : if a severe error occurs, it may be impossible to
*           : load this error handler into memory, in which case
*           : the error will never be reported, making debugging
*           : difficult.
*/

#include blinker.hdr
#include string.hdr

proc BlErrPrg

vardef
   char cErrMsg
   char cErrParam
   uint uErrNum
enddef

uErrNum := BLIERRNUM()
cErrParam := BLIERRPRMFOR()
cErrMsg := ""

do case

case uErrNum == 1201
   cErrMsg += "unable to find overlay "
   cErrMsg += cErrParam
   cErrMsg += " in the current PATH"
case uErrNum == 1202
   cErrMsg += "DOS read error in file "
   cErrMsg += cErrParam
case uErrNum == 1203
   cErrMsg += "file "
   cErrMsg += cErrParam
   cErrMsg += " is not a valid .EXE file"
case uErrNum == 1204
   cErrMsg += "overlay file "
   cErrMsg += cErrParam
   cErrMsg += " does not match the .EXE file"
case uErrNum == 1205
   cErrMsg += "not enough memory to load procedure"
case uErrNum == 1206
   cErrMsg += "maximum procedure nesting depth exceeded"
case uErrNum == 1207
   cErrMsg += "demonstration calls limit exceeded"
case uErrNum == 1208
   cErrMsg += "demonstration date limit exceeded"
case uErrNum == 1209
   cErrMsg += "demonstration time limit exceeded"
case uErrNum == 1210
   cErrMsg += "overlay has been prematurely freed"
case uErrNum == 1211
   cErrMsg += "overlay manager stack overflow"
case uErrNum == 1212
   cErrMsg += "Overlay Opsize exceeded - increase Opsize"
case uErrNum == 1213
   cErrMsg += "Attempt to call DEFINED routine"
case uErrNum == 1214
   cErrMsg += "Error accessing EMS overlay cache"
case uErrNum == 1215
   cErrMsg += "Error accessing XMS overlay cache"
case uErrNum == 1216
   cErrMsg += "Overlay manager unable to resume"
case uErrNum == 1217
   cErrMsg += "overlay vector corrupted during execution"
otherwise
   cErrMsg += "undefined error"
endcase

clear
?
? "BLINKER : " + padl( istr( uErrNum ), 4, ' ' ) + __c_space + cErrMsg
?
?
quit

endproc

