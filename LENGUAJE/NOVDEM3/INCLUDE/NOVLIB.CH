//
// NOVLIB.CH V3.0
//
// Copyright (c) 1992-1996, ASM Inc
//

#define OT_WILD                         -1
#define OT_UNKNOWN                       0
#define OT_USER                          1
#define OT_USER_GROUP                    2
#define OT_PRINT_QUEUE                   3
#define OT_FILE_SERVER                   4
#define OT_JOB_SERVER                    5
#define OT_GATEWAY                       6
#define OT_PRINT_SERVER                  7
#define OT_ARCHIVE_QUEUE                 8
#define OT_ARCHIVE_SERVER                9
#define OT_JOB_QUEUE                    10
#define OT_ADMINISTRATION               11
#define OT_NAS_SNA_GATEWAY              33
#define OT_REMOTE_BRIDGE_SERVER         36
#define OT_TIME_SYNCHRONIZATION_SERVER	45
#define OT_ARCHIVE_SERVER_DYNAMIC_SAP   46
#define OT_ADVERTISING_PRINT_SERVER     71
#define OT_BTRIEVE_VAP                  80
#define OT_PRINT_QUEUE_USER             83

#define KEYWORD                          1
#define KEYVALUE                         2

#define NOVDEFINT                       -1
#define NOVDEFLONG                      -1
#define NOVERRINT                       -1
#define NOVERRLONG                      -1
#define NOVNODSKRES                     -255
#define NOVNOVOLRES                     -255

#define NOVLOKWILD                       0
#define NOVLOKCLIPPER                    1
#define NOVLOKNTX2                       2
#define NOVLOKFOX1                       3
#define NOVLOKFOX2                       4

/* Account Functions */

#xtranslate FSACCENABTST()                  => if( FSACCVERGET() == 1, .T., .F.)
#xtranslate USRACCBALGET(<expC>)           => ;
   SETPRPVALSET(<expC>,OT_USER,"ACCOUNT_BALANCE",1)
#xtranslate USRACCBALSET(<expC>,<expN>)    => ;
   SETPRPVALSET(<expC>,OT_USER,"ACCOUNT_BALANCE",1,<expN>)
#xtranslate USRACCLIMGET(<expC>)           => ;
   SETPRPVALSET(<expC>,OT_USER,"ACCOUNT_BALANCE",2)
#xtranslate USRACCLIMSET(<expC>,<expN>)    => ;
   SETPRPVALSET(<expC>,OT_USER,"ACCOUNT_BALANCE",2,<expN>)
#xtranslate FSACCSRVADD(<expC>,<expN>)     => ;
  SETPRPIDADD(FSNMEGET(),OT_FILE_SERVER,<expC>,<expN>,"ACCOUNT_SERVERS")
#xtranslate FSACCSRVDEL(<expC>,<expN>)     => ;
  SETPRPIDDEL(FSNMEGET(),OT_FILE_SERVER,<expC>,<expN>,"ACCOUNT_SERVERS")

/* Bindery Functions */

#XTRANSLATE USRPASSTST(<expC1>,<expC2>) => OBJPASSCHK(<expC1>,<expC2>,OT_USER)
#XTRANSLATE USRPASSCHG(<expC1>,<expC2>,<expC3>) => ;
  OBJPASSCHG(<expC1>,<expC2>,<expC3>,OT_USER)

#xtranslate USRNAMEGET(<expN>)           => OBJNMEGET(<expN>)
#xtranslate USRNMEGET(<expN>)            => OBJNMEGET(<expN>)
#xtranslate GRPNMEGET(<expN>)            => OBJNMEGET(<expN>)
#xtranslate QUENMEGET(<expN>)            => OBJNMEGET(<expN>)

#xtranslate USRIDGET(<expC>)             => OBJIDGET(<expC>,OT_USER)
#xtranslate GRPIDGET(<expC>)             => OBJIDGET(<expC>,OT_USER_GROUP)
#xtranslate QUEIDGET(<expC>)             => OBJIDGET(<expC>,OT_PRINT_QUEUE)
#xtranslate FSIDGET(<expC>)              => OBJIDGET(<expC>,OT_FILE_SERVER)

#xtranslate GRPUSRTST(<expC1>,<expC2>)   => ;
  SETPRPIDTST(<expC2>,OT_USER_GROUP,<expC1>,OT_USER,"GROUP_MEMBERS")
#xtranslate USRSUPTST(<expC>)             => ;
  SETPRPIDTST(<expC>,OT_USER,"SUPERVISOR",OT_USER,"SECURITY_EQUALS")
#xtranslate USRCONOPRTST(<expC>)          => ;
  SETPRPIDTST(FSNMEGET(),OT_FILE_SERVER,<expC>,OT_USER,"OPERATORS")
#xtranslate QUEOPRTST(<expC1>,<expC2>)   => ;
  SETPRPIDTST(<expC2>,OT_PRINT_QUEUE,<expC1>,OT_USER,"Q_OPERATORS")
#xtranslate QUEUSRTST(<expC1>,<expC2>)   => ;
  SETPRPIDTST(<expC2>,OT_PRINT_QUEUE,<expC1>,OT_USER,"Q_USERS")
#xtranslate USRGRPMGRTST(<expC>)         => ;
  SETPRPIDTST("SUPERVISOR",OT_USER,<expC>,OT_USER,"MANAGERS")

#xtranslate FSBINDCLS()                  => Bindery(.T.)
#xtranslate FSBINDOPN()                  => Bindery(.F.)

#xtranslate FSUSRDEL(<expC>)             => FSOBJDEL(<expC>,OT_USER)
#xtranslate FSDELGRP(<expC>)             => FSOBJDEL(<expC>,OT_USER_GROUP)
#xtranslate USRCHGNME(<expC1>,<expC2>)   => OBJNMECHG(<expC1>,<expC2>,OT_USER)
#xtranslate GRPCHGNME(<expC1>,<expC2>)   => OBJNMECHG(<expC1>,<expC2>,OT_USER_GROUP)

#xtranslate USRCONOPRSET(<expC>)         => ;
  SETPRPIDADD(FSNMEGET(),OT_FILE_SERVER,<expC>,OT_USER,"OPERATORS")
#xtranslate USRSUPSET(<expC>)            => ;
  SETPRPIDADD(<expC>,OT_USER,"SUPERVISOR",OT_USER,"SECURITY_EQUALS")
#xtranslate QUEOPRADD(<expC1>,<expC2>)   => ;
  SETPRPIDADD(<expC2>,OT_PRINT_QUEUE,<expC1>,OT_USER,"Q_OPERATORS")
#xtranslate QUEUSRADD(<expC1>,<expC2>)   => ;
  SETPRPIDADD(<expC2>,OT_PRINT_QUEUE,<expC1>,OT_USER,"Q_USERS")
#xtranslate USRGRPMGRSET(<expC>)         => ;
  SETPRPIDADD("SUPERVISOR",OT_USER,<expC>,OT_USER,"MANAGERS")
#xtranslate QUEGRPADD(<expC1>,<expC2>)   => ;
  SETPRPIDADD(<expC2>,OT_PRINT_QUEUE,<expC1>,OT_USER_GROUP,"Q_USERS")
#xtranslate USRCONOPRDEL(<expC>)         => ;
  SETPRPIDDEL(FSNMEGET(),OT_FILE_SERVER,<expC>,OT_USER,"OPERATORS")
#xtranslate USRSUPDEL(<expC>)            => ;
  SETPRPIDDEL(<expC>,OT_USER,"SUPERVISOR",OT_USER,"SECURITY_EQUALS")
#xtranslate QUEOPRDEL(<expC1>,<expC2>)   => ;
  SETPRPIDDEL(<expC2>,OT_PRINT_QUEUE,<expC1>,OT_USER,"Q_OPERATORS")
#xtranslate QUEUSRDEL(<expC1>,<expC2>)   => ;
  SETPRPIDDEL(<expC2>,OT_PRINT_QUEUE,<expC1>,OT_USER,"Q_USERS")
#xtranslate USRGRPMGRDEL(<expC>)         => ;
  SETPRPIDDEL("SUPERVISOR",OT_USER,<expC>,OT_USER,"MANAGERS")
#xtranslate QUEGRPDEL(<expC1>,<expC2>)   => ;
  SETPRPIDDEL(<expC2>,OT_PRINT_QUEUE,<expC1>,OT_USER_GROUP,"Q_USERS")

#xtranslate GRPUSRLST(<expC>,<expN>)     => ;
  OBJNMEGET(SETPRPVALGET(<expC>,OT_USER_GROUP,"GROUP_MEMBERS",<expN>))
#xtranslate USRGRPLST(<expC>,<expN>)     => ;
  OBJNMEGET(SETPRPVALGET(<expC>,OT_USER,"GROUPS_I'M_IN",<expN>))
#xtranslate FSCONOPRLST(<expC>,<expN>)   => ;
  OBJNMEGET(SETPRPVALGET(<expC>,OT_FILE_SERVER,"OPERATORS",<expN>))
#xtranslate QUEOPRLST(<expC>,<expN>)     => ;
  OBJNMEGET(SETPRPVALGET(<expC>,OT_PRINT_QUEUE,"Q_OPERATORS",<expN>))
#xtranslate QUEUSRLST(<expC>,<expN>)     => ;
  OBJNMEGET(SETPRPVALGET(<expC>,OT_PRINT_QUEUE,"Q_USERS",<expN>))
#xtranslate FSGRPMGRLST(<expN>)          => ;
  OBJNMEGET(SETPRPVALGET("SUPERVISOR",OT_USER,"MANAGERS",<expN>))

/* Directory Functions */

#xtranslate DIRUSERADD(<expN1>,<expC>,<expN2>)  => ;
  DIROBJADD(<expN1>,<expC>,<expN2>)
#xtranslate DIRGRPADD(<expN1>,<expC>,<expN2>)   => ;
  DIROBJADD(<expN1>,<expC>,<expN2>)
#xtranslate DIRUSRDEL(<expN>,<expC>)            => ;
  DIROBJDEL(<expN>,<expC>)
#xtranslate DIRGRPDEL(<expN>,<expC>)            => ;
  DIROBJDEL(<expN>,<expC>)
#xtranslate FILADDUSR(<expN1>,<expC>,<expN2>)   => ;
  DIROBJADD(<expN1>,<expC>,<expN2>)
#xtranslate FILADDGRP(<expN1>,<expC>,<expN2>)   => ;
  DIROBJADD(<expN1>,<expC>,<expN2>)
#xtranslate FILDELUSR(<expN>,<expC>)    => DIROBJDEL(<expN>,<expC>)
#xtranslate FILDELGRP(<expN>,<expC>)    => DIROBJDEL(<expN>,<expC>)

/* Queue Management Functions */

#xtranslate FSQUEDEL(<expC>)             => ;
  FSOBJDEL(<expC>,OT_PRINT_QUEUE)
#xtranslate QUENMECHG(<expC1>,<expC2>)   => ;
  OBJNMECHG(<expC1>,<expC2>,OT_PRINT_QUEUE)

/* Print Server Functions */

#xtranslate PSOPRADD(<expC1>,<expC2>)     => ;
  SETPRPIDADD(<expC2>,OT_PRINT_SERVER,<expC1>,OT_USER,"PS_OPERATORS")
#xtranslate PSUSRADD(<expC1>,<expC2>)   => ;
  SETPRPIDADD(<expC2>,OT_PRINT_SERVER,<expC1>,OT_USER,"PS_USERS")
#xtranslate PSOPRDEL(<expC1>,<expC2>)     => ;
  SETPRPIDDEL(<expC2>,OT_PRINT_SERVER,<expC1>,OT_USER,"PS_OPERATORS")
#xtranslate PSUSRDEL(<expC1>,<expC2>)   => ;
  SETPRPIDDEL(<expC2>,OT_PRINT_SERVER,<expC1>,OT_USER,"PS_USERS")
#xtranslate PSOPRLST(<expC>,<expN>)         => ;
  OBJNMEGET(SETPRPIDTST(<expC>,OT_PRINT_SERVER,"PS_OPERATORS",<expN>))
#xtranslate PSUSRLST(<expC>,<expN>)       => ;
  OBJNMEGET(SETPRPIDTST(<expC>,OT_PRINT_SERVER,"PS_USERS",<expN>))

/* Here follow the UDC's */

/*******************************************************************************
*                                                                              *
*   COMMAND NAME: ATTACH                                                       *
*    DESCRIPTION: Emulates syntax of Novell's ATTACH.EXE command line utility  *
*                                                                              *
*  Copyright (C) 1996 ASM Inc       . All Rights Reserved.                     *
*                                                                              *
*******************************************************************************/

#xcommand ATTACH <(a)> [<(b)>] => NlAttach( <(a)>, <(b)> )


/*******************************************************************************
*                                                                              *
*   COMMAND NAME: SETPASS                                                      *
*    DESCRIPTION: Emulates syntax of Novell's SETPASS.EXE command line utility *
*                                                                              *
*  Copyright (C) 1996 ASM Inc       . All Rights Reserved.                     *
*                                                                              *
*******************************************************************************/

#xcommand SETPASS <(a)> <(b)> [<(c)>] => NlSetPass( <(a)>, <(b)>, <(c)> )


/*******************************************************************************
*                                                                              *
*   COMMAND NAME: LOGIN                                                        *
*    DESCRIPTION: Emulates syntax of Novell's LOGIN.EXE command line utility   *
*                                                                              *
*  Copyright (C) 1996 ASM Inc       . All Rights Reserved.                     *
*                                                                              *
*******************************************************************************/

#xcommand LOGIN <(a)> <(b)> => NlLogin( <(a)>, <(b)> )


/*******************************************************************************
*                                                                              *
*   COMMAND NAME: LOGOUT                                                       *
*    DESCRIPTION: Emulates syntax of Novell's LOGOUT.EXE command line utility  *
*                                                                              *
*  Copyright (C) 1996 ASM Inc       . All Rights Reserved.                     *
*                                                                              *
*******************************************************************************/

#xcommand LOGOUT [<(a)>] => FSWSLOGOUT( <(a)> )


/*******************************************************************************
*                                                                              *
*   COMMAND NAME: CLEAR STATION                                                *
*    DESCRIPTION: Emulates syntax of Novell's CLEAR STATION console utility    *
*                                                                              *
*  Copyright (C) 1996 ASM Inc       . All Rights Reserved.                     *
*                                                                              *
*******************************************************************************/

#xcommand CLEAR STATION <x> => WSCONCLR( <x> )


/*******************************************************************************
*                                                                              *
*   COMMAND NAME: GRANT                                                        *
*    DESCRIPTION: Emulates syntax of Novell's GRANT.EXE command line utility   *
*                                                                              *
*  Copyright (C) 1996 ASM Inc       . All Rights Reserved.                     *
*                                                                              *
*******************************************************************************/

#xcommand GRANT [<a:ALL>] ;
	       [<b:N,NO RIGHTS>] ;
	       [<c:S,SUPERVISORY>] ;
	       [<d:R,READ>] ;
	       [<e:W,WRITE>] ;
	       [<f:C,CREATE>] ;
	       [<g:E,ERASE>] ;
	       [<h:M,MODIFY>] ;
	       [<i:F,FILE SCAN>] ;
	       [<j:A,ACCESS CONTROL>];
         [FOR <(k)>] TO [<l:USER>] [<m:GROUP>] <(n)> ;
	 => ;
	 NlGrant( <(a)>, <(b)>, <(c)>, <(d)>, <(e)>, <(f)>, <(g)>, <(h)>,;
		  <(i)>, <(j)>, <(k)>, <(l)>, <(m)>, <(n)> )


/*******************************************************************************
*                                                                              *
*   COMMAND NAME: REMOVE                                                       *
*    DESCRIPTION: Emulates syntax of Novell's REMOVE.EXE command line utility  *
*                                                                              *
*  Copyright (C) 1996 ASM Inc       . All Rights Reserved.                     *
*                                                                              *
*******************************************************************************/

#xcommand REMOVE [<a:USER>] ;
		[<b:GROUP>] ;
		<(c)> FROM <(d)> ;
	 => ;
   DIROBJDEL( OBJIDGET( <(c)>, if( <(b)> == NIL, 1, 2 ) ), <(d)> )


/*******************************************************************************
*                                                                              *
*   COMMAND NAME: MAP                                                          *
*    DESCRIPTION: Emulates syntax of Novell's MAP.EXE command line utility     *
*                                                                              *
*  Copyright (C) 1996 ASM Inc       . All Rights Reserved.                     *
*                                                                              *
*******************************************************************************/

#xcommand MAP [<a:ROOT>] ;
	     [<b:INS,INSERT>] ;
			 [<c:DEL,DELETE,REM,REMOVE>] ;
			 [<d:N,NEXT>];
	     <(e)> ;
	 =>;
	 NlMap( <.a.>, <.b.>, <.c.>, <.d.>, <(e)> )


/*******************************************************************************
*                                                                              *
*   COMMAND NAME: MKDIR                                                        *
*    DESCRIPTION: Emulates syntax of DOS's MAKEDIR command line utility        *
*                                                                              *
*  Copyright (C) 1996 ASM Inc       . All Rights Reserved.                     *
*                                                                              *
*******************************************************************************/

#xcommand MKDIR <(a)> => FSDIRADD( <(a)>, 255 )

#xcommand MD <(a)>    => FSDIRADD( <(a)>, 255 )

/*******************************************************************************
*                                                                              *
*   COMMAND NAME: RMDIR                                                        *
*    DESCRIPTION: Emulates syntax of DOS's REMOVEDIR command line utility      *
*                                                                              *
*  Copyright (C) 1996 ASM Inc       . All Rights Reserved.                     *
*                                                                              *
*******************************************************************************/

#xcommand RMDIR <(a)> => FSDIRDEL( <(a)> )

#xcommand RM <(a)>    => FSDIRDEL( <(a)> )

/*******************************************************************************
*                                                                              *
*   COMMAND NAME: RENDIR                                                       *
*    DESCRIPTION: Emulates syntax of Novell's RENDIR command line utility      *
*                                                                              *
*  Copyright (C) 1996 ASM Inc       . All Rights Reserved.                     *
*                                                                              *
*******************************************************************************/

#xcommand RENDIR <(a)> <(b)> => DIRNMECHG( <(a)>, <(b)> )

#xcommand SEND <(a)> [TO] [<b:USER>] ;
          [<c:GROUP>] [<d:STATION>] <(e)> ;
          => NLSend( <(a)>, <(b)>, <(c)>, <(d)>, <(e)> )

#xcommand CASTON => WSMSGMDESET( 0 )

#xcommand CASTOFF [<a:ALL>] => WSMSGMDESET( if( <(a)> == NIL , 1, 2 ) )


/*******************************************************************************
*                                                                              *
*   COMMAND NAME: CAPTURE                                                      *
*    DESCRIPTION: Emulates syntax of Novell's CAPTURE.EXE command line utility *
*                                                                              *
*  Copyright (C) 1996 ASM Inc       . All Rights Reserved.                     *
*                                                                              *
*******************************************************************************/

#xcommand CAPTURE [S=<(a)>] [SERVER=<(a)>] [/S=<(a)>] [/SERVER=<(a)>] ;
		 [L=<(b)>] [LOCAL=<(b)>] [/L=<(b)>] [/LOCAL=<(b)>] ;
		 [P=<(c)>] [PRINTER=<(c)>] [/P=<(c)>] [/PRINTER=<(c)>] ;
		 [Q=<(d)>] [QUEUE=<(d)>] [/Q=<(d)>] [/QUEUE=<(d)>] ;
		 [F=<(e)>] [FORM=<(e)>] [/F=<(e)>] [/FORM=<(e)>] ;
		 [C=<(f)>] [COPIES=<(f)>] [/C=<(f)>] [/COPIES=<(f)>] ;
		 [TI=<(g)>] [TIMEOUT=<(g)>] [/TI=<(g)>] [/TIMEOUT=<(g)>] ;
		 [NAM=<(h)>] [NAME=<(h)>] [/NAM=<(h)>] [/NAME=<(h)>] ;
		 [T=<(i)>] [TABS=<(i)>] [/T=<(i)>] [/TABS=<(i)>] ;
		 [B=<(j)>] [BANNER=<(j)>] [/B=<(j)>] [/BANNER=<(j)>] ;
		 [<k:K,KEEP,/K,/KEEP>] ;
		 [<l:FF,FORMFEED,/FF,/FORMFEED>] ;
		 [<m:NFF,NOFORMFEED,/NFF,/NOFORMFEED>] ;
		 [<n:NT,NOTABS,/NT,/NOTABS>] ;
		 [<o:NB,NOBANNER,/NB,/NOBANNER>] ;
     [J=<(p)>] [JOB=<(p)>] [/J=<(p)>] [/JOB=<(p)>];
	 => ;
	 NlCapture( <(a)>, <(b)>, <(c)>, <(d)>, <(e)>, <(f)>, <(g)>, <(h)>, ;
        <(i)>, <(j)>, <(k)>, <(l)>, <(m)>, <(n)>, <(o)>, <(p)>)

/*******************************************************************************
*                                                                              *
*   COMMAND NAME: ENDCAP                                                       *
*    DESCRIPTION: Emulates syntax of Novell's ENDCAP.EXE command line utility  *
*                                                                              *
*  Copyright (C) 1996 ASM Inc       . All Rights Reserved.                     *
*                                                                              *
*******************************************************************************/

#xcommand ENDCAP [L=<(a)>] [LOCAL=<(a)>] [/L=<(a)>] [/LOCAL=<(a)>] ;
		[<b:ALL,/ALL>] [<c:C,CANCEL,/C,/CANCEL>] ;
		[CL=<(d)>] [CANCELLOCAL=<(d)>] [/CL=<(d)>] [/CANCELLOCAL=<(d)>] ;
	 => Nlendcap( <(a)>, <(b)>, <(c)>, <(d)> )

/* SysTime */

#xcommand SYSTIME <(a)> => NLSysTime( <(a)> )

/* PURGE */

#xcommand PURGE [<(a)>] => FSFILEPURGE( <(a)> )


