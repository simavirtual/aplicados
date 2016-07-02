
******************************************************************************
*                                                                            *
* DEMO.PRG  V2.00                                                            *
* NOVLIB Demonstration program                                               *
* (C) 1990,1996 ASM Inc         .  All Rights Reserved.                      *
*                                                                            *
******************************************************************************

#include "novlib.ch"

parameters CmdLine

LOCAL prompts := { ;
                   {"Connection Information ", {|| ConnInfo()}}, ;
                   {"Change Current Server  ", {|| ChangeFs()}}, ;
                   {"User Information       ", {|| BindInfo()}}, ;
                   {"Volume Information     ", {|| VolInfo()}}, ;
                   {"Fileserver Information ", {|| FSInfo()}}, ;
                   {"Print Queues           ", {|| QInfo()}}, ;
                   {"Messages               ", {|| Message()}}, ;
                   {"Function Summary       ", {|| FuncTest()}} ;
                 },;
      menuchoice,i

SET SCOREBOARD OFF

SysMaster := if("MASTER" $ upper(if(type("CmdLine")=="U","",CmdLine)),.t.,.f.)
clear

TIMEVTINI( "EFunc", 1 )
BackGnd()
ExpBox(6,27,18,53,"Available Topics",.t.)
do while .t.
  ExpBox(6,27,18,53,"Available Topics",.t.,.t.)
  MessPlace(3)
  title("NOVLIB Library Demonstration  V3.00")
  color(3)
  for i = 1 to 8
    @ 8+i, 30 PROMPT prompts[i][1]
  next
  menu to menuchoice
  if menuchoice > 0
    eval(prompts[menuchoice][2])
  else
    exit
  endif
enddo

set color to
clear
set(_SET_CURSOR,1)


FUNCTION ConnInfo
LOCAL Users[100],Connection,UserNo,UserChoice,screen1,screen2
UserTitle()
ExpBox(6,27,18,53,"Available Topics",.t.,.f.)
screen1 := savescreen(4,5,21,42)
Expbox(4,5,21,42,"Current Connections",.t.)
MessPlace(1)
UserNo := 1
for Connection = 1 to 100
  if !empty(WSLOGNMEGET(Connection))
    Users[UserNo++] := padr(WSLOGNMEGET(Connection),28," ")+str(Connection,3)
  endif
next
do while .t.
  Expbox(4,5,21,42,"Current Connections",.t.,.t.)
  MessPlace(3)
  color(3)
  if (UserChoice := achoice(7,8,20,41,Users)) == 0
    exit
  else
    Connection := val(alltrim(right(Users[UserChoice],5)))
    Expbox(4,5,21,42,"Current Connections",.t.,.f.)
    screen2 := savescreen(9,43,18,79)
    ExpBox(9,43,18,79,"Connection Information",.f.)
    @12,45 say "Connection"
    @13,45 say "Login Name"
    @14,45 say "Login Date"
    @15,45 say "Login Time"
    @16,45 say "User ID"
    @17,45 say "Full Name"
    color(3)
    @12,56 say ltrim(str(Connection))
    @13,56 say substr(WSLOGNMEGET(Connection),1,15)
    @14,56 say WSLOGDTEGET(Connection)
    @15,56 say WSLOGTMEGET(Connection)
    @16,56 say ltrim(NOVSTRHEXGET(WSLOGIDGET(Connection)))
    @17,56 say substr(USRFULNMEGET(WSLOGNMEGET(Connection)),1,15)
    MessPlace(2)
    restscreen(9,43,18,79,screen2)
  endif
enddo
restscreen(4,5,21,42,screen1)
RETURN NIL


FUNCTION ChangeFS
LOCAL Servers[8],ServerNo,NewServer,screen1
screen1 := savescreen(7,14,18,66)
UserTitle()
ExpBox(6,27,18,53,"Available Topics",.t.,.f.)
ExpBox(7,14,18,66,"Fileserver              User Name              ",.f.)
MessPlace(1)
for ServerNo = 1 to 8
  FSPREFCONSET(ServerNo)
  if FSPREFCONGET() == ServerNo
    Servers[ServerNo] := padr(FSNMEGET(),24)+padr(WSLOGNMEGET(),24)
  endif
next
FSPREFCONSET(1)
MessPlace(3)
color(3)
@ 10,16 to 17,16
if (NewServer := achoice(10,17,17,65,Servers)) != 0
  FSPREFNMESET(NewServer)
endif
restscreen(7,14,18,66,screen1)
return NIL


FUNCTION FSInfo
LOCAL screen1
screen1 := savescreen(4,2,21,42)
UserTitle()
ExpBox(6,27,18,53,"Available Topics",.t.,.f.)
ExpBox(4,2,21,42,"File Server Information",.f.)
@7,4 say "Name"
@8,4 say "NetWare Version"
@9,4 say "Netware Serial No"
@10,4 say "SFT Level"
@11,4 say "TTS Level"
@13,4 say "Network Number"
@14,4 say "Max Connections"
@15,4 say "Curr Connections"
@16,4 say "Peak Connections"
@17,4 say "Max Volumes"
@18,4 say "File Server Date"
@19,4 say "File Server Time"
@20,4 say "Login Enabled"
color(3)
@7,26 say left(FSNMEGET(),15)
@8,26 say ltrim(NWVERNUMGET())
@9,26 say NWSERNUMGET()
@10,26 say ltrim(str(FSSFTLVLGET()))
@11,26 say ltrim(str(FSTTSLVLGET()))
@13,26 say WSNETADRGET(WSConNumGet())
@14,26 say ltrim(str(FSCONMAXGET()))
@17,26 say ltrim(str(FSVOLMAXGET()))
MessPlace(2,.t.)
color(3)
do while .t.
  @15,26 say ltrim(str(FSCURCONGET()))
  @16,26 say ltrim(str(FSPEAKCONGET()))
  @18,26 say FSDTEGET()
  @19,26 say FSTMEGET()
  @20,26 say iif(FSLOGSTATGET(),"Yes","No ")
  if inkey(1) != 0
    exit
  endif
enddo
restscreen(4,2,21,42,screen1)
RETURN NIL


FUNCTION BindInfo
LOCAL CurrUser,Users[250],UserChoice,UserID,SpaceAvail,nCounter,nVolFree
UserTitle()
ExpBox(6,27,18,53,"Available Topics",.t.,.f.)
MessPlace(1)
CurrUser := 1
if !empty(Users[CurrUser++] := FSOBJLST("*",OT_USER, .T.))
  do while !(empty(Users[CurrUser] := FSOBJLST("",OT_USER, .F.)))
    if CurrUser == 250
      exit
    endif
    CurrUser++
  enddo
endif
if CurrUser > 1
  asort(Users,1,CurrUser-1)
endif
screen1 := savescreen(4,5,20,35)
ExpBox(4,5,20,35,"User Name",.t.)
do while .t.
  ExpBox(4,5,20,35,"User Name",.t.,.t.)
  MessPlace(3)
  color(1)
  if (UserChoice := achoice(7,8,19,34,Users)) == 0
    exit
  else
    screen2 := savescreen(7,36,18,79)
    ExpBox(4,5,20,35,"User Name",.t.,.f.)
    ExpBox(7,36,18,79,"User Information",.f.)
    MessPlace(1)
    color(1)
    UserID := USRIDGET(alltrim(Users[UserChoice]))
    @10,38 say  "Login Name"
    @11,38 say  "ID Number"
    @12,38 say  "Full Name"
    @14,38 say  "Directories"
    @15,38 say "Files"
    @16,38 say "Space Used"
    @17,38 say "Space Available"
    color(3)
    @10,54 say ltrim(substr(Users[UserChoice],1,30))
    @11,54 say ltrim(NOVSTRHEXGET(UserID))
    @12,54 say left(USRFULNMEGET(substr(Users[UserChoice],1,30)),15)
    @14,54 say ltrim(str(USRDIRCNTGET(0,UserID)))
    @15,54 say ltrim(str(USRFILCNTGET(0,UserID)))
    @16,54 say ltrim(transform(USRDSKBLKGET(0,UserID) * VOLBLKSIZGET(0),"###,###,###,###"))
    if val(left(ltrim(NWVERNUMGET()),1)) > 2
      nCounter := 0
      SpaceAvail := 0
      do while .T.
        nVolFree := USRVOLFREGET( nCounter++, UserID )
        if nVolFree > 0
          SpaceAvail += nVolFree
        else
          exit
        endif
      enddo
    else
      SpaceAvail = USRDSKFREGET(UserID)
    endif
    @17,54 say iif(SpaceAvail = -255,"No Limit",ltrim(transform(SpaceAvail * VOLBLKSIZGET(0),"###,###,###,###")))
    MessPlace(2)
    restscreen(7,36,18,79,screen2)
  endif
enddo
restscreen(4,5,20,35,screen1)
RETURN NIL


FUNCTION VolInfo
LOCAL UserChoice,VolNum,x,y,screen1
UserTitle()
screen1 := savescreen(4,0,21,79)
@ 4,0 clear to 21,79
color(1)
@ 4,0 to 21,79 double
@5,2 say "Volume"
@7,2 say "Size"
@8,2 say "Block Size"
@9,2 say "Available Space"
@10,2 say "Max Dir Entries"
@11,2 say "Avail Dir Entries"
@12,2 to 12,77
@6,2 to 6,77
@14,2 to 14,77
@20,2 to 20,77
@13,2 say "Volume"
@15,2 say "Size"
@16,2 say "Block Size"
@17,2 say "Available Space"
@18,2 say "Max Dir Entries"
@19,2 say "Avail Dir Entries"
@ 5,20 to 19,20
@ 12,20 say chr(193)
@ 5,40 to 19,40
@ 12,40 say chr(193)
@ 5,60 to 19,60
@ 12,60 say chr(193)
@ 20,20 say chr(193)
@ 20,40 say chr(193)
@ 20,60 say chr(193)
for VolNum = 0 to 5
  if empty(VOLNMEGET(VolNum))
    exit
  endif
  x := 22+if(VolNum<3,(VolNum*20),(VolNum-3)*20)-if(VolNum = 2 .or. VolNum = 5,1,0)
  y := 5+if(VolNum<3,0,8)
  color(3)
  VolumeName := alltrim(left(VOLNMEGET(VolNum),15))
  @y,x   say space((17-len(VolumeName))/2)+VolumeName
  @y+2,x say padl(ltrim(transform(VOLBLKMAXGET(VolNum) * VOLBLKSIZGET(VolNum),"@z ###,###,###,###")),17)
  @y+3,x say padl(ltrim(transform(VOLBLKSIZGET(VolNum),"@z ###,###,###,###")),17)
  @y+5,x say padl(ltrim(transform(VOLDIRMAXGET(VolNum),"@z ###,###,###,###")),17)
next
MessPlace(2,.t.)
do while .t.
  color(2)
  @23,69 say "Checking."
  color(3)
  for VolNum = 0 to 5
    if empty(VOLNMEGET(VolNum))
      exit
    endif
    x := 22+(if(VolNum<3,VolNum,(VolNum-3))*20)-if(VolNum = 2 .or. VolNum = 5,1,0)
    y := 5+if(VolNum<3,0,8)
    @y+4,x say padl(ltrim(transform((VOLBLKFREGET(VolNum) * VOLBLKSIZGET(VolNum)) + (VOLBLKPURGET(VolNum) * VOLBLKSIZGET(VolNum)),"@z ###,###,###,###")),17)
    @y+6,x say padl(ltrim(transform(VOLDIRFREGET(VolNum),"@z ###,###,###,###")),17)
  next
  color(2)
  @23,69 say "         "
  color(3)
  if inkey(1) != 0
    exit
  endif
enddo
restscreen(4,0,21,79,screen1)
RETURN NIL

FUNCTION QInfo
LOCAL QID,Jobs[100],JobCount,CurrJob,JobChoice,JobNumber,QScr
LOCAL CurrQueue,Queues[100],QueueChoice,screen1,screen2
UserTitle()
ExpBox(6,27,18,53,"Available Topics",.t.,.f.)
MessPlace(1)
CurrQueue := 1
if !empty(Queues[CurrQueue++] := FSOBJLST("*",OT_PRINT_QUEUE, .T.))
  do while !(empty(Queues[CurrQueue] := FSOBJLST("",OT_PRINT_QUEUE, .F.)))
    CurrQueue++
  enddo
endif
if CurrQueue > 1
  asort(Queues,1,CurrQueue-1)
endif
screen1 := savescreen(4,5,20,35)
ExpBox(4,5,20,35," Print Queues ",.t.)
do while .t.
  ExpBox(4,5,20,35," Print Queues ",.t.,.t.)
  MessPlace(3)
  color(3)
  if (QueueChoice := achoice(7,8,19,34,Queues)) == 0
    exit
  else
    QID := QUEIDGET(alltrim(Queues[QueueChoice]))
    screen2 := savescreen(4,0,21,79)
    ExpBox(4,0,21,79,"Seq User            Description                                  Status Job",.t.)
    MessPlace(1)
    if (JobCount := min(QUEQJBLST(QID, .T.),100)) > 0
      for CurrJob = 1 to JobCount
        JobNumber := QUEQJBLST(QID, .F.)
        Jobs[CurrJob] := padl(str(CurrJob,3),3)+" "+padr(left(USRNAMEGET(QJBUSRIDGET(QID,JobNumber)),15),15)+" "+padr(left(QJBDSCGET(QID,JobNumber),42),42)+" "+if(QJBADDTST(QID,JobNumber),"Adding","Ready ")+" "+str(JobNumber,5)
      next
      do while .t.
        color(1)
        MessPlace(3)
        color(3)
        @7,2 to 20,2
        if (JobChoice := achoice(7,3,20,78,Jobs)) == 0
          exit
        else
          QScr := savescreen(4,0,21,79)
          ExpBox(4,0,21,79,"Print Queue Entry Information",.t.)
          CurrJob := val(right(Jobs[JobChoice],5))
          color(1)
          @7,4  say "Print Job"
          @9,4 say "User"
          @10,4 say "Connection Number"
          @11,4 say "Description"
          @12,4 say "Status"
          @14,4 say "User Hold"
          @15,4 say "Operator Hold"
          @16,4 say "Service Sequence"
          @18,4 say "Defer Printing"
          @7,45 say "File Size"
          @14,45 say "Job Entry Date"
          @15,45 say "Job Entry Time"
          @16,45 say "Job File Name"
          @18,45 say "Target Date"
          @19,45 say "Target Time"
          color(3)
          @7,23 say ltrim(str(CurrJob))
          @9,23 say trim(substr(USRNAMEGET(QJBUSRIDGET(QID,CurrJob)),1,35))
          @10,23 say ltrim(str(QJBWSGET(QID,CurrJob)))
          @11,23 say QJBDSCGET(QID,JobNumber)
          @12,23 say if(QJBADDTST(QID,JobNumber),"Adding","Ready ")
          @14,23 say if(QJBUSRHLDGET(QID,JobNumber),"Yes","No")
          @15,23 say if(QJBOPRHLDGET(QID,JobNumber),"Yes","No")
          @16,23 say ltrim(str(QJBPSNGET(QID,CurrJob)))
          @18,23 say if(empty(QJBDEFDTEGET(QID,JobNumber)),"No","Yes")
          @7,61 say ltrim(transform(QJBSIZEGET(QID,CurrJob),"###,###,###"))
          @14,61 say QJBDTEGET(QID,CurrJob)
          @15,61 say QJBTMEGET(QID,CurrJob)
          @16,61 say QJBFILNMEGET(QID,CurrJob)
          @18,61 say if(empty(QJBDEFDTEGET(QID,JobNumber)),"",QJBDEFDTEGET(QID,JobNumber))
          @19,61 say if(empty(QJBDEFDTEGET(QID,JobNumber)),"",QJBDEFTMEGET(QID,JobNumber))
          MessPlace(2)
        endif
      restscreen(4,0,21,79,Qscr)
      enddo
    else
      MessPlace(2)
    endif
    restscreen(4,0,21,79,screen2)
  endif
enddo
restscreen(4,5,20,35,screen1)
RETURN NIL


FUNCTION Message
LOCAL MsgChoice,MsgText,screen1,screen1_1,UserNo,Connection,UserChoice,Users[100],screen2
UserTitle()
ExpBox(6,27,18,53,"Available Topics",.t.,.f.)
screen1 := savescreen(6,9,10,39)
@ 6,9 clear to 10,39
do while .t.
  color(1)
  @ 6,9 to 10,39 double
  MessPlace(3)
  color(3)
  @7,10 prompt  " 1 - Send Message to Console "
  @8,10 prompt  " 2 - Send Message to User    "
  @9,10 prompt  " 3 - Log Network Message     "
  menu to MsgChoice
  color(3)
  @ 6,9 to 10,39 double
  screen1_1 := savescreen(6,9,10,39)
  do case
    case lastkey() = 27
      exit
    case MsgChoice = 1
      if !empty(MsgText := MsgTxt())
        FSMSGSND(trim(MsgText))
      endif
    case MsgChoice = 2
      screen2 := savescreen(4,5,21,42)
      MessPlace(1)
      UserNo := 1
      for Connection = 1 to 100
        if !empty(WSLOGNMEGET(Connection))
          Users[UserNo++] = padr(WSLOGNMEGET(Connection),28," ")+str(Connection,3)
        endif
      next
      Expbox(4,5,21,42,"Current Connections",.t.)
      MessPlace(3)
      color(3)
      if (UserChoice := achoice(7,8,20,41,Users)) != 0
        if !empty(MsgText := MsgTxt())
          WSMSGSND(val(alltrim(right(Users[UserChoice],5))),trim(MsgText))
        endif
     endif
     restscreen(4,5,21,42,screen2)
    case MsgChoice = 3
      if !empty(MsgText := MsgTxt())
        FSMSGLOG(trim(MsgText))
      endif
  endcase
  restscreen(6,9,10,39,screen1_1)
enddo
restscreen(6,9,10,39,screen1)
return NIL

FUNCTION FuncTest
LOCAL FuncName,OldFunc,screen1
UserTitle()
MessPlace(4)
set cursor on
screen1 := savescreen(4,0,21,79)
@ 4,0 clear to 21,79
color(1)
@4,0 to 9,79 double
set color to "w+/b,w/b"
do while .t.
  @5,2 say "Last Command:"
  @6,2 say "Return Value:"
  @7,2 say " Output Type:"
  @8,2 say "     NWERRORGET:"
  FuncName := space(70)
  @21,0 say "NL>" get FuncName
  clear typeahead
  read
  @ 5,1 clear to 8,78
  if lastkey() == 27
    exit
  elseif FuncName != " "
    if !type(alltrim(FuncName)) == "UI"
      scroll(10,0,21,79,1)
      @21,0 say "NL> Invalid Function"
    else
      RetVal = &FuncName
      @5,16 say left(FuncName,60)
      @6,16 say RetVal
      @7,16 say type("RetVal")
      @8,16 say ltrim(str(NWERRORGET()))
    endif
  endif
  OldFunc := FuncName
  scroll(10,0,21,79,1)
enddo
restscreen(4,0,21,79,screen1)
set cursor off
return NIL


FUNCTION MessPlace()

PARAMETERS MessNum,WaitForIt
LOCAL MessOpt := { {"Please wait......",""},;
                   {"Press any key to continue......",""},;
                   {chr(24)+chr(25)+" Move Cursor   "+chr(17)+"Ù Select Option","Esc=Exit"},;
                   {"Enter a valid Novlib Function","Esc=Exit"},;
                   {"Move Text","Esc=Exit"}}

color(2)
@23,1 clear to 23,77
@23,2 say MessOpt[MessNum][1]
@23,70 say MessOpt[MessNum][2]
if (MessNum == 2 ) .and. (type("WaitForIt") == "U")
  inkey(0)
endif
color(0)
return NIL


FUNCTION BackGnd
LOCAL i
color(2)
@ 0,0 clear to 3,79
@ 0,0 to 3,79
color(0)
for i = 4 to 21
  @ i,0 say replicate(chr(176),80)
next
color(2)
@ 22,0 clear to 24,79
@ 22,0 to 24,79
color(4)
@ 1,2 say "ASM Inc         ."
Promo()
color(2)
@ 1,38 say cdow(date())+" "+str(day(date()))+" "+cmonth(date())+" "+;
str(year(date()))
@ 1,68 say time()
color(0)
return NIL


FUNCTION title(cHeader)
color(2)
@ 2,10 clear to 2,70
@ 2,(80-len(cHeader))/2 say cHeader
color(0)
return NIL


FUNCTION UserTitle
title("User "+rtrim(substr(WSLOGNMEGET(),1,15))+" on Fileserver "+rtrim(substr(FSNMEGET(),1,15))+" Connection "+ltrim(str(WSCONNUMGET())))
return NIL


FUNCTION MsgTxt
LOCAL msgscrn := savescreen(19,10,21,71), Text :=space(49)
@ 19,10 clear to 21,71
color(1)
@ 19,10 to 21,71 double
color(0)
set(_SET_CURSOR,1)
@20,12 say "Message:" get Text
clear typeahead
read
set(_SET_CURSOR,0)
restscreen(19,10,21,71,msgscrn)
return(Text)


FUNCTION Color(m_color)
LOCAL colors := { ;
                  {"bg/b,b/w","w/n,n/w"},;
                  {"gr+/b,b/w","w+/n,n/w"},;
                  {"b/bg,b/w","n/w,w/n"},;
                  {"w+/b,b/w","w/n,n/w"},;
                  {"r/bg","n/w,w/n"},;
                }

set(_SET_COLOR,colors[m_color+1][if(iscolor(),1,2)])
return NIL


FUNCTION ExpBox()
PARAMETERS t,l,b,r,title,line,select
LOCAL height, width, t1, l1, b1, r1
color(1)
if type("select") = "U"
  height := b - t
  width := r - l
  t1 := t + (height / 2)
  l1 := l + (width / 2)
  b1 := b - (height / 2)
  r1 := r - (width / 2)
  DO WHILE t1-1 > t .OR. l1 > l
    @ t1,l1 CLEAR TO b1,r1
    @ t1,l1 TO b1,r1 DOUBLE
    IF t1-1 > t
      t1--
      b1++
    ENDIF
    IF l1 > l
      l1--
      r1++
    ENDIF
  ENDDO
  @ t,l clear to b,r
  if line
    color(3)
    @ t+3,l+2 to b-1,l+2
    color(1)
  endif
elseif (select == .f.)
  color(3)
endif
@ t,l to b,r double
@ t+2,l+1 to t+2,r-1 double
@ t+2,l say chr(204)
@ t+2,r say chr(185)
@ t+1,l+((r-l-len(title))/2) say title
return NIL

FUNCTION Promo()

LOCAL nFileHandle,nFileLen,cPromoText,nLenPointer

if file("PROMO.TXT")
  nFileHandle := fopen("PROMO.TXT")
  if ferror() == 0
    nFileLen := fseek(nFileHandle,0,2)
    fseek(nFileHandle,0)
    cPromoText := space(nFileLen)
    if fread(nFileHandle,@cPromoText,nFileLen) == nFileLen
      cPromoText := alltrim(strtran(cPromoText,chr(26)))
      nFileLen :=  len(cPromoText)
      nLenPointer := (80-nFileLen)/2
      @ 19,nLenPointer-1 to 21,nLenPointer+nFileLen
      @ 20,nLenPointer say cPromoText
    endif
    fclose(nFileHandle)
  endif
endif

return NIL

FUNCTION EFunc()
  LOCAL cOldColor := Setcolor()
  color(2)
  @ 1,68 say time()
  setcolor( cOldColor )
  return(NIL)

