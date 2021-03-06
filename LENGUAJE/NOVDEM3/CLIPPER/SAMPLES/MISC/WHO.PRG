***
*** Determine Who Has A File Open Using NovLib
***
*** Syntax: WHO [FileName | UserName | ConnectionNumber] [/p] [/e]
***
***

#include "INKEY.CH"
#include "DIRECTRY.CH"
#include "NOVLIB.CH"

#xcommand DEFAULT <var> TO <InitVal> => ;
          IF <var> == NIL ; <var> := <InitVal> ; ENDIF

*
* Global Settings Used Throughout The Program
*
static lPause := .T.                   // Pause Between Screens ?
static lExcl  := .F.                   // Show Exclusive Files Only ?

*
* Entry Function
*
* Parameters : IN  - sFileName - Char - Opt - FileName/User Name/Connection
*                    sParm1    - Char - Opt - Additional Optional Parameters (see list)
*              OUT - None
*
* Notes:
* "Parm?" can be any one of the following:
*  -p[-+] : Pause when the screen is full (default is -p+)
*  -e[-+] : Show Only Files Opened Exclusively (default is -e-)
*
* These options can also be specified in the DOS environment variable "WHO"
*
function Who(sFileName, sParm1, sParm2)
local sFullPath, aFileList, sDosEnv

SET CENTURY ON
*
* Fill In Optional Command Line Parameters
*
DEFAULT sFileName TO "*.*"
sFileName := upper(sFileName)
*
* Set Global Options From DOS Environment Variable "WHO"
*
sDosEnv := gete("WHO")
SetGlobalOpts( { sDosEnv } )
*
* Set Global Options From The Command Line
*
if (left(sFileName,1) $ "-/")
   SetGlobalOpts({ sFileName, sParm1, sParm2 })
   sFileName := "*.*"
else
   SetGlobalOpts({ sParm1, sParm2 })
endif
*
* Determine What Type Of WHO Request Has Been Made
*
do case
   case (val(sFileName) > 0) .and. (val(sFileName) <= 256)
      *
      * Files Open For A Connection Number
      *
      ShowConnFiles(val(sFileName))
   case ( UsrConLst(sFileName) > 0 )
      *
      * Files For A User
      *
      ShowUserFiles(sFileName)
   otherwise
      *
      * Users With A File Open
      *
      ShowFileUsers(sFileName)
endcase

return (NIL)


/*旼 Function 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
  �         Name: ShowFileUsers()                                            �
  �  Description: Show All Of The Users Who Have File(s) Open                �
  �       Author: Eric E Sorensen                                            �
  � Date Created: 02-22-95      10:09:39am                                   �
  쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
  �   Parameters: sFileName - Char - Req - File Name/Spec To Show            �
  �      Returns: Nothing                                                    �
  읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
*/
static function ShowFileUsers( sFileName )
local sFullPath, aFileList, cDrive
*
* Get The Full Novell Path To Use For The File(s)
*
sFullPath := "" ; cDrive := DrvCurGet()
if IsDir(sFileName)
   * If The FileSpec Is A Directory Name - Add FileSpec Of All Files In Dir
   sFileName += iif(right(sFileName,1) $ ":\","","\") + "*.*"
endif
if empty(at(":",sFileName))
   * No Drive Or Volume Name Specified - Use Current Drive
   sFileName := cDrive + ":" + sFileName
endif
if (at(":",sFileName) == 2)
   * Replace DOS Drive With Netware Volume Name
   cDrive := left(sFileName,1) ; sFileName := substr(sFileName,3)
   sFullPath := DrivePath(cDrive) + sFullPath
endif
if (empty(at("\",sFileName)) .and. empty(at(":",sFileName))) .or. (right(sFileName,1)==".")
   * No Path Was Specified - Use Path Of Current Directory
   if ! empty(CurDir(cDrive))
      sFullPath += upper(CurDir(cDrive)) + "\"
   endif
endif
if (right(sFileName,1) $ ":\.") .or. empty(sFileName)
   * No File Spec Was Specified - Add FileSpec Of All Files
   if (right(sFileName,1) == ".")
      sFileName := left(sFileName, len(sFileName)-1)
   endif
   sFileName += "*.*"
endif
if (left(sFileName,1) == "\")
   * If FileSpec Starts With A \, Remove It Because It Is Not Required In Volume Names
   sFileName := substr(sFileName,2)
endif
sFileName := upper(sFullPath + sFileName)          // FileSpec To Check On
sFullPath := left(sFileName, rat("\",sFileName)-1) // Path Of FileSpec
*
* Get The List Of Files Matching This File Spec
*
aFileList := directory(sFileName)
asort(aFileList,,, { |a,b| a[F_NAME] < b[F_NAME] } )
*
* Print Headings
*
? "Users who currently have "+sFileName+" open"+iif(lExcl," exclusive","")+":"
?
? "File Name     Connection  User Name        Login Time           Full Name      "
? "컴컴컴컴컴컴  컴컴컴컴컴  컴컴컴컴컴컴컴�  컴컴컴컴컴컴컴컴컴�  컴컴컴컴컴컴컴�"
*
* Print The List For Each File
*
aeval(aFileList, { |f| ShowOpenList(sFullPath,f[F_NAME]) })
*
* Done
*
?

return (NIL)


/*旼 Function 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
  �         Name: ShowOpenList()                                             �
  �  Description: Show The List Of Users Who Have A Specific File Open       �
  �       Author: Eric E Sorensen                                            �
  � Date Created: 02-22-95      10:10:55am                                   �
  쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
  �   Parameters: sFullPath - Char - Req - Netware Path Of File              �
  �             : sFileName - Char - Req - File Name                         �
  �      Returns: Nothing                                                    �
  �     See Also: ShowFileUsers()                                            �
  읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
*/
static function ShowOpenList(sFullPath, sFileName)
local nCnt, nStaNo, sFileSpec := sFullPath+"\"+sFileName
*
* Get The First Station That Has The File Open
*
nCnt := 1
nStaNo := FilOpnConLst( sFileSpec, nCnt )
if (NWErrorGet() == -255)
   *
   * File Is Opened Exclusively
   *
   ? padr(sFileName,12)+"* "+padc(str(nStaNo,3),10)+MyConChar(nStaNo)+" "+padr(WSLogNmeGet(nStaNo),15)+"  "+dtoc(WSLogDteGet(nStaNo))+" "+WSLogTmeGet(nStaNo)+"  " +left(UsrFulNmeGet(WSLogNmeGet(nStaNo)),15)
   PauseCheck()
else
   *
   * Show All Connections With The File Open
   *
   if ! lExcl
      while (nStaNo <> -1)
         ? padr(sFileName,12)+"  "+padc(str(nStaNo,3),10)+MyConChar(nStaNo)+" "+padr(WSLogNmeGet(nStaNo),15)+"  "+dtoc(WSLogDteGet(nStaNo))+" "+WSLogTmeGet(nStaNo)+"  " +left(UsrFulNmeGet(WSLogNmeGet(nStaNo)),15)
         nCnt++
         PauseCheck()
         nStaNo := FilOpnConLst( sFileSpec, nCnt )
      enddo
   endif
endif

return (NIL)


/*旼 Function 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
  �         Name: MyConChar()                                                 �
  �  Description: Compare A Connection Number To The User's, And Set A Flag   �
  �       Author: Eric E Sorensen                                             �
  � Date Created: 02-22-95      10:12:00am                                    �
  쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
  �   Parameters: nConNo - Num  - Req - Connection Number To Compare To User's�
  �      Returns: sRet   - Char       - One Character Flag                    �
  읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*/
static function MyConChar( nConNo )
static nMyConNo
local sRet

if (nMyConNo == NIL)
   nMyConNo := WSConNumGet()
endif

sRet := iif(nConNo == nMyConNo,"*"," ")

return (sRet)


/*旼 Function 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
  �         Name: ShowUserFiles()                                            �
  �  Description: Display The List Of Files That A User Has Open             �
  �       Author: Eric E Sorensen                                            �
  � Date Created: 02-22-95      10:14:12am                                   �
  쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
  �   Parameters: sUserName - Char - Req - Novell User Id To Show Open Files �
  �      Returns: Nothing                                                    �
  �     See Also: ShowConnFiles()                                            �
  읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
*/
static function ShowUserFiles( sUserName )
local nConNo, aConnList, i, nCnt, sFileName, sLoginTime, sFullName
*
* Get The List Of Connections That This User Is Logged In At
*
aConnList := {}
nCnt := UsrConLst(sUserName)
for i = 1 to nCnt
   nConNo := UsrConLst("")
   if (nConNo >= 0)
      aadd(aConnList, nConNo)
   endif
next i
*
* Get The User's Full Name
*
sFullName := alltrim( UsrFulNmeGet ( sUserName ) )
*
* Print Headings
*
? "Files currently open by user " + sUserName + " (" + sFullName + ") :"
?
? "Connection  Login Time          File Name                                      "
? "컴컴컴컴컴  컴컴컴컴컴컴컴컴컴� 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�"
*
* Show The List Of Files For Each Connection
*
for i := 1 to len(aConnList)
   nCnt := 1
   nConNo := aConnList[i]
   sLoginTime := dtoc(WSLogDteGet(nConNo))+" "+WSLogTmeGet(nConNo)
   sFileName := FilOpnFilLst(nConNo, nCnt )
   while !empty( sFileName )
      if (len(sFileName) > 47)
         sFileName := "..." + right(sFileName,44)
      endif
      ? padc(str(nConNo,3),10) + MyConChar(nConNo) + " " + sLoginTime + " " + sFileName
      PauseCheck()
      sFileName := FilOpnFilLst( nConNo, ++nCnt )
   enddo
next i
*
* Done
*
?

return (NIL)


/*旼 Function 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
  �         Name: ShowConnFiles()                                            �
  �  Description: Display The List Of Files That A Connection Has Open       �
  �       Author: Eric E Sorensen                                            �
  � Date Created: 02-22-95      10:15:01am                                   �
  쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
  �   Parameters: nConNo - Num - Req - Connection # To Display Open Files    �
  �      Returns: Nothing                                                    �
  �     See Also: ShowUserFiles()                                            �
  읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
*/
static function ShowConnFiles( nConNo )
local nCnt, sFileName, sLoginTime, sFullName, sUserName
*
* Get The User's Full Name
*
sUserName := WSLogNmeGet(nConNo)
sFullName := alltrim( UsrFulNmeGet ( sUserName ) )
*
* Print Headings
*
? "Files currently open by connection " + alltrim(str(nConNo)) + "/" + sUserName + " (" + sFullName + ") :"
?
? "Connection  Login Time          File Name                                      "
? "컴컴컴컴컴  컴컴컴컴컴컴컴컴컴� 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�"
nCnt := 1
sLoginTime := dtoc(WSLogDteGet(nConNo))+" "+WSLogTmeGet(nConNo)
*
* Print The List Of Files
*
sFileName := FilOpnFilLst(nConNo, nCnt )
while !empty( sFileName )
   if (len(sFileName) > 47)
      sFileName := "..." + right(sFileName,44)
   endif
   ? padc(str(nConNo,3),10) + MyConChar(nConNo) + " " + sLoginTime + " " + sFileName
   PauseCheck()
   sFileName := FilOpnFilLst( nConNo, ++nCnt )
enddo
*
* Done
*
?

return (NIL)


/*旼 Function 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
  �         Name: SetGlobalOpts()                                            �
  �  Description: Set The Global Options From The Command Line Parameters    �
  �       Author: Eric E Sorensen                                            �
  � Date Created: 12-13-94      09:51:16am                                   �
  쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
  �   Parameters: aParms - Array - Opt - Array Of Command Line Arguments     �
  �      Returns: Nothing                                                    �
  읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
*/
static function SetGlobalOpts(aParms)
local nParm, sParm, sPrefix, sSuffix, lSetting

for nParm := 1 to len(aParms)
   sParm := aParms[nParm]
   *
   * Parse Parameter Components
   *
   if (sParm <> NIL)
      sPrefix := left(sParm,1)
      sParm := upper(substr(sParm,2))
      lSetting := (right(sParm,1) <> "-")
      if (right(sParm,1) $ "-+")
         sParm := left(sParm, len(sParm)-1)
      endif
   endif
   *
   * Validate Parameter
   *
   do case
      case empty(sParm)
         * No Parameter
      case ! (sPrefix $ "/-")
         * Not A Command Line Argument
         ?? [WHO : Invalid Command Line Parameter "] + aParms[nParm]
         ErrorLevel(2)
         QUIT
      case (sParm == "P")
         * Set Pause On
         lPause := lSetting
      case (sParm == "E")
         * Set Pause On
         lExcl := lSetting
      otherwise
         * Unknown Option
         ?? "Usage : WHO [FileName | UserName | ConnectionNumber] [/p+] [/e-] "
         ErrorLevel(2)
         QUIT
   endcase
next

return (NIL)


/*旼 Function 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
  �         Name: PauseCheck()                                               �
  �  Description: Check For A Pause Between Screens                          �
  �       Author: Eric E Sorensen                                            �
  � Date Created: 12-13-94      01:55:56pm                                   �
  쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
  �   Parameters: None                                                       �
  �      Returns: NIL                                                        �
  �     See Also: SetGlobalOpts()                                            �
  읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
*/
static function PauseCheck()
static nCnt := 5

if lPause
   nCnt++
   if (nCnt >= maxrow())
      WAIT
      if (lastkey() == K_ESC) ; QUIT ; endif
      nCnt := 0
   endif
endif

*
* Set The Error Level To 1 To Indicate That The File(s) Was In Use For Batch
*
ErrorLevel(1)

return (NIL)


/*旼 Function 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
  �         Name: IsDir()                                                    �
  �  Description: Test For The Existance Of A Directory Path                 �
  �       Author: Eric E Sorensen                                            �
  � Date Created: 02-22-95      10:15:49am                                   �
  쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
  �   Parameters: sPath - Char - Req - Path To Test For                      �
  �      Returns: lRet  - Log        - Does This Directory Exist ?           �
  읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
*/
static function IsDir( sPath )
local lRet, sTest, nPos
*
* Remove Any File Name Or Wildcard From The Path
*
sTest := sPath
if ("*" $ sTest) .or. ("." $ sTest)
   nPos := rat("\")
   if empty(nPos)
      nPos := rat(":")
   endif
   if empty(nPos)
      sTest := ""
   else
      sTest := left(sTest,nPos-1)
   endif
endif
if empty(sTest)
   lRet := .F.
else
   lRet := (len(directory( sTest, "D" )) > 0)
endif

return (lRet)


/*旼 Function 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
  �         Name: DrivePath()                                                �
  �  Description: Determine The Netware Volume For A Drive                   �
  �       Author: Eric E Sorensen                                            �
  � Date Created: 12-19-94      10:54:48am                                   �
  쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
  �   Parameters: cDrive - Char - Req - Drive To Get Volume Path             �
  �      Returns: sRet   - Char       - Netware Volume Path For Drive        �
  �        Notes: If drive is map rooted, path to root is returned also.     �
  읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
*/
static function DrivePath(cDrive)
local sRet
local sVolume, nDepth, nPos, nLvl

sVolume := DrvPthGet(cDrive)
nDepth := DrvDirDepGet(cDrive)

if (nDepth == 255)
   *
   * Not A Map Rooted Drive - Return Just The Volume Name
   *
   sRet := left(sVolume, at(":", sVolume))
else
   *
   * Drive Is Map Rooted - Return The Path To The Root Of The Drive
   *
   sRet := sVolume
   for nLvl := 1 to nDepth
      nPos := rat("/", sRet)
      sRet := left(sRet, nPos-1)
   next nLvl
   sRet += "\"
endif

return sRet
