*********** Sample programs for CA-Clipper Tools / 5.2 ************
*
* Program     : BIORTHM.PRG
* Copyright   : (c) 1992-93, Computer Associates International.
*               All rights reserved.
* Date        : 01/20/92
* Author      : Ralf Saborowski
* Description : Novell look and feel like utility, that shows some
*               of the Novell Netware support of CA-Clipper Tools.
*               Compile and enjoy....
* Compiling   : CLIPPER CA-CON /n
* Linking     : RTLINK FI CA-CON,CTUS LIB CT
*
*******************************************************************
#include "box.ch"
#include "inkey.ch"
#include "achoice.ch"

#include "ctnnet.ch"

STATIC aTypes:={  'Wild',;
                  'Unkown',;
                  'User',;
                  'Group',;
                  'Print-Queue',;
                  'File-Server',;
                  'Job-Server  ',;
                  'Gateway',;
                  'Print-Server',;
                  'Archive-Queue',;
                  'Archive-Server',;
                  'Job-Queue',;
                  'Admin',;
                  'Bridge-Server',;
                  'Adv. Print-Server'  }
STATIC aTypeCodes:={OBJ_WILD,;
                    OBJ_UNKNOWN,;
                    OBJ_USER,;
                    OBJ_GROUP,;
                    OBJ_PRINTQUEUE,;
                    OBJ_FILESERVER,;
                    OBJ_JOBSERVER,;
                    OBJ_GATEWAY,;
                    OBJ_PRINTSERVER,;
                    OBJ_ARCHIVEQUEUE,;
                    OBJ_ARCHIVESERVER,;
                    OBJ_JOBQUEUE,;
                    OBJ_ADMIN,;
                    OBJ_BRIDGESERVER,;
                    OBJ_ADVPRINTSERVER }
MEMVAR GetList

FUNCTION MAIN()
LOCAL aMenue:={'Server-List',;
              'Att. Server-List',;
              'Login',;
              'Logout from Server',;
              'Logout all',;
              'Attach',;
              'Dettach',;
              'Users',;
              'Logged Users',;
              'Groups',;
              'Drive Mappings',;
              'Bindery-Info',;
              'Send Message',;
              'Message Buffer',;
              'Print Queues',;
              'End'  }
LOCAL nChoice:=1,c

// Init message buffer
// 25 messages should be enough
NNETMSGOPN(25)

SET DATE GERMAN
SET SCOREBOARD OFF
SETCOLOR('BG+/B')
SET CURSOR OFF

CLS
@ 0,0 SAY 'CA-Clipper Tools CA-Con 1.0'
@ 1,0 SAY 'Copyright (c) 1992-93 Computer Associates International.'
@ 2,0 SAY 'All Rights Reserved'
MILLISEC(2000)
SET CURSOR ON


SETCOLOR('W+/B,B/W')
CLEARWIN(0,0,MAXROW(),MAXCOL(),'BG/B','±')
@ 0,0,3,MAXCOL() BOX B_SINGLE+' ' COLOR 'B/BG'

@ 1,2 SAY 'CA-Clipper Tools CA-Con, Sabo 1992' COLOR 'B/BG'
c=CDOW(DATE())+STR(DAY(DATE()),3)+' '+CMONTH(DATE())+STR(YEAR(DATE()),5)
@ 1,MAXCOL()-LEN(c)-8 SAY c COLOR 'B/BG'

SHOWTIME(1,MAXCOL()-6,.T.,'B/BG')


WHILE nChoice!=0

  status()

  frame(6,26,17,53,'Main Menu','RG+/B',.T.,.F.)
  nChoice:=achoice(9,29,16,52,aMenue)
  frame(6,26,17,53,'Main Menu','W+/B',.F.,.F.)

  DO CASE
    CASE nChoice=1
       slist(.t.)
       slist(.F.)
    CASE nChoice=2
       attlist(.t.)
       attlist(.f.)
    CASE nChoice=3
       login()
    CASE nChoice=4
       logoutserv()
    CASE nChoice=5
       nnetlogout(.T.)
    CASE nChoice=6
      attach()
    CASE nChoice=7
      detach()
    CASE nChoice=8
      user(1,.T.,.T.)
      user(1,.T.,.F.)
    CASE nChoice=9
      user(2,.T.,.T.)
      user(2,.T.,.F.)
    CASE nChoice=10
      user(3,.T.,.T.)
      user(3,.T.,.F.)
    CASE nChoice=11
      map()
    CASE nChoice=12
      bindery()
    CASE nChoice=13
      send()
    CASE nChoice=14
      msgBuffer()
    CASE nChoice=15
      suzi_q()
    CASE nChoice=LEN(aMenue) .OR. nChoice=0
      IF YesNo('Exit CA-CON',2)
        nChoice=0
      ELSE
        nChoice=1
      ENDIF
  ENDCASE

ENDDO
SHOWTIME()
NNETMSGCLO()
RETURN(NIL)

FUNCTION slist(lMode)
  LOCAL aServer:=NNETFSLST()
  LOCAL nOut
  STATIC hwnd:=0

  IF lMode
    IF hwnd==0
      hwnd=WOPEN(6,6,22,31)
      SETBOXGROW(10)
    ENDIF
    frame(0,0,MAXROW(),MAXCOL(),'Visible Servers','RG+/B',.T.,.T.)
    nOut:=ACHOICE(3,3,MAXROW()-1,MAXCOL()-3,aServer)
    frame(0,0,MAXROW(),MAXCOL(),'Visible Servers','W+/B',.F.,.T.)
    SETBOXGROW(0)
  ELSE
    MYWCLOSE(hwnd)
    hwnd:=nOut:=0
  ENDIF
RETURN(IF(nOut>0,aServer[nOut],''))

FUNCTION attlist(lMode)
  LOCAL nOut
  LOCAL aServer:={},cServer:=NNETSLIST()
  STATIC hwnd:=0,cOldServer

  IF lMode
    TOKENINIT(@cServer,CHR(10)+CHR(13))

    WHILE !TOKENEND()
      AADD(aServer,TOKENNEXT(cServer))
    ENDDO

    IF hwnd==0
      SETBOXGROW(10)
      hwnd=WOPEN(6,6,22,31)
      cOldServer=NNETSNAME()
    ENDIF
    frame(0,0,MAXROW(),MAXCOL(),'Attached Servers','RG+/B',.T.,.T.)
    nOut:=ACHOICE(3,3,MAXROW()-1,MAXCOL()-3,aServer)
    frame(0,0,MAXROW(),MAXCOL(),'Attached Servers','W+/B',.F.,.T.)
    SETBOXGROW(0)
    IF nOut>0
      NNETSETSRV(aServer[nOut])
    ENDIF

  ELSE
    MYWCLOSE(hwnd)
    hwnd:=nOut:=0
    NNETSETSRV(cOldServer)
  ENDIF

RETURN(IF(nOut>0,aServer[nOut],''))

FUNCTION login()
  LOCAL lSuccess:=.F.
  LOCAL cUserName,cPassword,cServer,hwnd

  WHILE !EMPTY(cServer:=slist(.T.))
    hwnd=WOPEN(8,11,16,53)
    winframe('Login')

    cUserName:=cPassword:=SPACE(20)
    @ 4,3 SAY 'User Name    :' GET cUserName PICTURE '@!'
    @ 6,3 SAY 'Password     :' GET cPassword PICTURE '@!';
                               COLOR 'W/W,W/W'
    READ

    IF NNETLOGIN(TRIM(cUserName),TRIM(cPassword),cServer)>0
      myAlert('Login successful!')
      lSuccess=.T.
      status()
    ELSE
      myAlert('Login failed')
    ENDIF

    MYWCLOSE(hwnd)
  ENDDO
  slist(.F.)

RETURN(lSuccess)

FUNCTION logoutserv()
  LOCAL lSuccess
  LOCAL cServer

  WHILE !EMPTY(cServer:=attlist(.T.))
    IF (lSuccess:=NNETLOGOUT(cServer,.T.))
      myAlert('Logout successful!')
      status()
    ELSE
      myAlert('Logout failed!')
    ENDIF
  ENDDO
  attlist(.F.)
RETURN(.F.)

FUNCTION attach()
  LOCAL nConId:=0
  LOCAL cServer

  WHILE !EMPTY(cServer:=slist(.T.))
    nConId:=NNETATTACH(cServer)
    myAlert('Connection-Id:'+STR(nConId,2))
    status()
  ENDDO
  slist(.F.)
RETURN(nConId)

FUNCTION detach()
  LOCAL lSuccess
  LOCAL cServer
  LOCAL cOldServer:=NNETSNAME()

  WHILE !EMPTY(cServer:=attlist(.T.))
    NNETSETSRV(cOldServer)
    IF (lSuccess:=NNETLOGOUT(cServer))
      myAlert('Detach successful!')
      status()
    ELSE
      myAlert('Detach failed!')
    ENDIF
  ENDDO
  attlist(.F.)
RETURN(lSuccess)

//  moden=1    existing users
//  mode=2    logged users
//  mode=3    existing user groups
FUNCTION user(mode,lEdit,lStat)
  LOCAL nOut:=0,nChoice,cBenutzer,i,lSuccess,nZeile
  LOCAL aList
  LOCAL hwndChild
  LOCAL cTitel:=CHOOSE(mode-1,'Users',;
                              'Logged Users',;
                              'Groups')
  LOCAL aSubMenu
  STATIC hwnd:=0,cServer

  IF lStat
    IF hwnd=0
      cServer:=attlist(.T.)
    ELSE
      cServer:=NNETSNAME()
    ENDIF
    WHILE !EMPTY(cServer)
      IF hwnd=0
        SETBOXGROW(10)
        hwnd=WOPEN(6,43,19,75)
      ENDIF
      frame(0,0,MAXROW(),MAXCOL(),cTitel,'RG+/B',.T.,.F.)
      SETBOXGROW(0)

      BuildUserA(@aList,mode,cServer)

      WHILE .T.
        frame(0,0,MAXROW(),MAXCOL(),cTitel,'RG+/B',.T.,.F.)

        nOut:=ACHOICE(3,3,MAXROW()-1,MAXCOL()-1,aList,.T.,'LSTUDF')
        frame(0,0,MAXROW(),MAXCOL(),cTitel,'W+/B',.F.,.F.)

        IF lEdit .AND. mode!=2

          DO CASE
            CASE LASTKEY()=K_DEL .AND. !EMPTY(aList[nOut])
              IF YesNo('Delete '+aList[nOut]+'?',2)
                IF !NNETDELOBJ(aList[nOut],IF(mode<3,OBJ_USER,OBJ_GROUP))
                  MyAlert(IF(mode=3,'Group','User')+;
                          'cannot be deleted!')
                ELSE
                  ADEL(aList,nOut)
                  ASIZE(aList,LEN(aList)-1)
                ENDIF
              ENDIF
            CASE LASTKEY()=K_INS
              hwndChild=WOPEN(12,6,14,66)
              CLS
              SETCOLOR('RG+/B')
              @ 0,0 TO MAXROW(),MAXCOL() DOUBLE
              cBenutzer=SPACE(47)
              @ 1,2 SAY IF(mode=3,'Group:','User:') GET cBenutzer;
                        PICTURE '@!'
              READ
              SETCOLOR('W+/B')
              IF LASTKEY()!=K_ESC
                IF mode=3
                  lSuccess=NNETCRTGRP(TRIM(cBenutzer))
                ELSE
                  lSuccess=NNETCRTUSR(TRIM(cBenutzer))
                ENDIF
                IF !lSuccess
                  MyAlert(IF(mode=3,'Group','User')+;
                          'cannot be created!')
                ELSE
                  BuildUserA(@aList,mode,cServer)
                ENDIF
              ENDIF
              MYWCLOSE(hwndChild)
            CASE LASTKEY()=K_RETURN .AND. !EMPTY(aList[nOut])
              IF mode=3
                aSubMenu={'Members',;
                          'Trustees',;
                          'Full Name'}
              ELSE
                aSubMenu={'Groups',;
                         'Password',;
                         'Security',;
                         'Trustees',;
                         'Full Name',;
                         'Add. Infos',;
                         'Account details'}
              ENDIF
              hwndChild=WOPEN(8,8,23,33)
              SETBOXGROW(10)
              WHILE .T.
                frame(0,0,MAXROW(),MAXCOL(),'Options ('+;
                      aList[nOut]+')','RG+/B',.T.,.F.)
                SETBOXGROW(0)

                nChoice:=ACHOICE(3,3,MAXROW()-1,MAXCOL()-1,aSubMenu)

                frame(0,0,MAXROW(),MAXCOL(),'Options ('+;
                      aList[nOut]+')','W+/B',.F.,.F.)
                IF nChoice>0
                  IF mode<3
                    DO CASE
                      CASE nChoice=1
                        GroupsImIn(aList[nOut],1)
                      CASE nChoice=2
                        Password(aList[nOut])
                      CASE nChoice=3
                        Security(aList[nOut],OBJ_USER)
                      CASE nChoice=4
                        trustees(aList[nOut],OBJ_USER)
                      CASE nChoice=5
                        Ident(aList[nOut],OBJ_USER)
                      CASE nChoice=6
                        SET CENTURY ON
                        SETCOLOR('RG+/B')
                        WOPEN(18,20,IF(NNETVER()<'3',24,23),79)
                        WBOX(1)
                        @ 0,0 SAY 'Last Login:'
                        @ 1,0 SAY 'File Server Console Operator:'
                        nZeile=2
                        IF NNETVER()<'3'
                          @ 2,0 SAY 'Maximum drive space:'
                          nZeile=3
                        ENDIF
                        @ nZeile,0 SAY 'Used drive space:'
                        @ nZeile+1,0 SAY 'User ID:'
                        SETCOLOR('W+/B')
                        @ 0,30 SAY DMY(LastLogDate(aList[nOut]),.T.)+;
                                   '   '+LastLogTime(aList[nOut])
                        @ 1,30 SAY 'NNETCOPRIV()???'
                        IF NNETVER()<'3'
                          IF (i:=MaxSpace(aList[nOut]))=-1
                            @ 2,30 SAY 'unlimited'
                          ELSE
                            @ 2,30 SAY TRIM(TRANSFORM(i,'@BE 999,999,999'))+;
                              ' kBytes'
                          ENDIF
                        ENDIF
                        @ nZeile,30 SAY TRIM(TRANSFORM(;
                          NNETDSKUSE(aList[nOut]),'@BE 999,999,999'))+;
                          ' kBytes'
                        @ nZeile+1,30 SAY NNETUSERID(aList[nOut])
                        SET CURSOR OFF
                        INKEY(0)
                        SET CURSOR ON
                        WCLOSE()
                        SETCOLOR('W+/B')
                        SET CENTURY OFF
                      CASE nChoice=7
                        accRest(aList[nOut])
                    ENDCASE
                  ELSE
                    DO CASE
                      CASE nChoice=1
                        GroupsImIn(aList[nOut],2)
                      CASE nChoice=2
                        trustees(aList[nOut],OBJ_GROUP)
                      CASE nChoice=3
                        Ident(aList[nOut],OBJ_GROUP)
                    ENDCASE
                  ENDIF
                ELSE
                  EXIT
                ENDIF
              ENDDO
              MYWCLOSE(hwndChild)
            OTHERWISE
              EXIT
          ENDCASE

        ELSE
          EXIT
        ENDIF
      ENDDO
      frame(0,0,MAXROW(),MAXCOL(),cTitel,'W+/B',.T.,.F.)
      IF nOut=0
        MYWCLOSE(hwnd)
        hwnd:=0
        cServer:=attlist(.T.)
      ELSE
        EXIT
      ENDIF
    ENDDO
  ELSE
    MYWCLOSE(hwnd)
    attlist(.F.)
    hwnd:=nOut:=0
  ENDIF
RETURN(IF(nOut=0,'',aList[nOut]))

FUNCTION BuildUserA(aList,mode,cServer)
  DO CASE
    CASE mode=1
      aList:=NNETUSERS(cServer)
    CASE mode=2
      aList:=NNETLGUSER(cServer)
    CASE mode=3
      aList:=NNETGROUPS(cServer)
  ENDCASE
  IF LEN(aList)=0
    aList={' '}
  ELSE
    ASORT(aList)
  ENDIF
RETURN(NIL)

FUNCTION map()
  LOCAL nOut:=1
  LOCAL hwnd:=WOPEN(8,11,19,69),hwndChild
  LOCAL aList:={}
  LOCAL cDrive,cPath,cFake,cTemp,cIns

  SETBOXGROW(10)
  frame(0,0,MAXROW(),MAXCOL(),PADR(' Drive'+SPACE(21)+'Path',48),;
        'RG+/B',.T.,.F.)
  SETBOXGROW(0)

  BuildMapArray(@aList)

  SETLASTKEY(0)
  WHILE .T.
    frame(0,0,MAXROW(),MAXCOL(),PADR(' Drive'+SPACE(21)+'Path',48),;
          'RG+/B',.T.,.F.)
    @ 3,13 TO MAXROW()-1,13
    nOut:=ACHOICE(3,3,MAXROW()-1,MAXCOL()-1,aList,.T.,'LSTUDF')
    frame(0,0,MAXROW(),MAXCOL(),PADR(' Drive'+SPACE(21)+'Path',48),;
          'W+/B',.T.,.F.)

    DO CASE
      CASE LASTKEY()=K_DEL
        NNETMAP(TOKEN(aList[nOut],':',1))
        // Rebuild array completly since search drive
        // might disappear
        BuildMapArray(@aList)

      CASE LASTKEY()=K_INS
        hwndChild=WOPEN(8,6,18,60)
        winframe('Map drive')

        cDrive=PADR(NNETNXTFRE(),4);cPath=SPACE(255);cFake:=cTemp:=cIns:='N'
        @ 4,3  SAY 'Drive    :' GET cDrive PICTURE '@!'
        @ 6,3  SAY 'Path     :' GET cPath PICTURE '@S40'
        @ 8,3  SAY 'Fake Root:' GET cFake PICTURE '!' VALID cFake$'YN'
        @ 8,20 SAY 'Temp    :' GET cTemp PICTURE '!' VALID cTemp$'YN'
        @ 8,36 SAY 'Insert  :' GET cIns PICTURE '!' VALID cIns$'YN'
        READ

        MYWCLOSE(hwndChild)

        IF LASTKEY()!=K_ESC
          IF NNETMAP(TRIM(cDrive),TRIM(cPath),cFake='Y',cTemp='Y',cIns='Y')
            myAlert('Map operation successful!')
            BuildMapArray(@aList)
          ELSE
            myAlert('Map operation failed!')
          ENDIF
        ENDIF
      OTHERWISE
        EXIT
    ENDCASE
  ENDDO

  MYWCLOSE(hwnd)

RETURN(nOut)

FUNCTION lstudf(nMode,nAktPos,nRelPos)
  LOCAL nOut:=AC_CONT
  LOCAL nKey:=LASTKEY()

  DO CASE
    CASE nMode=AC_HITTOP .OR. nKey=K_END
      KEYBOARD CHR(K_CTRL_PGDN)
    CASE nMode=AC_HITBOTTOM .OR. nKey=K_HOME
      KEYBOARD CHR(K_CTRL_PGUP)
    CASE nMode=AC_EXCEPT
      DO CASE
        CASE nKey=K_INS .OR. nKey=K_DEL .OR. nKey=K_RETURN
          nOut=AC_SELECT
        CASE nKey=K_ESC
          nOut=AC_ABORT
      ENDCASE
  ENDCASE

RETURN(nOut)

FUNCTION BuildMapArray(aList)
  LOCAL i,cPfad,cDrive,m

  aList:={}

  FOR i=1 TO 26
    cDrive=CHR(64+i)
    IF !EMPTY(cPfad:=PADR(NNETMAPINF(cDrive),40))
      m=NNETMAPMOD(cDrive)
      cPfad+=IF(ISBIT(m,8),'L','')
      cPfad+=IF(ISBIT(m,1),'P','')
      cPfad+=IF(ISBIT(m,2),'T','')
      AADD(aList,cDrive+':'+SPACE(8)+CHR(179)+' '+cPfad)
    ENDIF
  NEXT i

  FOR i=1 TO 16
    cDrive='S'+NTOC(i)
    IF !EMPTY(cPfad:=NNETMAPINF(cDrive))
      IF SUBSTR(cPfad,2)==':.'
        cPfad=cPfad+' ['+NNETMAPINF(cDrive,.T.)+']'
      ENDIF
      cPfad=PADR(cPfad,40)
      m=NNETMAPMOD(cPfad)
      cPfad+=IF(ISBIT(m,8),'L','')
      cPfad+=IF(ISBIT(m,1),'P','')
      cPfad+=IF(ISBIT(m,2),'T','')
      AADD(aList,PADR(cDrive+':',10)+CHR(179)+' '+cPfad)
    ENDIF
  NEXT i
RETURN(aList)

FUNCTION Bindery()
  LOCAL hwnd,hwndChild,hwndChild1,hwndChild2,hwndInfo1,hwndInfo2
  LOCAL nChoice,nSubChoice,cMask
  LOCAL cServer:=attList(.T.)
  LOCAL aObjs,aObjTyp,aProps,aItems,aPropTyp,aDisp
  LOCAL nId,nType,nActType,nFlag,nSec,cName,cProp
  LOCAL nLinks,i

  WHILE !EMPTY(cServer)
    SETBOXGROW(10)
    hwnd=WOPEN(6,43,19,75)
    frame(0,0,MAXROW(),MAXCOL(),'Object-Type','RG+/B',.T.,.F.)
    SETBOXGROW(0)

    WHILE .T.
      frame(0,0,MAXROW(),MAXCOL(),'Object-Type','RG+/B',.T.,.F.)
      nChoice:=ACHOICE(3,3,MAXROW()-1,MAXCOL()-1,aTypes)
      frame(0,0,MAXROW(),MAXCOL(),'Object-Type','W+/B',.F.,.F.)

      IF nChoice>0

        hwndChild=WOPEN(12,6,14,66)
        CLS
        SETCOLOR('RG+/B')
        @ 0,0 TO MAXROW(),MAXCOL() DOUBLE
        cMask='*'+SPACE(46)
        @ 1,2 SAY 'Mask:' GET cMask PICTURE '@!'
        READ
        WCLOSE()

        IF LASTKEY()!=K_ESC
          nId=-1
          aObjs:={}
          aDisp:={}
          aObjTyp={}
          nType=aTypeCodes[nChoice]

          cMask=TRIM(cMask)
          WHILE .T.
            nActType=nType
            IF !EMPTY(cName:=NNETSCNBIN(cMask,@nActType,@nId))
              AADD(aDisp,PADR(cName,35)+' ³ '+Type2Str(nActType))
              AADD(aObjs,cName)
              AADD(aObjTyp,nActType)
            ELSE
              EXIT
            ENDIF
          ENDDO

          IF LEN(aDisp)=0
            aDisp={SPACE(36)+'³'}
          ENDIF
          hwndChild:=WOPEN(6,12,22,71)
          SETBOXGROW(10)

          WHILE .T.
            frame(0,0,MAXROW(),MAXCOL(),'Objects','RG+/B',.T.,.F.)
            SETBOXGROW(0)
            @ 3,39 TO MAXROW()-1,39
            nChoice:=ACHOICE(3,3,MAXROW()-1,MAXCOL()-1,aDisp)
            frame(0,0,MAXROW(),MAXCOL(),'Objects','W+/B',.F.,.F.)

            IF nChoice>0 .AND. LEN(aObjs)>0 .AND. !EMPTY(NNETSCNBIN(;
              cName:=aObjs[nChoice],aObjTyp[nChoice],-1,@nFlag,@nSec))
              hwndInfo1=WOPEN(5,2,11,30)
              WBOX(1)
              @ 0,1 SAY 'Objects: '+cName
              @ 1,1 SAY 'Type  : '+NTOC(aObjTyp[nChoice],16)+'h'
              @ 2,9 SAY Type2Str(aObjTyp[nChoice])
              @ 3,1 SAY 'Security  : '+NTOC(nSec,16)+'h'
              @ 4,1 SAY IF(nFlag=0,'Static','Dynamic')

              nId=-1
              aProps={}
              aPropTyp={}
              WHILE !EMPTY(cProp:=NNETSCNPRP(cName,aObjTyp[nChoice],'*',;
                                             @nId,@nFlag,@nSec))
                AADD(aProps,cProp)
                AADD(aPropTyp,{nFlag,nSec})
              ENDDO

              IF LEN(aProps)=0
                aProps={' '}
              ENDIF

              hwndChild1=WOPEN(5,55,18,75)
              SETBOXGROW(10)
              WHILE .T.
                frame(0,0,MAXROW(),MAXCOL(),'Properties','RG+/B',.T.,.F.)
                SETBOXGROW(0)
                nSubChoice:=ACHOICE(3,3,MAXROW()-1,MAXCOL()-1,aProps)
                frame(0,0,MAXROW(),MAXCOL(),'Properties','W+/B',.F.,.F.)

                IF nSubChoice>0 .AND. !EMPTY(NNETSCNPRP(cName,;
                                           aObjTyp[nChoice],'*',-1))
                  hwndInfo2=WOPEN(14,2,19,30)
                  WBOX(1)
                  @ 0,1 SAY 'Property: '+aProps[nSubChoice]
                  @ 1,1 SAY 'Type    : '+;
                        IF(ISBIT(aPropTyp[nSubChoice][1],2),'Set','Item')
                  @ 2,1 SAY 'Security  : '+;
                        NTOC(aPropTyp[nSubChoice][2],16)+'h'
                  @ 3,1 SAY IF(ISBIT(aPropTyp[nSubChoice][1],1),;
                            'Dynamic','Static')

                  IF ISBIT(aPropTyp[nSubChoice][1],2)
                    // Set-Property
                    aItems=NNETRDSET(cName,aObjTyp[nChoice],aProps[nSubChoice])

                    IF LEN(aItems)=0
                      aItems={SPACE(21)+'³'}
                    ELSE
                      FOR i=1 TO LEN(aItems)
                        aItems[i]=PADR(NNETOBJNAM(aItems[i]),20)+' ³ '+;
                                  Type2Str(NNETOBJTYP(aItems[i]))
                      NEXT i
                    ENDIF
                    nLinks=32
                  ELSE
                    // Item-Property
                    nId=1
                    aItems={}
                    WHILE !EMPTY(cProp:=NNETRDITM(cName,aObjTyp[nChoice],;
                                                  aProps[nSubChoice],nId++))
                      AADD(aItems,cProp)
                    ENDDO
                    IF LEN(aItems)=0
                      aItems={' '}
                    ENDIF
                    nLinks=38
                  ENDIF


                  hwndChild2=WOPEN(6,nLinks,19,70)
                  SETBOXGROW(10)
                  frame(0,0,MAXROW(),MAXCOL(),'Entries','RG+/B',.T.,.F.)
                  SETBOXGROW(0)

                  IF nLinks=32
                    @ 3,24 TO MAXROW()-1,24
                  ENDIF
                  ACHOICE(3,3,MAXROW()-1,MAXCOL()-1,aItems)

                  mywclose(hwndChild2)
                  mywclose(hwndInfo2)
                  WSELECT(hwndChild1)
                ELSE
                  EXIT
                ENDIF
              ENDDO
              mywclose(hwndChild1)
              mywclose(hwndInfo1)
              WSELECT(hwndChild)
            ELSE
              EXIT
            ENDIF

          ENDDO

          WCLOSE()
        ENDIF
      ELSE
        EXIT
      ENDIF
    ENDDO
    WCLOSE()
    cServer=attList(.T.)
  ENDDO
  attList(.F.)

RETURN(NIL)

FUNCTION send()
  LOCAL hwnd:=0,nChoice,cAddress,cMsg,nCount,lSuccess,cServer
  LOCAL aMenu:={ 'User','Group','All','Server-Console','Log-File' }

  SETBOXGROW(10)
  hwnd=WOPEN(8,8,23,33)

  WHILE .T.

    frame(0,0,MAXROW(),MAXCOL(),'Send to','RG+/B',.T.,.F.)
    SETBOXGROW(0)

    nChoice:=ACHOICE(3,3,MAXROW()-1,MAXCOL()-1,aMenu)
    frame(0,0,MAXROW(),MAXCOL(),'Send to','W+/B',.F.,.F.)

    DO CASE
      CASE nChoice=1 .OR. nChoice=2
        cMsg=SPACE(55)
        WHILE !EMPTY(cAddress:=user(nChoice+1,.F.,.T.))
          cMsg=PADR(cMsg,55)
          getMsg(@cMsg)
          IF nChoice=1
            nCount=NNETSNDUSR(cAddress,cMsg)
          ELSE
            nCount=NNETSNDGRP(cAddress,cMsg)
          ENDIF
          MyAlert('Message send to '+NTOC(nCount)+' station(s)!')
        ENDDO
        user(nChoice+1,.F.,.F.)
      CASE nChoice=3
        cMsg=SPACE(55)
        IF !EMPTY(attlist(.T.))
          getMsg(@cMsg)
          MyAlert('Message send to '+NTOC(NNETSNDALL(cMsg))+' stations!')
        ENDIF
        attlist(.F.)
      CASE nChoice=4 .OR. nChoice=5
        cMsg=SPACE(60)
        IF !EMPTY(attlist(.T.))
          getMsg(@cMsg)
          IF nChoice=4
            lSuccess=NNETSNDCON(cMsg)
          ELSE
            lSuccess=NNETSNDLOG(cMsg,.T.)
          ENDIF
          IF lSuccess
            MyAlert('Message succesfully sent!')
          ELSE
            MyAlert('Error while sending!')
          ENDIF
        ENDIF
        attlist(.F.)
      OTHERWISE
        EXIT
    ENDCASE
  ENDDO
  WCLOSE()
RETURN(NIL)

FUNCTION msgBuffer()
  LOCAL nMsg:=NNETMSGCNT(),i
  LOCAL aMsg

  IF nMsg=0
    MyAlert('No messages in buffer!')
  ELSE
    aMsg=ARRAY(nMsg)
    FOR i=1 TO nMsg
       aMsg[i]=NNETMSGRD()
    NEXT i

    WOPEN(8,11,19,69)
    SETBOXGROW(10)

    frame(0,0,MAXROW(),MAXCOL(),'Received Messages','RG+/B',.T.,.F.)
    SETBOXGROW(0)

    ACHOICE(3,3,MAXROW()-1,MAXCOL()-1,aMsg)
  ENDIF

  WCLOSE()

RETURN(nil)


// Q operations
//
// Oh Suzi Q, I still love you, my Suzi Q....
FUNCTION SUZI_Q

  LOCAL cServer:=attList(.T.)
  LOCAL aList:={},aQs:={}
  LOCAL cJobs
  LOCAL nId
  LOCAL cQ
  LOCAL nChoice,nJob
  LOCAL hwnd1,hwnd2

  WHILE !EMPTY(cServer)

    // get q
    nId=-1
    WHILE .T.
      IF !EMPTY(cQ:=NNETSCNBIN('*',OBJ_PRINTQUEUE,@nId))
        AADD(aQs,cQ)
      ELSE
        EXIT
      ENDIF
    ENDDO

    IF LEN(aQs)!=0

      SETBOXGROW(10)
      hwnd1=WOPEN(6,43,19,75)

      WHILE .T.

        frame(0,0,MAXROW(),MAXCOL(),'Queues','RG+/B',.T.,.F.)
        SETBOXGROW(0)

        nChoice:=ACHOICE(3,3,MAXROW()-1,MAXCOL()-1,aQs)
        frame(0,0,MAXROW(),MAXCOL(),'Queues','W+/B',.F.,.F.)

        IF nChoice>1

          hwnd2:=WOPEN(8,0,19,79)

          SETBOXGROW(10)
          WHILE .T.

            frame(0,0,MAXROW(),MAXCOL(),'  Seq Banner Name  Description'+;
                  SPACE(30)+'Form Status  Job',;
                  'RG+/B',.T.,.F.)

            // Build job list
            BuildQArray(aQs[nChoice],@aList,@cJobs)

            SETBOXGROW(0)
            nJob:=ACHOICE(3,3,MAXROW()-1,MAXCOL()-1,aList,.T.,'LSTUDF')

            frame(0,0,MAXROW(),MAXCOL(),'  Seq Banner Name  Description'+;
                  SPACE(30)+'Form Status  Job',;
                  'RG+/B',.F.,.F.)

            DO CASE

              CASE LASTKEY()==K_DEL

                IF YesNo('Delete Job',2)

                  IF !NNETJDEL(aQs[nChoice],;
                     BIN2I(SUBSTR(cJobs,(nJob-1)*2+1,2)))

                      MyAlert('Error while deleting!')

                  ENDIF

                ENDIF

              CASE LASTKEY()==K_INS

              CASE LASTKEY()==K_RETURN

              OTHERWISE

                EXIT

            ENDCASE

          ENDDO

          WCLOSE(hwnd2)

        ELSE

          EXIT

        ENDIF

      ENDDO

        WCLOSE(hwnd1)

    ENDIF

    cServer=attList(.T.)
  ENDDO


  attList(.F.)

RETURN(NIL)


FUNCTION BuildQArray(cQ,aList,cJobs)
  LOCAL i,nJob

  aList:={}
  cJobs:=NNETJLIST(cQ)


  IF LEN(cJobs) > 0           // Here LEN() is better than EMPTY()!

    FOR i=0 TO LEN(cJobs)/2-1

      nJob=BIN2I(SUBSTR(cJobs,i*2+1,2))
      AADD(aList,STR(i+1,3)+' '+PADR(NNETJBNAME(cQ,nJob),12) + ;
           ' '+PADR(NNETJDESC(cQ,nJob),41)+' '+;
           STR(NNETPFNUM(NNETJFORM(cQ,nJob)),4)+jstat(cQ,nJob)+;
           STR(nJob,4))
    NEXT i

  ELSE

    AADD(aList,SPACE(75))

  ENDIF

RETURN(aList)


FUNCTION jstat(cQ,nJob)
  LOCAL c
  LOCAL nFlags

  IF NNETJWORK(cQ,nJob)

    c='Service'

  ELSE

    nFlags=NNETJFLAGS(cQ,nJob)

    DO CASE

      CASE ISBIT(nFlags,6)

        c=' Open   '

      CASE ISBIT(nFlags,7) .OR. ISBIT(nFlags,8)

        c=' Held   '

      OTHERWISE

        c=' Ready  '

    ENDCASE


  ENDIF

RETURN(c)


FUNCTION trustees(cUser,nObjTyp)
  LOCAL hwnd,nChoice,hwndChild,hwndChild2,cPfad,cRechte,cFehl,i,j
  LOCAL nSubChoice
  LOCAL aList:={},aTrustees,aOwned,aNotOwned,aWork

  hwnd:=WOPEN(8,11,19,69)
  SETBOXGROW(10)

  frame(0,0,MAXROW(),MAXCOL(),PADC('Assignments for ';
        +cUser+' on '+NNETSNAME(),48),'RG+/B',.T.,.F.)
  SETBOXGROW(0)

  WHILE .T.

    BuildTrustArray(@aList,@aTrustees,cUser,nObjTyp)

    frame(0,0,MAXROW(),MAXCOL(),PADC('Assignments for ';
        +cUser+' on '+NNETSNAME(),48),'RG+/B',.T.,.F.)
    SETBOXGROW(0)

    @ 3,3 CLEAR TO MAXROW()-1,MAXCOL()-1
    @ 3,39 TO MAXROW()-1,39

    nChoice:=ACHOICE(3,3,MAXROW()-1,MAXCOL()-1,aList,.T.,'lstudf')

    frame(0,0,MAXROW(),MAXCOL(),PADC('Assignments for ';
        +cUser+' on '+NNETSNAME(),48),'W+/B',.F.,.F.)

    DO CASE
      CASE LASTKEY()=K_DEL .AND. LEFT(aList[nChoice],1)!=' '
        IF !NNETTRUST(cUser,nObjTyp,aTrustees[nChoice][1])
          MyAlert('Rights cannot be deleted!')
        ENDIF
      CASE LASTKEY()=K_INS
        hwndChild=WOPEN(12,6,14,66)
        SETCOLOR('RG+/B')
        @ 0,0 TO MAXROW(),MAXCOL() DOUBLE
        cPfad=SPACE(255)
        @ 1,2 SAY 'Directory'+IF(NNETVER()<'3','','/File')+':';
              GET cPfad PICTURE '@!S35'
        READ
        SETCOLOR('W+/B')
        IF LASTKEY()!=K_ESC
          IF !NNETTRUST(cUser,nObjTyp,TRIM(cPfad),;
              IF(NNETVER()<'3','ROS','RF'))
            MyAlert('Rights cannot be set!')
          ENDIF
        ENDIF
        MYWCLOSE(hwndChild)

      CASE LASTKEY()=K_RETURN .AND. LEFT(aList[nChoice],1)!=' '
         cRechte=CHARREM(' ',BITTOC(aTrustees[nChoice][2],NNETRGHMSK()))
         IF cRechte==''
           cRechte=' '
         ENDIF
         cFehl=CHARREM(cRechte+' ',NNETRGHMSK())
         IF cFehl==''
           cFehl=' '
         ENDIF
         aOwned=ARRAY(LEN(cRechte))
         aNotOwned=ARRAY(LEN(cFehl))
         FOR j=1 TO 2
           aWork=IF(j=1,aOwned,aNotOwned)
           FOR i=1 TO LEN(aWork)
             aWork[i]=SUBSTR(IF(j=1,cRechte,cFehl),i,1)
             DO CASE
               CASE aWork[i]='R'
                 aWork[i]='Read'
               CASE aWork[i]='W'
                 aWork[i]='Write'
               CASE aWork[i]='C'
                 aWork[i]='Create'
               CASE aWork[i]='M'
                 aWork[i]='Modify'
               CASE aWork[i]=' '
                 aWork[i]=' '
               OTHERWISE
                 IF NNETVER()<'3'
                   DO CASE
                     CASE aWork[i]='O'
                       aWork[i]='Open'
                     CASE aWork[i]='D'
                       aWork[i]='Delete'
                     CASE aWork[i]='P'
                       aWork[i]='Parental'
                     CASE aWork[i]='S'
                       aWork[i]='Search'
                   ENDCASE
                 ELSE
                   DO CASE
                     CASE aWork[i]='E'
                       aWork[i]='Erase'
                     CASE aWork[i]='A'
                       aWork[i]='Access Control'
                     CASE aWork[i]='F'
                       aWork[i]='File Scan'
                     CASE aWork[i]='S'
                       aWork[i]='Supervisory'
                   ENDCASE
                 ENDIF
             ENDCASE
           NEXT i
         NEXT j

         hwndChild=WOPEN(6,10,22,35)
         SETBOXGROW(10)
         WHILE .T.
           frame(0,0,MAXROW(),MAXCOL(),'Act. Rights','RG+/B',.T.,.F.)
           SETBOXGROW(0)

           ASORT(aOwned)

           nSubChoice=ACHOICE(3,3,MAXROW()-1,MAXCOL()-1,aOwned,.T.,'lstudf')

           frame(0,0,MAXROW(),MAXCOL(),'Act. Rights','W+/B',.F.,.F.)
           DO CASE
             CASE LASTKEY()=K_DEL .AND. !EMPTY(aOwned[nSubChoice])
               AADD(aNotOwned,aOwned[nSubChoice])
               BlCheck(aNotOwned)
               ADEL(aOwned,nSubChoice)
               ASIZE(aOwned,LEN(aOwned)-1)
               IF LEN(aOwned)==0
                 aOwned={' '}
               ENDIF
             CASE LASTKEY()=K_INS
               hwndChild2=WOPEN(6,41,20,73)
               SETBOXGROW(10)
               WHILE .T.
                 frame(0,0,MAXROW(),MAXCOL(),'Avail. Rights','RG+/B',.T.,.F.)
                 SETBOXGROW(0)
                 ASORT(aOwned)
                 ASORT(aNotOwned)
                 WSELECT(hwndChild)
                 FOR i=1 TO LEN(aOwned)
                   @ 2+i,3 SAY PADR(aOwned[i],20)
                 NEXT i
                 WSELECT(hwndChild2)

                 nSubChoice=ACHOICE(3,3,MAXROW()-1,MAXCOL()-1,aNotOwned,.T.,'lstudf')
                 frame(0,0,MAXROW(),MAXCOL(),'Avail. Rights','W+/B',.F.,.F.)

                 DO CASE
                   CASE LASTKEY()=K_RETURN .AND. !EMPTY(aNotOwned[nSubChoice])
                     AADD(aOwned,aNotOwned[nSubChoice])
                     BlCheck(aOwned)
                     ADEL(aNotOwned,nSubChoice)
                     ASIZE(aNotOwned,LEN(aNotOwned)-1)
                     IF LEN(aNotOwned)==0
                       aNotOwned={' '}
                     ENDIF
                   CASE LASTKEY()=K_ESC
                     EXIT
                 ENDCASE
               ENDDO
               WCLOSE()
             CASE LASTKEY()=K_ESC
               EXIT
           ENDCASE
         ENDDO
         cRechte=''
         FOR i=1 TO LEN(aOwned)
           cRechte+=LEFT(aOwned[i],1)
         NEXT i
         IF !EMPTY(cRechte)
           IF !NNETTRUST(cUser,nObjTyp,aTrustees[nChoice][1],cRechte)
             MyAlert('Rights cannot be set!')
           ENDIF
         ENDIF
         WCLOSE()
      OTHERWISE
        EXIT
    ENDCASE

  ENDDO
  MYWCLOSE(hwnd)

RETURN(NIL)

FUNCTION BuildTrustArray(aList,aTrust,cUser,nObjTyp)
 LOCAL cRechte
 LOCAL i

 aTrust:=NNETTRSLST(cUser,nObjTyp)
 aList:=ARRAY(LEN(aTrust))

 IF LEN(aList)=0
   aList={SPACE(36)+'³'}
 ELSE
   FOR i=1 TO LEN(aList)
     aList[i]=PADR(aTrust[i][1],35)+' ³ ['+CHARMIRR(BITTOC(aTrust[i][2],;
                    NNETRGHMSK(),.T.))+']'
   NEXT i
 ENDIF

RETURN(NIL)

//
FUNCTION GroupsImIn(cUser,mode)
  LOCAL nOldhwnd:=WSELECT()
  LOCAL hwnd:=WOPEN(6,46,22,71),hwndChild
  LOCAL nChoice,nErfolg
  LOCAL aList
  SETBOXGROW(10)

  WHILE .T.
    frame(0,0,MAXROW(),MAXCOL(),cUser,'RG+/B',.T.,.T.)
    SETBOXGROW(0)
    IF mode=1
      aList:=NNETINGRPS(cUser)
    ELSE
      aList:=NNETUSINGR(cUser)
    ENDIF
    IF LEN(aList)=0
      aList={' '}
    ENDIF
    nChoice:=ACHOICE(3,3,MAXROW()-1,MAXCOL()-3,aList,.T.,'LSTUDF')
    frame(0,0,MAXROW(),MAXCOL(),cUser,'W+/B',.F.,.T.)
    DO CASE
      CASE LASTKEY()=K_DEL
        IF mode=1
          nErfolg=NNETREMGRP(aList[nChoice],cUser)
        ELSE
          nErfolg=NNETREMGRP(cUser,aList[nChoice])
        ENDIF
        IF nErfolg=0
          MyAlert('User cannot be deleted!')
        ENDIF
      CASE LASTKEY()=K_INS
        IF mode=1
          aList=NNETGROUPS()
        ELSE
          aList=NNETUSERS()
        ENDIF
        hwndChild=WOPEN(8,48,24,73)
        SETBOXGROW(10)

        frame(0,0,MAXROW(),MAXCOL(),cUser,'RG+/B',.T.,.T.)
        SETBOXGROW(0)
        nChoice:=ACHOICE(3,3,MAXROW()-1,MAXCOL()-3,aList)
        frame(0,0,MAXROW(),MAXCOL(),cUser,'W+/B',.F.,.T.)
        WCLOSE()

        IF nChoice>0
          IF mode=1
            nErfolg=NNETADDGRP(aList[nChoice],cUser)
          ELSE
            nErfolg=NNETADDGRP(cUser,aList[nChoice])
          ENDIF
          IF nErfolg=0
           MyAlert('User cannot be added!')
          ENDIF
        ENDIF

      OTHERWISE
        EXIT
    ENDCASE
  ENDDO
  WCLOSE()
  WSELECT(nOldhwnd)
RETURN(NIL)

FUNCTION Ident(cObjName,nObj)
  LOCAL hwnd:=WOPEN(12,35,14,77)
  LOCAL cName:=''
  LOCAL cProp:='IDENTIFICATION'
  CLS
  SETCOLOR('RG+/B')
  @ 0,0 TO MAXROW(),MAXCOL() DOUBLE

  // Does property "IDENTIFICATION" exist?
  IF !EMPTY(NNETSCNPRP(cObjName,nObj,cProp,-1))
    cName=NNETRDITM(cObjName,nObj,cProp)
  ELSE
    NNETCRTPRP(cObjName,nObj,cProp)
  ENDIF

  cName=PADR(cName,128)
  @ 1,2 SAY 'Full name:' GET cName PICTURE '@S25'
  READ

  SETCOLOR('W+/B')
  IF LASTKEY()!=K_ESC
    IF !NNETWRTITM(cObjName,nObj,cProp,TRIM(cName),1,.T.)
      MyAlert('Name cannot be set!')
    ENDIF
  ENDIF
  MYWCLOSE(hwnd)
RETURN(NIL)

FUNCTION Security(cName,nObj)
  LOCAL nOldhwnd:=WSELECT()
  LOCAL hwnd:=WOPEN(6,12,22,71),hwndChild
  LOCAL cProp:='SECURITY_EQUALS'
  LOCAL nChoice,nSubChoice,i,nType,cObjName,nId
  LOCAL aList,aAnzeige,aNewSec
  SETBOXGROW(10)

  WHILE .T.
    frame(0,0,MAXROW(),MAXCOL(),'Security equivalents for '+;
          IF(nObj=OBJ_USER,'User','Group')+' '+cName,'RG+/B',.T.,.T.)
    SETBOXGROW(0)
    aList=NNETRDSET(cName,nObj,cProp)

    // rebuild display array....
    aAnzeige=BuildDispLst(aList)

    @ 3,39 TO MAXROW()-1,39
    nChoice:=ACHOICE(3,3,MAXROW()-1,MAXCOL()-3,aAnzeige,.T.,'LSTUDF')
    frame(0,0,MAXROW(),MAXCOL(),cName,'W+/B',.F.,.T.)
    DO CASE
      CASE LASTKEY()=K_DEL .AND. !EMPTY(aAnzeige[nChoice])
          IF !NNETDELSET(cName,nObj,cProp,NNETOBJNAM(aList[nChoice]),;
                         NNETOBJTYP(aList[nChoice]))
            MyAlert('Object caonnot be deleted!')
          ENDIF
      CASE LASTKEY()=K_INS

        aNewSec:={}
        FOR i=1 TO 2
          nType=IF(i=1,OBJ_USER,OBJ_GROUP)
          nId=-1
          WHILE .T.
            IF !EMPTY(cObjName:=NNETSCNBIN('*',nType,@nId))
              IF !NNETINSET(cName,nObj,cProp,cObjName,nType)
                AADD(aNewSec,PADR(cObjName,35)+' ³ '+Type2Str(nType))
              ENDIF
            ELSE
              EXIT
            ENDIF
          ENDDO
        NEXT i

        ASORT(aNewSec)

        hwndChild=WOPEN(7,16,23,75)
        SETBOXGROW(10)

        frame(0,0,MAXROW(),MAXCOL(),'Add for '+cName,'RG+/B',.T.,.T.)
        SETBOXGROW(0)
        @ 3,39 TO MAXROW()-1,39
        nSubChoice:=ACHOICE(3,3,MAXROW()-1,MAXCOL()-3,aNewSec)
        WCLOSE()

        IF nSubChoice>0
          IF EMPTY(NNETSCNPRP(cName,nObj,cProp,-1))
            NNETCRTPRP(cName,nObj,cProp,PRP_SET)
          ENDIF

          IF !NNETADDSET(cName,nObj,cProp,TRIM(LEFT(aNewSec[nSubChoice],35)),;
              IF('Group'$aNewSec[nSubChoice],OBJ_GROUP,OBJ_USER))
            MyAlert('Object cannot be added!')
          ENDIF
        ENDIF

      OTHERWISE
        EXIT
    ENDCASE
  ENDDO
  WCLOSE()
  WSELECT(nOldhwnd)
RETURN(NIL)

FUNCTION BuildDispLst(aList)
  LOCAL aAnzeige:=ARRAY(LEN(aList))
  LOCAL i

  IF LEN(aList)=0
   aAnzeige={SPACE(36)+'³'}
  ELSE
    FOR i=1 TO LEN(aList)
      aAnzeige[i]=PADR(NNETOBJNAM(aList[i]),35)+' ³ '+;
                  LEFT(TYPE2STR(NNETOBJTYP(aList[i])),15)
    NEXT i
  ENDIF

RETURN(aAnzeige)

FUNCTION Password(cName)
  LOCAL hwnd:=WOPEN(12,35,14,77)
  LOCAL cAlt,cNeu,cKont
  CLS
  SETCOLOR('RG+/B')
  @ 0,0 TO MAXROW(),MAXCOL() DOUBLE

  SETLASTKEY(0)

  cAlt:=SPACE(127)

  // if current user isn't supervisor equivalent,
  // old password is required...
  IF NNETBINACC()<3
    @ 1,2 SAY 'Old Password:' GET cAlt PICTURE '@!S25' SEND colorDisp('W/W')
    READ
  ENDIF

  IF LASTKEY()!=K_ESC
    WHILE .T.
      cNeu:=cKont:=SPACE(127)
      @ 1,2 SAY 'New Password:' GET cNeu PICTURE '@!S25';
                 SEND colorDisp('W/W')
      READ
      IF LASTKEY()!=K_ESC
        @ 1,2 SAY 'New Password :' GET cKont PICTURE '@!S25';
                   SEND colorDisp('W/W')
        READ
      ELSE
        EXIT
      ENDIF
      IF cKont==cNeu
        EXIT
      ELSE
        MyAlert('Password retyped incorretly!')
      ENDIF
    ENDDO
  ENDIF

  SETCOLOR('W+/B')
  IF LASTKEY()!=K_ESC
    IF !NNETCPASS(cName,,TRIM(cAlt),TRIM(cNeu))
      MyAlert('Password cannot be set!')
    ENDIF
  ENDIF
  MYWCLOSE(hwnd)
RETURN(NIL)


FUNCTION accRest(cUser)
  LOCAL dPassExp:=NNETPEXPD(cUser)
  LOCAL nPassInt:=NNETPEXPI(cUser)
  LOCAL dAccExp:=NNETAEXPD(cUser)
  LOCAL cAccDis:=IF(NNETACCDIS(cUser),'Y','N')
  LOCAL nMaxCon:=NNETMAXCON(cUser)
  LOCAL nMinPassLen:=NNETPWLEN(cUser)

  WOPEN(6,11,18,68)

  WINFRAME('Account details for '+cUser)

  @ 4,2 SAY 'Account disabled:'
  @ 5,2 SAY 'Expiration date:'
  @ 6,2 SAY 'Max. number of connections:'
  @ 7,2 SAY 'Min. password length:'
  @ 8,2 SAY 'Days between changes:'
  @ 9,2 SAY 'Pwd. expiration date:'

  @ 11,1 SAY CENTER('Empty fields indicate no limitation!')

  @ 4,31 GET cAccDis PICTURE '!' VALID cAccDis$'YN' COLOR 'W+/B,B/W'
  @ 5,31 GET dAccExp COLOR 'W+/B,B/W'
  @ 6,31 GET nMaxCon PICTURE '999' COLOR 'W+/B,B/W'
  @ 7,32 GET nMinPassLen PICTURE '99' COLOR 'W+/B,B/W'
  @ 8,31 GET nPassInt PICTURE '999' COLOR 'W+/B,B/W'
  @ 9,31 GET dPassExp COLOR 'W+/B,B/W'
  READ

  IF LASTKEY()!=K_ESC
    IF NNETBINACC()=3
      NNETPEXPD(cUser,dPassExp)
      NNETPEXPI(cUser,nPassInt)
      NNETAEXPD(cUser,dAccExp)
      NNETACCDIS(cUser,cAccDis=='Y')
      NNETMAXCON(cUser,nMaxCon)
      NNETPWLEN(cUser,nMinPassLen)
    ELSE
     MyAlert('No Supervisor rights!')
    ENDIF
  ENDIF
  WCLOSE()

RETURN(NIL)

FUNCTION TYPE2STR(nTyp)
  LOCAL i,cOut

  IF (i:=ASCAN(aTypeCodes,nTyp))>0
    cOut=aTypes[i]
  ELSE
    cOut='Unknown'
  ENDIF

RETURN(cOut)

FUNCTION frame(nTop,nLeft,nBottom,nRight,cText,cColor,lClear,lSec)
  @ nTop,nLeft,nBottom,nRight BOX B_DOUBLE+if(lClear,' ','') COLOR cColor
  @ nTop+2,nLeft SAY CHR(204) COLOR cColor
  @ nTop+2,nRight SAY CHR(185) COLOR cColor
  @ nTop+2,nLeft+1 TO nTop+2,nRight-1 DOUBLE COLOR cColor
  @ nTop+3,nLeft+2 TO nBottom-1,nLeft+2
  @ nTop+1,nLeft+1 SAY PADC(cText,nRight-nLeft-1) COLOR cColor
  IF lSec
    @ nTop+3,nRight-2 TO nBottom-1,nRight-2
  ENDIF
RETURN(NIL)

FUNCTION winframe(cTitel)

  SETBOXGROW(10)
  @ 0,0,MAXROW(),MAXCOL() BOX B_SINGLE+' 'COLOR 'RG+/B'
  SETBOXGROW(0)

  @ 2,0 SAY CHR(195) COLOR 'RG+/B'
  @ 2,MAXCOL() SAY CHR(180) COLOR 'RG+/B'
  @ 2,1 TO 2,MAXCOL()-1 COLOR 'RG+/B'
  @ 1,1 SAY PADC(cTitel,MAXCOL()-2) COLOR 'RG+/B'
RETURN(NIL)

FUNCTION status()
  LOCAL hwnd:=WSELECT()

  WSELECT(0)

  @ 2,1 SAY PADC('Visible Servers:'+STR(NNETCVSSRV(),3)+;
                 '  Attached Servers:'+STR(NNETCCNSRV(),3)+;
                 '  Logged Servers:'+STR(NNETCCNSRV(.T.),3),MAXCOL()-2);
                 COLOR 'b/bg'
  WSELECT(hwnd)

RETURN(NIL)

FUNCTION LastLogDate(cUser)
  LOCAL cBuffer
  LOCAL dLast:=CTOD('')

  cBuffer=NNETRDITM(cUser,,'LOGIN_CONTROL',1,.T.)

  IF !EMPTY(cBuffer:=NNETRDITM(cUser,,'LOGIN_CONTROL',1,.T.))
    dLast=STOD('19'+NTOC(ASC(SUBSTR(cBuffer,57,1)),,2,'0')+;
                    NTOC(ASC(SUBSTR(cBuffer,58,1)),,2,'0')+;
                    NTOC(ASC(SUBSTR(cBuffer,59,1)),,2,'0'))
  ENDIF

RETURN(dLast)

FUNCTION LastLogTime(cUser)
  LOCAL cBuffer
  LOCAL cLast:=''

  IF !EMPTY(cBuffer:=NNETRDITM(cUser,,'LOGIN_CONTROL',1,.T.))
    cLast=NTOC(ASC(SUBSTR(cBuffer,60,1)),,2,'0')+':'+;
          NTOC(ASC(SUBSTR(cBuffer,61,1)),,2,'0')+':'+;
          NTOC(ASC(SUBSTR(cBuffer,62,1)),,2,'0')
  ENDIF

RETURN(cLast)

FUNCTION getMSg(cMsg)
  WOPEN(12,3,14,77)
  CLS
  SETCOLOR('RG+/B')
  @ 0,0 TO MAXROW(),MAXCOL() DOUBLE
  @ 1,2 SAY 'Message: ' GET cMsg
  READ
  SETCOLOR('W+/B')

  WCLOSE()

  cMsg=TRIM(cMsg)

RETURN(NIL)

FUNCTION MaxSpace(cUser)
  LOCAL cBuffer
  LOCAL nUsed:=-1

  IF !EMPTY(cBuffer:=NNETRDITM(cUser,,'LOGIN_CONTROL',1,.T.))
    nUsed=BIN2L(CHARMIRR(SUBSTR(cBuffer,65,4)))
    IF nUsed=CTON('7FFFFFFF',16)
      nUsed=-1
    ELSE
      nUsed*=4
    ENDIF
  ENDIF

RETURN(nUsed)

FUNCTION myAlert(cText)
  LOCAL oldColor:=SETCOLOR('W+/RB')
  LOCAL nLen:=MAX(40,LEN(cText))+2
  LOCAL hwnd:=WOPEN(11,(80-nLen)/2,14,(80-nLen)/2+nLen)
  LOCAL oldCurs:=SETCURSOR()
  SET CURSOR OFF
  WBOX(1)
  @ 0,1 SAY CENTER(cText)
  @ 1,1 SAY CENTER('Press any key!')
  INKEY(0)
  MYWCLOSE(hwnd)
  SETCOLOR(oldColor)
  SETCURSOR(oldCurs)
RETURN(NIL)

FUNCTION YESNO(cText,nDef)
  LOCAL oldColor:=SETCOLOR('RB/W,W+/RB')
  LOCAL nLen:=LEN(cText)+6
  LOCAL hwnd:=WOPEN(11,(80-nLen)/2,16,(80-nLen)/2+nLen)
  LOCAL nChoice

  SETBOXGROW(10)
  frame(0,0,MAXROW(),MAXCOL(),cText,'RG+/W',.T.,.F.)
  SETBOXGROW(0)

  nChoice=ACHOICE(3,3,MAXROW()-1,MAXCOL()-1,{'No','Yes'},.T.,.T.,nDef)
  MYWCLOSE(hwnd)
  SETCOLOR(oldColor)
RETURN(nChoice==2)

FUNCTION BlCheck(a)
  IF EMPTY(a[1]) .AND. LEN(a)>1
    ADEL(a,1)
    ASIZE(a,LEN(a)-1)
  ENDIF
RETURN(NIL)

function MyWclose(hwnd)
  LOCAL Oldhwnd:=WSELECT()
  WSELECT(hwnd)
  WCLOSE()
  WSELECT(hwnd)
RETURN(NIL)
