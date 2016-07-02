
******************************************************************************
*                                                                            *
* DEMO.PRG  V1.21                                                            *
* NOVLIB Demonstration program                                               *
* (C) 1990,1991 ASM Inc         .  All Rights Reserved.                      *
*                                                                            *
******************************************************************************

parameters CmdLine
CmdLine = iif(type("CmdLine") = "U", "", CmdLine)
clear
set escape on
set scoreboard off
setcancel(.t.)
set cursor off
set date british
set confirm on
set bell off
set exclusive off
set deleted on
set wrap on

SysMaster = ( "MASTER" $ upper(CmdLine) )
BackGnd()
expwin(6,27,18,53,.f.)
do while .t.
  SelMsg()
  color(3)
  @ 9,30 prompt "Connection Information "
  @10,30 prompt "Change Current Server  "
  @11,30 prompt "User Information       "
  @12,30 prompt "Volume Information     "
  @13,30 prompt "Fileserver Information "
  @14,30 prompt "Printer Information    "
  @15,30 prompt "Print Queues           "
  @16,30 prompt "Messages               "
  @17,30 prompt "Function Test & Summary"
  @ 9,29 to 18,29
  color(1)
  box_1()
  color(0)
  title("NOVLIB Library Demonstration  V1.21")
  color(3)
  menu to menuchoice
  do case
    case MenuChoice = 0
      exit
    case MenuChoice = 1
      ConnInfo()
    case MenuChoice = 2
      ChangeFS()
    case MenuChoice = 3
      BindInfo()
    case MenuChoice = 4
      VolInfo()
    case MenuChoice = 5
      FSInfo()
    case MenuChoice = 6
      PrnInfo()
    case MenuChoice = 7
      QInfo()
    case MenuChoice = 8
      Message()
    case MenuChoice = 9
      FuncTest()
    otherwise
      tone(300,1)
      loop
  endcase
enddo
set color to
clear
set cursor on
RETURN


FUNCTION ConnInfo
private Users[100],ConnNum,UserNo,UserChoice,ArrayChoice
UserTitle()
color(3)
box_1()
screen1 = savescreen(4,5,21,42)
expwin(4,5,21,42,.f.)
color(1)
WaitMsg()
UserNo = 1
for ConnNum = 1 to 100
  if !empty(WSLOGNMEGET(ConnNum))
    Users[UserNo] = padr(WSLOGNMEGET(ConnNum),28," ")+str(ConnNum,3)
    UserNo = UserNo + 1
  endif
next
do while .t.
  color(1)
  box_2()
  SelMsg()
  color(3)
  @7,7 to 20,7
  UserChoice = achoice(7,8,20,41,Users)
  if UserChoice = 0
    exit
  else
    ConnNum = val(alltrim(right(Users[UserChoice],5)))
    box_2()
    screen2 = savescreen(9,43,18,79)
    expwin(9,43,18,79,.f.)
    color(1)
    @11,44 to 11,78 double
    @11,43 say chr(204)
    @11,79 say chr(185)
    @10,51 say "Connection Information"
    @12,45 say "Connection"
    @13,45 say "Login Name"
    @14,45 say "Login Date"
    @15,45 say "Login Time"
    @16,45 say "User ID"
    @17,45 say "Full Name"
    color(3)
    @12,56 say ltrim(str(ConnNum))
    @13,56 say substr(WSLOGNMEGET(ConnNum),1,15)
    @14,56 say WSLOGDTEGET(ConnNum)
    @15,56 say WSLOGTMEGET(ConnNum)
    @16,56 say ltrim(NOVSTRHEXGET(WSLOGIDGET(ConnNum)))
    @17,56 say substr(USRFULNMEGET(WSLOGNMEGET(ConnNum)),1,15)
    ContMsg()
    inkey(0)
    restscreen(9,43,18,79,screen2)
  endif
enddo
restscreen(4,5,21,42,screen1)
RETURN ""


FUNCTION ChangeFS
private Servers[8],ServerNo,NewServer
UserTitle()
color(3)
box_1()
screen1 = savescreen(7,14,18,66)
expwin(7,14,18,66,.f.)
color(1)
@9,15 to 9,65 double
@9,14 say chr(204)
@9,66 say chr(185)
@ 8,17 say "Fileserver              User Name"
WaitMsg()
ServerNo = 1
for ServerNo = 1 to 8
  FSPREFCONSET(ServerNo)
  if ServerNo=FSPREFCONGET()
     Servers[ServerNo] = padr(FSNMEGET(),24," ")+padr(WSLOGNMEGET(),24," ")
  endif
next
FSPREFCONSET(1)
SelMsg()
color(3)
@ 10,16 to 17,16
NewServer = achoice(10,17,17,65,Servers)
if NewServer != 0
  FSPREFNMESET(NewServer)
endif
restscreen(7,14,18,66,screen1)
return ""


FUNCTION FSInfo
UserTitle()
screen1 = savescreen(4,2,21,42)
color(3)
box_1()
color(1)
@4,2 clear to 21,42
@4,2 to 21,42 double
@6,3 to 6,41 double
@6,2 say chr(204)
@6,42 say chr(185)
@5,10 say "File Server Information"
@7,4 say "Name"
@8,4 say "NetWare Version"
@9,4 say "Netware Serial No"
@10,4 say "SFT Level"
@11,4 say "TTS Level"
@12,4 say "Connection ID"
@13,4 say "Network Number"
@14,4 say "Max Connections"
@15,4 say "Curr Connections"
@16,4 say "Peak Connections"
@17,4 say "Max Volumes"
@18,4 say "File Server Date"
@19,4 say "File Server Time"
@20,4 say "Login Enabled"
color(3)
@7,26 say substr(FSNMEGET(),1,15)
@8,26 say ltrim(NWVERNUMGET())
@9,26 say NWSERNUMGET()
@10,26 say ltrim(str(FSSFTLVLGET()))
@11,26 say ltrim(str(FSTTSLVLGET()))
@12,26 say ltrim(str(WSCONNUMGET()))
@13,26 say WSNETADRGET()
@14,26 say ltrim(str(FSCONMAXGET()))
@17,26 say ltrim(str(FSVOLMAXGET()))
ContMsg()
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
RETURN ""


FUNCTION BindInfo
private UserCount,CurrUser,Users[100],UserChoice,UserID,NextUser,SpaceAvail
UserTitle()
color(3)
box_1()
WaitMsg()
CurrUser = 1
Users[CurrUser] = FSOBJLST("*",1,.T.)
if !empty(Users[1])
  for CurrUser = 2 to 100
    NextUser = FSOBJLST("",1,.F.)
    if empty(NextUser)
      exit
    else
      Users[CurrUser] = NextUser
    endif
  next
endif
if CurrUser > 1
  asort(Users,1,CurrUser-1)
endif
screen1 = savescreen(4,5,20,35)
expwin(4,5,20,35,.f.)
do while .t.
  color(1)
  box_3()
  SelMsg()
  color(3)
  @7,7 to 19,7
  UserChoice = achoice(7,8,19,34,Users)
  color(1)
  if lastkey() = 27
    exit
  else
    screen2 = savescreen(7,36,18,79)
    color(3)
    box_3()
    expwin(7,36,18,79,.f.)
    WaitMsg()
    color(1)
    @ 9,37 to 9,78 double
    @ 9,36 say chr(204)
    @ 9,79 say chr(185)
    @ 8,49 say "User Information"
    UserID = USRIDGET(alltrim(Users[UserChoice]))
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
    @16,54 say ltrim(transform(USRDSKBLKGET(0,UserID) * 4096,"###,###,###"))
    SpaceAvail = USRDSKFREGET(UserID)
    @17,54 say iif(SpaceAvail = -255,"No Limit",ltrim(transform(SpaceAvail * 4096,"###,###,###")))
    ContMsg()
    inkey(0)
    restscreen(7,36,18,79,screen2)
  endif
enddo
restscreen(4,5,20,35,screen1)
RETURN ""


FUNCTION VolInfo
private UserChoice,VolNum,x,y
UserTitle()
screen1 = savescreen(4,0,21,79)
@ 4,0 clear to 21,79
color(1)
@4,0 to 21,79 double
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
VolNum = 0
do while .t.
  if empty(VOLNMEGET(VolNum))
    exit
  endif
  x = 22+if(VolNum<3,(VolNum*20),(VolNum-3)*20)-if(VolNum = 2 .or. VolNum = 5,1,0)
  y = 5+if(VolNum<3,0,8)
  color(3)
  VOLNME = alltrim(left(VOLNMEGET(VolNum),15))
  @y,x   say space((17-len(VOLNME))/2)+VOLNME
  @y+2,x say padl(ltrim(transform((VOLBLKMAXGET(VolNum) * VOLBLKSIZGET(VolNum))+(VOLBLKPURGET(VolNum) * VOLBLKSIZGET(VolNum)),"@z ###,###,###")),17)
  @y+3,x say padl(ltrim(transform(VOLBLKSIZGET(VolNum),"@z ###,###,###")),17)
  @y+5,x say padl(ltrim(transform(VOLDIRMAXGET(VolNum),"@z ###,###,###")),17)
  VolNum = VolNum+1
  if VolNum >5
    exit
  endif
enddo
ContMsg()
do while .t.
  color(2)
  @23,69 say "Checking."
  color(3)
  VolNum = 0
  do while .t.
    if empty(VOLNMEGET(VolNum)) .or. VolNum >5
      exit
    endif
    x = 22+if(VolNum<3,(VolNum*20),(VolNum-3)*20)-if(VolNum = 2 .or. VolNum = 5,1,0)
    y = 5+if(VolNum<3,0,8)
    @y+4,x say padl(ltrim(transform(VOLBLKFREGET(VolNum) * VOLBLKSIZGET(VolNum),"@z ###,###,###")),17)
    @y+6,x say padl(ltrim(transform(VOLDIRFREGET(VolNum),"@z ###,###,###")),17)
    VolNum = VolNum+1
  enddo
  color(2)
  @23,69 say "         "
  color(3)
  if inkey(1) != 0
    exit
  endif
enddo
restscreen(4,0,21,79,screen1)
RETURN ""


FUNCTION PrnInfo
private printnum,x,y
UserTitle()
color(3)
box_1()
screen1 = savescreen(4,2,20,42)
expwin(4,2,20,42,.f.)
color(1)
@6,3 to 6,41 double
@6,2 say chr(204)
@6,42 say chr(185)
@5,12 say "Printer Information"
@13,4 to 13,40
@7,22 to 19,22
@13,22 say chr(197)
@7,4 say "Printer 0"
@7,24 say "Printer 1"
@14,4 say "Printer 2"
@14,24 say "Printer 3"
ContMsg()
do while .t.
  color(2)
  @23,69 say "Checking."
  color(3)
  PrintNum = 0
  do while .t.
    if PrintNum >3
      exit
    endif
    x = 4+if(PrintNum<2,(PrintNum*20),(PrintNum-2)*20)
    y = 9+if(PrintNum<2,0,7)
    if FSPRNFRMGET(PrintNum) = -1
      @y,x say "Not Configured"
    else
      @y,x say iif(FSPRNSTPTST(0),"Halted","Running")
      @y+1,x say iif(FSPRNOFFTST(0),"Off","On") + "-line"
      @y+2,x say "Form " + ltrim(str(FSPRNFRMGET(0))) + " mounted"
    endif
    PrintNum=PrintNum+1
  enddo
  color(2)
  @23,69 say "         "
  color(3)
  if inkey(1) != 0
    exit
  endif
enddo
restscreen(4,2,20,42,screen1)
RETURN ""


FUNCTION QInfo
private QID,Jobs[100],JobCount,CurrJob,JobChoice,JobNumber,QScr
private QueueCount,CurrQueue,Queues[100],QueueChoice,NextQueue
UserTitle()
color(3)
box_1()
WaitMsg()
CurrQueue = 1
Queues[CurrQueue] = FSOBJLST("*",3,.T.)
if !empty(Queues[1])
  for CurrQueue = 2 to 100
    NextQueue = FSOBJLST("",3,.F.)
    if empty(NextQueue)
      exit
    else
      Queues[CurrQueue] = NextQueue
    endif
  next
endif
if CurrQueue > 1
  asort(Queues,1,CurrQueue-1)
endif
screen1 = savescreen(4,5,20,35)
expwin(4,5,20,35,.f.)
do while .t.
  color(1)
  box_3()
  @5,13 say " Print Queues "
  SelMsg()
  color(3)
  @7,7 to 19,7
  QueueChoice = achoice(7,8,19,34,Queues)
  if lastkey() = 27
    exit
  else
    QID = QUEIDGET(alltrim(Queues[QueueChoice]))
    screen2 = savescreen(4,0,21,79)
    box_4()
    @5,3 say "Seq User            Description                                  Status Job"
    WaitMsg()
    JobCount = min(QUEQJBLST(QID,.T.),100)
    if JobCount > 0
      for CurrJob = 1 to JobCount
        JobNumber = QUEQJBLST(QID,.F.)
        Jobs[CurrJob] = padl(str(CurrJob,3),3)+" "+padr(left(UsrNameGet(QJBUSRIDGET(QID,JobNumber)),15),15)+" "+padr(left(QJBDSCGET(QID,JobNumber),44),44)+" "+if(QJBADDTST(QID,JobNumber),"Adding","Ready ")+" "+str(JobNumber,3)
      next
      do while .t.
        color(1)
        selmsg()
        color(3)
        @7,2 to 20,2
        JobChoice = achoice(7,3,20,78,Jobs)
        color(0)
        if lastkey() = 27
          exit
        else
          QScr = savescreen(4,0,21,79)
          box_4()
          @5,24 say "Print Queue Entry Information"
          CurrJob = val(right(Jobs[JobChoice],3))
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
          @9,23 say trim(substr(UsrNameGet(QJBUSRIDGET(QID,CurrJob)),1,35))
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
          ContMsg()
          inkey(0)
        endif
      restscreen(4,0,21,79,Qscr)
      enddo
    else
      ContMsg()
      inkey(0)
    endif
    restscreen(4,0,21,79,screen2)
  endif
enddo
restscreen(4,5,20,35,screen1)
RETURN ""


FUNCTION Message
private MsgChoice,MsgText
UserTitle()
color(3)
box_1()
screen1 = savescreen(6,9,10,39)
expwin(6,9,10,39,.f.)
do while .t.
  color(1)
  @ 6,9 to 10,39 double
  selmsg()
  color(3)
  @7,10 prompt  " 1 - Send Message to Console "
  @8,10 prompt  " 2 - Send Message to User    "
  @9,10 prompt  " 3 - Log Network Message     "
  menu to MsgChoice
  color(3)
  @ 6,9 to 10,39 double
  screen1_1 = savescreen(6,9,10,39)
  do case
    case lastkey() = 27
      exit
    case MsgChoice = 1
      MsgText = MsgTxt()
      if !empty(MsgText)
        FSMSGSND(trim(MsgText))
      endif
    case MsgChoice = 2
      private UserNo,ConnNum,UserChoice,Users[100]
      screen2 = savescreen(4,5,21,42)
      WaitMsg()
      UserNo = 1
      for ConnNum = 1 to 100
        if !empty(WSLOGNMEGET(ConnNum))
          Users[UserNo] = padr(WSLOGNMEGET(ConnNum),28," ")+str(ConnNum,3)
          UserNo = UserNo + 1
        endif
      next
      expwin(4,5,21,42,.f.)
      color(1)
      box_2()
      SelMsg()
      color(3)
      @7,7 to 20,7
      UserChoice = achoice(7,8,20,41,Users)
      if UserChoice != 0
        MsgText = MsgTxt()
        if !empty(MsgText)
          WSMSGSND(val(alltrim(right(Users[UserChoice],5))),trim(MsgText))
        endif
     endif
     restscreen(4,5,21,42,screen2)
    case MsgChoice = 3
      MsgText = msgtxt()
      if !empty(MsgText)
        FSMSGLOG(trim(MsgText))
      endif
    otherwise
      tone(300,1)
      loop
  endcase
  restscreen(6,9,10,39,screen1_1)
enddo
restscreen(6,9,10,39,screen1)
RETURN ""


FUNCTION FuncTest
Private FuncName
UserTitle()
PromptMsg()
set cursor on
screen1 = savescreen(4,0,21,79)
@ 4,0 clear to 21,79
color(1)
@4,0 to 9,79 double
set color to "w+/b,w/b"
do while .t.
  @5,2 say "Last Command:"
  @6,2 say "Return Value:"
  @7,2 say " Output Type:"
  @8,2 say "     NWERRORGET:"
  FuncName = space(70)
  @21,0 say "NL>" get FuncName
  clear typeahead
  read
  @ 5,1 clear to 8,78
  if lastkey() = 27
    exit
  elseif FuncName # " "
    RetVal = &FuncName
    @5,16 say left(FuncName,60)
    @6,16 say RetVal
    @7,16 say type("RetVal")
    @8,16 say ltrim(str(NWERRORGET()))
  endif
  OldFunc = FuncName
  scroll(10,0,21,79,1)
enddo
restscreen(4,0,21,79,screen1)
set cursor off
return ""


FUNCTION WaitMsg
color(2)
@23,1 clear to 23,77
@23,2 say "Please wait......"
color(0)
RETURN ""


FUNCTION ContMsg
color(2)
@23,1 clear to 23,77
@23,2 say "Press any key to continue......"
color(0)
RETURN ""


FUNCTION SelMsg
color(2)
@23,1 clear to 23,77
@23,2 say chr(24)+chr(25) + " Move Cursor   " + chr(17) + "Ù Select Option"
@23,70 say "Esc=Exit"
color(0)
RETURN ""


FUNCTION PromptMsg
color(2)
@23,1 clear to 23,77
@23,2 say "Enter a valid Novlib Function"
@23,70 say "Esc=Exit"
color(0)
return ""

FUNCTION BackGnd
color(2)
@ 0,0 clear to 3,79
@ 0,0 to 3,79
color(0)
for i = 4 to 21
  @ i,0 say replicate(chr(176),80)              && this is because Clipper 5 won't wrap an @ SAY REPLICATE
next
color(2)
@ 22,0 clear to 24,79
@ 22,0 to 24,79
color(4)
@ 1,2 say "ASM Inc         ."
color(2)
@ 1,38 say cdow(date())+" "+str(day(date()))+" "+cmonth(date())+" "+;
str(year(date()))
@ 1,68 say time()
color(0)
return ""


FUNCTION ExpWin
PARAMETERS m_bwt,m_bwl,m_bwb,m_bwr,m_shadow
height = m_bwb - m_bwt
width = m_bwr - m_bwl
m_bwt1 = m_bwt + (height / 2)
m_bwl1 = m_bwl + (width / 2)
m_bwb1 = m_bwb - (height / 2)
m_bwr1 = m_bwr - (width / 2)
DO WHILE m_bwt1-1 > m_bwt .OR. m_bwl1 > m_bwl
  @ m_bwt1,m_bwl1 CLEAR TO m_bwb1,m_bwr1
  @ m_bwt1,m_bwl1 TO m_bwb1,m_bwr1 DOUBLE
  IF m_bwt1-1 > m_bwt
    m_bwt1 = m_bwt1 - 1
    m_bwb1 = m_bwb1 + 1
  ENDIF
  IF m_bwl1 > m_bwl
    m_bwl1 = m_bwl1 - 1
    m_bwr1 = m_bwr1 + 1
  ENDIF
ENDDO
if m_shadow
  @ m_bwt+1,m_bwl+1 clear to m_bwb+1,m_bwr+1
endif
@ m_bwt,m_bwl clear to m_bwb,m_bwr
color(1)
@ m_bwt,m_bwl to m_bwb,m_bwr double
color(0)
RETURN .T.


FUNCTION title
parameters m_header
color(2)
@ 2,10 clear to 2,70
@ 2,(80-len(m_header))/2 say m_header
color(0)
return .t.


FUNCTION UserTitle
title("User "+rtrim(substr(WSLOGNMEGET(),1,15))+" on Fileserver "+rtrim(substr(FSNMEGET(),1,15))+" Connection "+ltrim(str(WSCONNUMGET())))
return .t.


FUNCTION MsgTxt
msgscrn = savescreen(19,10,21,71)
@ 19,10 clear to 21,71
color(1)
@ 19,10 to 21,71 double
color(0)
Text = space(49)
set cursor on
@20,12 say "Message:" get Text
clear typeahead
read
set cursor off
restscreen(19,10,21,71,msgscrn)
return(Text)


FUNCTION Color
parameters m_color
do case
  case m_color = 0
    if iscolor()
      set color to "bg/b,b/w"
    else
      set color to
    endif
  case m_color = 1
    if iscolor()
      set color to "gr+/b,b/w"
    else
      set color to "w+/n"
    endif
  case m_color = 2
     if iscolor()
       set color to "b/bg,b/w"
     else
       set color to "I"
     endif
  case m_color = 3
     if iscolor()
       set color to "w+/b,b/w"
     else
       set color to
     endif
  case m_color = 4
     if iscolor()
       set color to "r/bg"
     else
       set color to "I"
     endif
endcase
return ""


FUNCTION box_1
@ 6,27 to 18,53 double
@ 8,27 say chr(204)
@ 8,53 say chr(185)
@ 8,28 to 8,52 double
@ 7, 32 say "Available Topics"
return ""


FUNCTION box_2
@4,5 to 21,42 double
@6,5 say chr(204)
@6,42 say chr(185)
@6,6 to 6,41 double
@5,15 say "Current Connections"
return ""


FUNCTION box_3
@4,5 to 20,35 double
@6,5 say chr(204)
@6,35 say chr(185)
@6,6 to 6,34 double
@5,15 say "User Name"
return ""


FUNCTION box_4
expwin(4,0,21,79,.f.)
color(1)
@6,1 to 6,78 double
@6,0 say chr(204)
@6,79 say chr(185)
return ""

FUNCTION Padr
PARAMETERS InString, InLen, InChar
RETURN SUBSTR( InString + SPACE(InLen), 1, InLen )

FUNCTION Padl
PARAMETERS InString, InLen, InChar
RETURN SUBSTR( SPACE(InLen) + InString, -InLen, InLen )

