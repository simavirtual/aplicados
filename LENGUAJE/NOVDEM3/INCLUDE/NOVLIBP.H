/**************************************************************
*
* NOVLIBP.H     96.05.12
*
* NOVLIB 3.x header for C/C++ (Pascal convention)
*
* Copyright (C) ASM Inc, 1992 - 1996
*
***************************************************************/

#ifndef __NOVDEF__
  #ifdef __TURBOC__
    #if ( __TURBOC__ < 0x0300 )
      #define _far  far
    #endif
  #ifdef __LARGE__
    #define FAR  _far
  #else
    #define FAR
  #endif
  #else
    #ifdef _MSC_VER
      #if ( _MSC_VER <= 600 )
        #define _far  far
      #endif
      #ifdef M_I86LM
        #define FAR  _far
      #else
        #define FAR
      #endif
    #else
      #define FAR  _far
    #endif
  #endif

  /* Global definitions */
  typedef int                 BOOL;
  typedef unsigned char       BYTE;
  typedef unsigned short      WORD;
  typedef unsigned long       DWORD;
  typedef unsigned int        UINT;
  typedef short               SINT;
  typedef char FAR*           LPSTR;
  typedef const char FAR*     LPCSTR;
  typedef BYTE FAR*           LPBYTE;
  typedef int FAR*            LPINT;
  typedef WORD FAR*           LPWORD;
  typedef long FAR*           LPLONG;
  typedef DWORD FAR*          LPDWORD;
  typedef void FAR*           LPVOID;

  #define LONG                long
  #define ERRCODE             int
  #define RETCODE             int

  /* NOVLIB error returns */

  #define NOVERRLONG          0xffffffff   // (DWORD)-1L
  #define NOVERRINT           0xffff       // (int)-1

  /* Various defines */

  #define NOVNODSKRES         (DWORD)-255L
  #define NOVNOVOLRES         (DWORD)-255L
  #define NOVLOKWILD          (WORD)0
  #define NOVLOKCLIPPER       (WORD)1
  #define NOVLOKNTX2          (WORD)2
  #define NOVLOKFOX1          (WORD)3
  #define NOVLOKFOX2          (WORD)4

  /* dummy values for missing parameters */

  #define NOVDEFLONG          (DWORD)-1L
  #define NOVDEFINT           (WORD)-1

  #define __NOVDEF__
#endif

#ifndef __NOVLIBP__

  #define NOVLIBP   _far pascal

  #ifdef __cplusplus
     // prevent name mangling for C++
     extern "C" {
  #endif

  /* A1 */

  LONG    NOVLIBP  USRACCOUNTRESERVEGET( LPSTR UserName, LPSTR Control );
  BOOL    NOVLIBP  USRACCOUNTRESERVESET( LPSTR ObjectName, DWORD ReserveAmount );
  BOOL    NOVLIBP  USRACCOUNTCHARGEADD( LPSTR ObjectName, WORD ServiceType, DWORD ChargeAmount, WORD CommentType, LPSTR Comment );
  BOOL    NOVLIBP  USRACCOUNTCHARGEDELETE( LPSTR ObjectName, WORD ServiceType, DWORD CancelHold, WORD CommentType, LPSTR Comment );

  /* B1 */

   LPSTR   NOVLIBP  OBJNAMEGET( DWORD ObjectID, LPSTR userbuff );
   WORD    NOVLIBP  OBJTYPEGET( DWORD ObjectID );
   DWORD   NOVLIBP  OBJIDGET( LPSTR ObjectName, WORD ObjectType );

  /* B2 */

   BOOL    NOVLIBP  OBJPASSWORDCHECK( LPSTR ObjectName, LPSTR PassWord, WORD ObjectType );
   BOOL    NOVLIBP  OBJPASSWORDCHANGE( LPSTR ObjectName, LPSTR PassWord1, LPSTR PassWord2, WORD ObjectType );

  /* B3 */

   BOOL    NOVLIBP  SETPROPERTYIDTEST( LPSTR ObjectName, WORD ObjectType, LPSTR MemberName, WORD MemberType, LPSTR PropertyName );

  /* B4 */

   BOOL    NOVLIBP  BINDERY( BOOL OpenCloseFlag );

  /* B5 */

   DWORD   NOVLIBP  USRDIRCOUNTGET( WORD VolNumber, DWORD ObjectID );
   DWORD   NOVLIBP  USRFILECOUNTGET( WORD VolNumber, DWORD ObjectID );
   DWORD   NOVLIBP  USRDISKBLOCKGET( WORD VolNumber, DWORD ObjectID );
   DWORD   NOVLIBP  USRDISKFREEGET( DWORD ObjectID );
   DWORD   NOVLIBP  USRVOLUMEFREEGET( WORD VolNumber, DWORD ObjectID );
   DWORD   NOVLIBP  USRVOLUMERESTRICTGET( WORD VolNumber, DWORD ObjectID );
   DWORD   NOVLIBP  USRVOLUMERESTRICTSET( WORD VolNumber, DWORD ObjectID, DWORD Restriction );


  /* B6 */

   BOOL    NOVLIBP  FSUSERADD( LPSTR ObjectName, LPSTR Password );
   BOOL    NOVLIBP  FSGROUPADD( LPSTR ObjectName);
   BOOL    NOVLIBP  FSOBJECTDELETE( LPSTR ObjectName, WORD ObjectType );
   BOOL    NOVLIBP  FSOBJECTADD( LPSTR ObjectName, WORD ObjectType, WORD ObjectFlag, WORD ObjectSec );
   BOOL    NOVLIBP  OBJNAMECHANGE( LPSTR OldName, LPSTR NewName, WORD ObjectType );

  /* B7 */

   BOOL    NOVLIBP  GRPUSERADD( LPSTR SourceObj, LPSTR TargetObj );
   BOOL    NOVLIBP  GRPUSERDELETE( LPSTR SourceObj, LPSTR TargetObj );
   BOOL    NOVLIBP  SETPROPERTYIDADD( LPSTR ObjectName, WORD ObjectType, LPSTR MemberName, WORD MemberType, LPSTR PropertyName );
   BOOL    NOVLIBP  SETPROPERTYIDDELETE( LPSTR ObjectName, WORD ObjectType, LPSTR MemberName, WORD MemberType, LPSTR PropertyName );

  /* B8 */

   LPSTR   NOVLIBP  FSOBJECTLIST( LPSTR ObjectName, WORD ObjectType, BOOL StartFlag, LPSTR userbuff );
   WORD    NOVLIBP  OBJFLAGGET( LPSTR ObjectName, WORD ObjectType );
   WORD    NOVLIBP  OBJSECURITYGET( LPSTR ObjectName, WORD ObjectType );
   BOOL    NOVLIBP  OBJPROPERTYTEST( LPSTR ObjectName, WORD ObjectType );

  /* B9 */

   LPSTR   NOVLIBP  USRFULLNAMESET( LPSTR ObjectName, LPSTR FullName, LPSTR userbuff );
   LPSTR   NOVLIBP  USRFULLNAMEGET( LPSTR ObjectName, LPSTR userbuff );
   LPSTR   NOVLIBP  ITMPROPERTYSTRINGSET( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, WORD Segment, LPSTR Value, LPSTR userbuff );
   LPSTR   NOVLIBP  ITMPROPERTYSTRINGGET( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, WORD Segment, LPSTR userbuff );
   LPBYTE  NOVLIBP  ITMPROPERTYVALUESET( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, WORD Segment, LPBYTE Value, LPBYTE userbuff );
   LPBYTE  NOVLIBP  ITMPROPERTYVALUEGET( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, WORD Segment, LPBYTE userbuff );
   DWORD   NOVLIBP  SETPROPERTYVALUEGET( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, WORD Element );
   DWORD   NOVLIBP  SETPROPERTYVALUESET( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, WORD Element, DWORD Value );
   WORD    NOVLIBP  ITMPROPERTYBYTESET( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, WORD Element, LPSTR Value );
   WORD    NOVLIBP  ITMPROPERTYBYTEGET( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, WORD Element );
   BOOL    NOVLIBP  OBJPROPERTYADD( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, BYTE PropertyFlags, BYTE PropertySecurity );

  /* BA */

   RETCODE NOVLIBP  FSWSATTACH( LPSTR ServerName );
   RETCODE NOVLIBP  FSCONNIDGET( LPSTR ServerName );

  /* BB */

   LPSTR   NOVLIBP  OBJPROPERTYLIST( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, BOOL StartFlag, LPSTR userbuff );
   RETCODE NOVLIBP  PRPFLAGGET( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName );
   RETCODE NOVLIBP  PRPSECURITYGET( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName );
   BOOL    NOVLIBP  PRPVALUETEST( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName );

  /* BC */

   BOOL    NOVLIBP  OBJPROPERTYDELETE( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName );

  /* C1 */

   RETCODE NOVLIBP  WSCONNNUMBERGET( void );
   LPSTR   NOVLIBP  WSLOGINNAMEGET( WORD ConnNum, LPSTR userbuff );
   RETCODE NOVLIBP  WSLOGINTYPEGET( WORD ConnNum );
   DWORD   NOVLIBP  WSLOGINIDGET( WORD ConnNum );
   LPSTR   NOVLIBP  WSLOGINDATEGET( WORD ConnNum, LPSTR userbuff );
   LPSTR   NOVLIBP  WSLOGINTIMEGET( WORD ConnNum, LPSTR userbuff );

  /* C2 */

   BOOL    NOVLIBP  WSCONNCLEAR( WORD ConnNum );

  /* C3 */

   RETCODE NOVLIBP  FILLOCKCONNGET( LPSTR FileSpec, DWORD RecNo, WORD Format );

  /* C4 */

   RETCODE NOVLIBP  USRCONNLIST( LPSTR ObjectName );

  /* C5 */

   BOOL    NOVLIBP  CONNUSED( WORD ConnectionEntry );

  /* C6 */

   BOOL    NOVLIBP  FSWSLOGIN( LPSTR ObjectName, LPSTR Password, WORD ObjectType );
   BOOL    NOVLIBP  FSWSLOGOUT( LPSTR ServerName, BOOL DetachFlag );
   BOOL    NOVLIBP  FSWSDETACH( LPSTR ServerName );

  /* C7 */

   LPSTR   NOVLIBP  WSNETADDRESSGET( WORD ConnNo, LPSTR userbuff );
   LPSTR   NOVLIBP  WSNODEADDRESSGET( WORD ConnNo, LPSTR userbuff );

  /* C8 */

   BOOL    NOVLIBP  USRCURCONSOLEOPERATORTEST( void );
   RETCODE NOVLIBP  FSREADLEVELGET( void );
   RETCODE NOVLIBP  FSWRITELEVELGET( void );

  /* D1 */

   BOOL    NOVLIBP  DIROBJECTADD( DWORD ObjectID, LPSTR FileName, WORD RightsMask );
   BOOL    NOVLIBP  DIROBJECTDELETE( DWORD ObjectID, LPSTR FileName );
   RETCODE NOVLIBP  DRVDIRHANDLEGET( WORD Drive );
   RETCODE NOVLIBP  DRVFLAGGET( WORD Drive );
   LPSTR   NOVLIBP  DRVCURRENTGET( LPSTR userbuff );
   LPSTR   NOVLIBP  DRVCURRENTSET( LPSTR Drive, LPSTR userbuff );

  /* D2 */

   RETCODE NOVLIBP  DIREFFECTIVERIGHTSGET( LPSTR FileName );

  /* D3 */

   RETCODE NOVLIBP  WSENVFREEGET( void );
   RETCODE NOVLIBP  WSENVSIZEGET( void );
   LPSTR   NOVLIBP  WSENVVARIABLEGET( LPSTR VarName, LPSTR userbuff );
   LPSTR   NOVLIBP  WSENVVARIABLESET( LPSTR VarName, LPSTR NewVar, LPSTR userbuff );
   BOOL    NOVLIBP  SCHVECTORPATHSET( void );
   LPSTR   NOVLIBP  SCHORDERDRIVEGET( WORD SearchOrder, LPSTR userbuff );
   BOOL    NOVLIBP  SCHVECTORDRIVEDELETE( WORD SearchOrder );
   RETCODE NOVLIBP  DRVSEARCHORDERGET( LPSTR Drive );
   RETCODE NOVLIBP  DRVDIRMAP( LPSTR Path, LPSTR Drive, WORD Temp );
   BOOL    NOVLIBP  DRVMAPDELETE( LPSTR Drive );
   BOOL    NOVLIBP  SCHDRIVEMAPDELETE( WORD SearchOrder );
   LPSTR   NOVLIBP  SCHVECTORGET( LPSTR userbuff );
   LPSTR   NOVLIBP  SCHVECTORSET( LPSTR NewVector, LPSTR userbuff );
   RETCODE NOVLIBP  WSDRIVELOCALGET( void );
   BOOL    NOVLIBP  SCHVECTORDRIVEADD( LPSTR Drive, WORD SearchOrder );
   RETCODE NOVLIBP  SCHDRIVEDIRMAP( LPSTR Drive, LPSTR Path, WORD SearchOrder );
   LPSTR   NOVLIBP  WSDRIVENETGET( LPSTR userbuff );
   LPSTR   NOVLIBP  DRVNEXTFREEGET( LPSTR userbuff );
   BOOL    NOVLIBP  DRVROOTMAP( LPSTR Drive, LPSTR Path );

  /* D4 */

   LPSTR   NOVLIBP  OBJDIRLIST( WORD VolNumber, DWORD ObjectID, BOOL StartFlag, LPSTR userbuff );
   RETCODE NOVLIBP  DIRACCESSRIGHTSGET( void );
   LPSTR   NOVLIBP  NOVRIGHTSSTRING( WORD TrusteeRights, LPSTR userbuff );
   WORD    NOVLIBP  NOVRIGHTSVALUE( LPSTR Mask );

  /* D5 */

   RETCODE NOVLIBP  VOLNUMBERGET( LPSTR VolName );
   LPSTR   NOVLIBP  VOLNAMEGET( WORD VolNumber, LPSTR userbuff );
   DWORD   NOVLIBP  VOLBLOCKMAXGET( WORD VolNumber );
   RETCODE NOVLIBP  VOLBLOCKSIZEGET( WORD VolNumber );
   DWORD   NOVLIBP  VOLBLOCKFREEGET( WORD VolNumber );
   DWORD   NOVLIBP  VOLBLOCKPURGEGET( WORD VolNumber );
   DWORD   NOVLIBP  VOLBLOCKNOTPURGEGET( WORD VolNumber );
   DWORD   NOVLIBP  VOLDIRMAXGET( WORD VolNumber );
   DWORD   NOVLIBP  VOLDIRFREEGET( WORD VolNumber );
   BOOL    NOVLIBP  VOLREMOVEABLETEST( WORD VolNumber );

  /* D6 */

   BOOL    NOVLIBP  FSDIRADD( LPSTR Directory, WORD Rights );
   BOOL    NOVLIBP  FSDIRDELETE( LPSTR Directory );
   BOOL    NOVLIBP  DIRNAMECHANGE( LPSTR Directory, LPSTR NewName );

  /* D7 */

   LPSTR   NOVLIBP  NEPHILIM( LPSTR FileSpec, WORD Attributes, LPSTR userbuff );
   LPSTR   NOVLIBP  DIRSUBDIRLIST( LPSTR FileSpec, LPSTR NewName, LPSTR userbuff );
   DWORD   NOVLIBP  DIRATTRIBUTEGET( LPSTR FileSpec );
   DWORD   NOVLIBP  DIRATTRIBUTESET( LPSTR FileSpec, DWORD Attributes );
   RETCODE NOVLIBP  DIRTYPEGET( LPSTR FileSpec );
   LPSTR   NOVLIBP  DIRCREATEDATEGET( LPSTR FileSpec, LPSTR userbuff );
   LPSTR   NOVLIBP  DIRCREATEDATESET( LPSTR FileSpec, LPSTR Date, LPSTR userbuff );
   LPSTR   NOVLIBP  DIRCREATETIMEGET( LPSTR FileSpec, LPSTR userbuff );
   LPSTR   NOVLIBP  DIRCREATETIMESET( LPSTR FileSpec, LPSTR Time, LPSTR userbuff );
   DWORD   NOVLIBP  DIROWNERIDGET( LPSTR FileSpec );
   DWORD   NOVLIBP  DIROWNERIDSET( LPSTR FileSpec, DWORD NewID );
   LPSTR   NOVLIBP  DIRARCHIVEDATEGET( LPSTR FileSpec, LPSTR userbuff );
   LPSTR   NOVLIBP  DIRARCHIVEDATESET( LPSTR FileSpec, LPSTR Date, LPSTR userbuff );
   LPSTR   NOVLIBP  DIRARCHIVETIMEGET( LPSTR FileSpec, LPSTR userbuff );
   LPSTR   NOVLIBP  DIRARCHIVETIMESET( LPSTR FileSpec, LPSTR Time, LPSTR userbuff );
   DWORD   NOVLIBP  DIRARCHIVEIDGET( LPSTR FileSpec );
   DWORD   NOVLIBP  DIRARCHIVEIDSET( LPSTR FileSpec, DWORD ObjectID );
   LPSTR   NOVLIBP  DIRMODIFYDATEGET( LPSTR FileSpec, LPSTR userbuff );
   LPSTR   NOVLIBP  DIRMODIFYDATESET( LPSTR FileSpec, LPSTR Date, LPSTR userbuff );
   LPSTR   NOVLIBP  DIRMODIFYTIMEGET( LPSTR FileSpec, LPSTR userbuff );
   LPSTR   NOVLIBP  DIRMODIFYTIMESET( LPSTR FileSpec, LPSTR Time, LPSTR userbuff );
   RETCODE NOVLIBP  DIRIRMASKGET( LPSTR FileSpec );
   RETCODE NOVLIBP  DIRIRMASKSET( LPSTR FileSpec, WORD Mask );
   LPSTR   NOVLIBP  DIRFILELIST( LPSTR FileSpec, LPSTR NewName, LPSTR userbuff );
   DWORD   NOVLIBP  FILATTRIBUTEGET( LPSTR FileSpec );
   DWORD   NOVLIBP  FILATTRIBUTESET( LPSTR FileSpec, DWORD NewAttributes );
   RETCODE NOVLIBP  FILTYPEGET( LPSTR FileSpec );
   LPSTR   NOVLIBP  FILCREATEDATEGET( LPSTR FileSpec, LPSTR userbuff );
   LPSTR   NOVLIBP  FILCREATEDATESET( LPSTR FileSpec, LPSTR Date, LPSTR userbuff );
   LPSTR   NOVLIBP  FILCREATETIMEGET( LPSTR FileSpec, LPSTR userbuff );
   LPSTR   NOVLIBP  FILCREATETIMESET( LPSTR FileSpec, LPSTR Time, LPSTR userbuff );
   DWORD   NOVLIBP  FILOWNERIDGET( LPSTR FileSpec );
   DWORD   NOVLIBP  FILOWNERIDSET( LPSTR FileSpec, DWORD ObjectID );
   LPSTR   NOVLIBP  FILARCHIVEDATEGET( LPSTR FileSpec, LPSTR userbuff );
   LPSTR   NOVLIBP  FILARCHIVEDATESET( LPSTR FileSpec, LPSTR Date, LPSTR userbuff );
   LPSTR   NOVLIBP  FILARCHIVETIMEGET( LPSTR FileSpec, LPSTR userbuff );
   LPSTR   NOVLIBP  FILARCHIVETIMESET( LPSTR FileSpec, LPSTR Time, LPSTR userbuff );
   DWORD   NOVLIBP  FILARCHIVEIDGET( LPSTR FileSpec );
   DWORD   NOVLIBP  FILARCHIVEIDSET( LPSTR FileSpec, DWORD ObjectID );
   LPSTR   NOVLIBP  FILMODIFYDATEGET( LPSTR FileSpec, LPSTR userbuff );
   LPSTR   NOVLIBP  FILMODIFYDATESET( LPSTR FileSpec, LPSTR Date, LPSTR userbuff );
   LPSTR   NOVLIBP  FILMODIFYTIMEGET( LPSTR FileSpec, LPSTR userbuff );
   LPSTR   NOVLIBP  FILMODIFYTIMESET( LPSTR FileSpec, LPSTR Time, LPSTR userbuff );
   DWORD   NOVLIBP  FILMODIFYIDGET( LPSTR FileSpec );
   DWORD   NOVLIBP  FILMODIFYIDSET( LPSTR FileSpec, DWORD ObjectID );
   LPSTR   NOVLIBP  FILACCESSDATEGET( LPSTR FileSpec, LPSTR userbuff );
   LPSTR   NOVLIBP  FILACCESSDATESET( LPSTR FileSpec, LPSTR Date, LPSTR userbuff );
   RETCODE NOVLIBP  FILIRMASKGET( LPSTR FileSpec );
   RETCODE NOVLIBP  FILIRMASKSET( LPSTR FileSpec, WORD Mask );
   LPSTR   NOVLIBP  NOVATTRIBUTESTRING( DWORD Rights, LPSTR userbuff );
   DWORD   NOVLIBP  NOVATTRIBUTEVALUE( LPSTR Mask );

  /* D8 */

   LPSTR   NOVLIBP  DRVPATHGET( LPSTR Drive, LPSTR userbuff );
   RETCODE NOVLIBP  DRVFSIDGET( LPSTR Drive );
   RETCODE NOVLIBP  DRVDIRDEPTHGET( LPSTR Drive );

  /* D9 */

   DWORD   NOVLIBP  FILNETCOPY( LPSTR SourceFile, LPSTR DestFile, DWORD SourceOffset, DWORD DestOffset, DWORD NumOfBytes );

  /* DA */

   DWORD   NOVLIBP  DFLDIRENTRYGET( void );
   LPSTR   NOVLIBP  DIRDELETEDFILELIST( LPSTR Path, LPSTR userbuff );
   DWORD   NOVLIBP  DFLATTRIBUTEGET( void );
   RETCODE NOVLIBP  DFLTYPEGET( void );
   LPSTR   NOVLIBP  DFLARCHIVEDATEGET( LPSTR userbuff );
   LPSTR   NOVLIBP  DFLARCHIVETIMEGET( LPSTR userbuff);
   DWORD   NOVLIBP  DFLARCHIVEIDGET( void );
   LPSTR   NOVLIBP  DFLMODIFYDATEGET( LPSTR userbuff);
   LPSTR   NOVLIBP  DFLMODIFYTIMEGET( LPSTR userbuff);
   DWORD   NOVLIBP  DFLMODIFYIDGET( void );
   LPSTR   NOVLIBP  DFLACCESSDATEGET( LPSTR userbuff );
   LPSTR   NOVLIBP  DFLDELETEDATEGET( LPSTR userbuff );
   LPSTR   NOVLIBP  DFLDELETETIMEGET( LPSTR userbuff );
   DWORD   NOVLIBP  DFLDELETEIDGET( void );

  /* I3 */

   BOOL    NOVLIBP  IPXINSTALLED( void );
   RETCODE NOVLIBP  IPXOPEN( WORD Socket );
   void    NOVLIBP  IPXSOCKETCLOSE( void );

  /* I7 */

   LPSTR   NOVLIBP  IPXADDRESSGET(LPSTR userbuff);
   ERRCODE NOVLIBP  IPXPACKETSEND( LPSTR FarAddress, LPBYTE Packet, WORD PacketLength );
   ERRCODE NOVLIBP  IPXSOCKETOPEN( WORD Socket );
   LPBYTE  NOVLIBP  IPXPACKETGET( LPBYTE userbuff, LPWORD PacketLength );
   WORD    NOVLIBP  IPXSOCKETNUMBERGET( void );

  /* M1 */

   BOOL    NOVLIBP  FSMESSAGELOG( LPSTR Message );
   BOOL    NOVLIBP  FSMESSAGESEND( LPSTR Message );
   BOOL    NOVLIBP  WSMESSAGESEND( WORD Connection, LPSTR Message );
   RETCODE NOVLIBP  WSMESSAGEMODESET( WORD Mode );
   RETCODE NOVLIBP  WSMESSAGEMODEGET( void );
   LPSTR   NOVLIBP  WSMESSAGEGET( LPSTR userbuff );

  /* N7 */

   LPSTR   NOVLIBP  NOVVERSIONGET( LPSTR userbuff );
   ERRCODE NOVLIBP  NWERRORGET( void );
   ERRCODE NOVLIBP  NWGETERRORGET( void );
   ERRCODE NOVLIBP  NWSETERRORGET( void );
   BOOL    NOVLIBP  GOTHIC( void );
   WORD    NOVLIBP  NOVINTSWAP( WORD Value );
   DWORD   NOVLIBP  NOVLONGSWAP( DWORD Value );
   BOOL    NOVLIBP  NOVINIT( void );

  /* O1 */

   void    NOVLIBP  NOVSCRPRT( void );

  /* O2 */

   BOOL    NOVLIBP  FSWSSYNCRONIZE( void );

  /* P1 */

   BOOL    NOVLIBP  FSPRINTERSTOPPEDTEST( WORD Printer );
   BOOL    NOVLIBP  FSPRINTEROFFLINETEST( WORD Printer );
   RETCODE NOVLIBP  FSPRINTERFORMGET( WORD Printer );
   RETCODE NOVLIBP  FSPRINTERNUMBERGET( WORD Printer );

  /* P2 */

   BOOL    NOVLIBP  CAPSTART( WORD LPTPort );
   BOOL    NOVLIBP  CAPEND( WORD LPTPort );
   BOOL    NOVLIBP  CAPFLUSH( WORD LPTPort );
   BOOL    NOVLIBP  CAPCANCEL( WORD LPTPort );
   RETCODE NOVLIBP  DEFAULTLPT( WORD LPTPort );

  /* P3 */

   LPSTR   NOVLIBP  CAPFSGET( WORD LPTPort, LPSTR userbuff );
   LPSTR   NOVLIBP  CAPSETUPSTRINGGET( WORD LPTPort, LPSTR userbuff );
   LPSTR   NOVLIBP  CAPSETUPSTRINGSET( WORD LPTPort, LPSTR NewString, LPSTR userbuff );
   LPSTR   NOVLIBP  CAPRESETSTRINGGET( WORD LPTPort, LPSTR userbuff );
   LPSTR   NOVLIBP  CAPRESETSTRINGSET( WORD LPTPort, LPSTR NewString, LPSTR userbuff );
   BOOL    NOVLIBP  CAPKEEPGET( WORD LPTPort);
   BOOL    NOVLIBP  CAPKEEPSET( WORD LPTPort, BOOL Flag );
   BOOL    NOVLIBP  CAPAUTOENDGET( WORD LPTPort);
   BOOL    NOVLIBP  CAPAUTOENDSET( WORD LPTPort, BOOL Flag );
   BOOL    NOVLIBP  CAPFORMFEEDGET( WORD LPTPort );
   BOOL    NOVLIBP  CAPFORMFEEDSET( WORD LPTPort, BOOL Flag );
   BOOL    NOVLIBP  CAPBANNERFLAGGET( WORD LPTPort );
   BOOL    NOVLIBP  CAPBANNERFLAGSET( WORD LPTPort, BOOL Flag );
   BOOL    NOVLIBP  CAPTABFLAGGET( WORD LPTPort );
   BOOL    NOVLIBP  CAPTABFLAGSET( WORD LPTPort, BOOL Flag );
   BOOL    NOVLIBP  CAPNOTIFYFLAGGET( WORD LPTPort );
   BOOL    NOVLIBP  CAPNOTIFYFLAGSET( WORD LPTPort, BOOL Flag );
   BOOL    NOVLIBP  CAPSETUP( WORD LPTPort );
   RETCODE NOVLIBP  CAPTABSIZEGET( WORD LPTPort );
   RETCODE NOVLIBP  CAPTABSIZESET( WORD LPTPort, WORD TabSize );
   RETCODE NOVLIBP  CAPFSPRINTERGET( WORD LPTPort );
   RETCODE NOVLIBP  CAPFSPRINTERSET( WORD LPTPort, WORD PRNNo );
   RETCODE NOVLIBP  CAPCOPIESGET( WORD LPTPort );
   RETCODE NOVLIBP  CAPCOPIESSET( WORD LPTPort, WORD Copies );
   RETCODE NOVLIBP  CAPFORMNUMBERGET( WORD LPTPort );
   RETCODE NOVLIBP  CAPFORMNUMBERSET( WORD LPTPort, WORD FormNo );
   RETCODE NOVLIBP  CAPMAXLINEGET( WORD LPTPort );
   RETCODE NOVLIBP  CAPMAXLINESET( WORD LPTPort, WORD NewMax );
   RETCODE NOVLIBP  CAPMAXCHARGET( WORD LPTPort );
   RETCODE NOVLIBP  CAPMAXCHARSET( WORD LPTPort, WORD NewMax );
   RETCODE NOVLIBP  CAPTIMEOUTGET( WORD LPTPort );
   RETCODE NOVLIBP  CAPTIMEOUTSET( WORD LPTPort, WORD NewTime );
   LPSTR   NOVLIBP  CAPBANNERTEXTGET( WORD LPTPort, LPSTR userbuff );
   LPSTR   NOVLIBP  CAPBANNERTEXTSET( WORD LPTPort, LPSTR NewName, LPSTR userbuff );
   LPSTR   NOVLIBP  CAPFORMNAMEGET( WORD LPTPort, LPSTR userbuff );
   LPSTR   NOVLIBP  CAPFORMNAMESET( WORD LPTPort, LPSTR FormName, LPSTR userbuff );
   LPSTR   NOVLIBP  CAPBANNERNAMEGET( LPSTR userbuff );
   LPSTR   NOVLIBP  CAPBANNERNAMESET( LPSTR BannerName, LPSTR userbuff );
   BOOL    NOVLIBP  CAPACTIVETEST( WORD LPTPort );
   DWORD   NOVLIBP  CAPQUEUEGET( WORD LPTPort );
   DWORD   NOVLIBP  CAPQUEUESET( WORD LPTPort, DWORD ObjectID );

  /* Q1 */

   BOOL    NOVLIBP  FSQUEUEADD( LPSTR QueueName, LPSTR Path, WORD Type );

  /* Q2 */

   BOOL    NOVLIBP  QUEADDSTATEGET( DWORD ObjectID );
   BOOL    NOVLIBP  QUEADDSTATESET( DWORD ObjectID, WORD Value );
   BOOL    NOVLIBP  QUESERVICESTATEGET( DWORD ObjectID );
   BOOL    NOVLIBP  QUESERVICESTATESET( DWORD ObjectID, WORD Value );
   BOOL    NOVLIBP  QUEHALTGET( DWORD ObjectID );
   BOOL    NOVLIBP  QUEHALTSET( DWORD ObjectID, BOOL Value );

  /* Q3 */

   RETCODE NOVLIBP  QUEQJBLIST( DWORD ObjectID, BOOL StartFlag );

  /* Q4 */

   DWORD   NOVLIBP  QJBSIZEGET( DWORD ObjectID, WORD JobNum );
   BOOL    NOVLIBP  QUEQJBDELETE( DWORD ObjectID, WORD JobNum );

  /* Q5 */

   LPSTR   NOVLIBP  QJBTIMEGET( DWORD ObjectID, WORD JobNum, LPSTR userbuff );
   LPSTR   NOVLIBP  QJBDATEGET( DWORD ObjectID, WORD JobNum, LPSTR userbuff );
   LPSTR   NOVLIBP  QJBDEFERDATEGET( DWORD ObjectID, WORD JobNum, LPSTR userbuff );
   LPSTR   NOVLIBP  QJBDEFERDATESET( DWORD ObjectID, WORD JobNum, LPSTR NewDate, LPSTR userbuff );
   LPSTR   NOVLIBP  QJBDEFERTIMEGET( DWORD ObjectID, WORD JobNum, LPSTR userbuff );
   LPSTR   NOVLIBP  QJBDEFERTIMESET( DWORD ObjectID, WORD JobNum, LPSTR NewTime, LPSTR userbuff );
   RETCODE NOVLIBP  QJBWSGET( DWORD ObjectID, WORD JobNum );
   DWORD   NOVLIBP  QJBUSERIDGET( DWORD ObjectID, WORD JobNum );
   BOOL    NOVLIBP  QJBADDINGTEST( DWORD ObjectID, WORD JobNum );
   RETCODE NOVLIBP  QJBFLAGGET( DWORD ObjectID, WORD JobNum );
   RETCODE NOVLIBP  QJBFLAGSET( DWORD ObjectID, WORD JobNum, WORD NewFlags );
   BOOL    NOVLIBP  QJBRESTARTGET( DWORD ObjectID, WORD JobNum );
   BOOL    NOVLIBP  QJBRESTARTSET( DWORD ObjectID, WORD JobNum, WORD Restart );
   BOOL    NOVLIBP  QJBOPERATORHOLDGET( DWORD ObjectID, WORD JobNum );
   BOOL    NOVLIBP  QJBOPERATORHOLDSET( DWORD ObjectID, WORD JobNum, WORD Hold );
   BOOL    NOVLIBP  QJBUSERHOLDGET( DWORD ObjectID, WORD JobNum );
   BOOL    NOVLIBP  QJBUSERHOLDSET( DWORD ObjectID, WORD JobNum, WORD Hold );
   LPSTR   NOVLIBP  QJBDESCRIPTIONGET( DWORD ObjectID, WORD JobNum, LPSTR userbuff );
   LPSTR   NOVLIBP  QJBDESCRIPTIONSET( DWORD ObjectID, WORD JobNum, LPSTR Desc, LPSTR userbuff );
   LPSTR   NOVLIBP  QJBFILENAMEGET( DWORD ObjectID, WORD JobNum, LPSTR userbuff );
   RETCODE NOVLIBP  QJBPOSITIONGET( DWORD ObjectID, WORD JobNum );
   RETCODE NOVLIBP  QJBPOSITIONSET( DWORD ObjectID, WORD JobNum, WORD Position );
   RETCODE NOVLIBP  QJBCOPIESGET( DWORD ObjectID, WORD JobNum );
   RETCODE NOVLIBP  QJBCOPIESSET( DWORD ObjectID, WORD JobNum, WORD Copies );
   LPSTR   NOVLIBP  QJBBANNERGET( DWORD ObjectID, WORD JobNum, LPSTR userbuff );
   LPSTR   NOVLIBP  QJBBANNERSET( DWORD ObjectID, WORD JobNum, LPSTR Banner, LPSTR userbuff );

  /* Q6 */

   RETCODE NOVLIBP  QUEFILEADD( DWORD ObjectID, LPSTR FileSpec, WORD Flags, LPSTR Description,
                                     WORD Copies, WORD ControlFlags, DWORD ServerID );

  /* S2 */

   BOOL    NOVLIBP  SPXINSTALLED( void );
   LPSTR   NOVLIBP  SPXVERSIONNUMBERGET( LPSTR userbuff );
   RETCODE NOVLIBP  SPXMAXCONNGET( void );
   RETCODE NOVLIBP  SPXCONNFREEGET( void );
   DWORD   NOVLIBP  PSWSATTACH( LPSTR Pserver );
   BOOL    NOVLIBP  PSWSDETACH( WORD ConnectionNum );
   WORD    NOVLIBP  PSSOCKETNUMBERGET( void );
   WORD    NOVLIBP  PSCONNNUMBERGET( void );
   RETCODE NOVLIBP  PSWSLOGIN( LPSTR Pserver );
   BOOL    NOVLIBP  PSWSLOGOUT( void );
   BOOL    NOVLIBP  PSDOWN( WORD DownNow, WORD OutCome );

  /* S4 */

   BOOL    NOVLIBP  PRNJOBABORT( WORD PrinterNo, WORD OutCome );
   BOOL    NOVLIBP  PRNSTART( WORD PrinterNo );
   BOOL    NOVLIBP  PRNSTOP( WORD PrinterNo, WORD OutCome );
   BOOL    NOVLIBP  PRNEJECT( WORD PrinterNo );
   BOOL    NOVLIBP  PRNNOTIFYOBJECTADD( WORD PrinterNo, LPSTR ServerName, LPSTR ObjectName, WORD FirstTime, WORD NextTime, WORD ObjectType );
   BOOL    NOVLIBP  PRNNOTIFYOBJECTDELETE( WORD PrinterNo, LPSTR ServerName, LPSTR ObjectName, WORD ObjectType );
   BOOL    NOVLIBP  PRNNOTIFYPERIODCHANGE( WORD PrinterNo, LPSTR ServerName, LPSTR ObjectName, WORD FirstTime, WORD NextTime, WORD ObjectType );
   BOOL    NOVLIBP  PRNFORMTOPMARK( WORD PrinterNo, LPSTR MarkChar );

  /* S5 */

   LPSTR   NOVLIBP  PJBFSGET( WORD PrinterNo, LPSTR userbuff );
   LPSTR   NOVLIBP  PJBQUEUEGET( WORD PrinterNo, LPSTR userbuff );
   RETCODE NOVLIBP  PJBNUMBERGET( WORD PrinterNo );
   LPSTR   NOVLIBP  PJBDESCRIPTIONGET( WORD PrinterNo, LPSTR userbuff );
   RETCODE NOVLIBP  PJBCOPYTODOGET( WORD PrinterNo );
   DWORD   NOVLIBP  PJBSIZEGET( WORD PrinterNo );
   RETCODE NOVLIBP  PJBCOPYDONEGET( WORD PrinterNo );
   DWORD   NOVLIBP  PJBBYTESDONEGET( WORD PrinterNo );
   RETCODE NOVLIBP  PJBFORMNUMBERGET( WORD PrinterNo );
   BOOL    NOVLIBP  PJBTEXTTEST( WORD PrinterNo );

  /* S6 */

   RETCODE NOVLIBP  PRNSTATUSGET( WORD PrinterNo );
   RETCODE NOVLIBP  PRNERRORSTATUSGET( WORD PrinterNo );
   BOOL    NOVLIBP  PJBACTIVETEST( WORD PrinterNo );
   RETCODE NOVLIBP  PRNQUEUEMODEGET( WORD PrinterNo, WORD Mode );
   RETCODE NOVLIBP  PRNFORMNUMBERGET( WORD PrinterNo );
   RETCODE NOVLIBP  PRNFORMNUMBERSET( WORD PrinterNo, WORD FormNum );
   LPSTR   NOVLIBP  PRNFORMNAMEGET( WORD PrinterNo, LPSTR userbuff );
   LPSTR   NOVLIBP  PRNNAMEGET( WORD PrinterNo, LPSTR userbuff );

  /* S7 */

   BOOL    NOVLIBP  PJBREWIND( WORD PrinterNo, WORD ByPage, WORD Relative, WORD Copy, LONG Offset );

  /* S8 */

   BOOL    NOVLIBP  PRNQUEUEADD( WORD PrinterNo, LPSTR ServerName, LPSTR QueueName, WORD Priority );
   BOOL    NOVLIBP  PRNQUEUEPRIORITYCHANGE( WORD PrinterNo, LPSTR ServerName, LPSTR QueueName, WORD Priority );
   BOOL    NOVLIBP  PRNQUEUEDELETE( WORD PrinterNo, LPSTR ServerName, LPSTR QueueName, WORD Kill, WORD OutCome );

  /* S9 */

   LPSTR   NOVLIBP  PRNQUEUELIST( WORD PrinterNumber, BOOL StartFlag, LPSTR userbuff );
   LPSTR   NOVLIBP  PRNQUEUEFSGET( LPSTR userbuff);
   RETCODE NOVLIBP  PRNQUEUEPRIORITYGET( void );

  /* SA */

   LPSTR   NOVLIBP  PSFSLIST( BOOL StartFlag, LPSTR userbuff );

  /* SB */

   LPSTR   NOVLIBP  PRNNOTIFYOBJECTLIST( WORD PrinterNumber, BOOL StartFlag, LPSTR userbuff );
   LPSTR   NOVLIBP  NFYOBJECTSERVERGET( LPSTR userbuff);
   DWORD   NOVLIBP  NFYOBJECTTYPEGET( void );
   DWORD   NOVLIBP  NFYOBJECTFIRSTINTERVALGET( void );
   DWORD   NOVLIBP  NFYOBJECTNEXTINTERVALGET( void );

  /* SC */

   DWORD   NOVLIBP  SPXCONNECT( LPSTR FarAddress, WORD Socket, WORD TimeOut );
   RETCODE NOVLIBP  SPXCONNGET( WORD ConnNum );
   DWORD   NOVLIBP  SPXSOCKETNUMBERGET( void );
   BOOL    NOVLIBP  SPXDISCONNECT( WORD ConnNum );
   ERRCODE NOVLIBP  SPXPACKETSEND( WORD ConnNum, LPBYTE Packet, WORD PacketLength );
   LPBYTE  NOVLIBP  SPXPACKETGET( WORD ConnNum, LPWORD Length, LPBYTE userbuff );
   LPSTR   NOVLIBP  SPXADDRESSGET( WORD ConnNum, LPSTR userbuff );
   RETCODE NOVLIBP  SPXEVENTCONNGET( void );

  /* SM1 */

   DWORD   NOVLIBP  SEMOPEN( LPSTR SemaphoreName, WORD Value );
   BOOL    NOVLIBP  SEMCLOSE( DWORD SemID );
   RETCODE NOVLIBP  SEMUSERGET( DWORD SemID );
   RETCODE NOVLIBP  SEMVALUEGET( DWORD SemID );
   BOOL    NOVLIBP  SEMVALUEINCREMENT( DWORD SemID );

  /* SM2 */
   RETCODE NOVLIBP  WSSEMAPHORECOUNTGET( WORD ConnNum );
   RETCODE NOVLIBP  WSSEMAPHOREVALUEGET( WORD ConnNum );
   RETCODE NOVLIBP  WSSEMAPHORETASKLIST( WORD ConnNum, BOOL StartFlag );
   LPSTR   NOVLIBP  WSSEMAPHORELIST( WORD ConnNum, BOOL StartFlag, LPSTR userbuff );
   RETCODE NOVLIBP  WSSEMAPHORETOTALGET( WORD ConnNum );
   RETCODE NOVLIBP  SEMWSLIST( LPSTR SemName );

  /* SM3 */

   BOOL    NOVLIBP  SEMVALUEDECREMENT( DWORD SemID, WORD Value );

  /* SV1 */

   LPSTR   NOVLIBP  FSNAMEGET( WORD ConnNum, LPSTR userbuff );
   LPSTR   NOVLIBP  NWVERSIONNUMBERGET( LPSTR userbuff );
   RETCODE NOVLIBP  FSCONNMAXGET( void );
   RETCODE NOVLIBP  FSPEAKCONNGET( void );
   RETCODE NOVLIBP  FSCURRENTCONNGET( void );
   RETCODE NOVLIBP  FSVOLUMEMAXGET( void );
   RETCODE NOVLIBP  NWREVISIONNUMBERGET( void );
   RETCODE NOVLIBP  FSSFTLEVELGET( void );
   RETCODE NOVLIBP  FSTTSLEVELGET( void );
   RETCODE NOVLIBP  FSACCOUNTVERSIONGET( void );
   RETCODE NOVLIBP  FSQUEUEVERSIONNUMBERGET( void );
   RETCODE NOVLIBP  PSVERSIONNUMBERGET( void );
   RETCODE NOVLIBP  FSSECURITYVERSIONNUMBERGET( void );

  /* SV2 */

   BOOL    NOVLIBP  FSLOGINSTATUSSET( BOOL Status );
   BOOL    NOVLIBP  FSLOGINSTATUSGET( void );


  /* SV3 */

   LPSTR   NOVLIBP  FSDATESET( LPSTR NewDate, LPSTR userbuff );
   LPSTR   NOVLIBP  FSDATEGET( LPSTR userbuff );
   LPSTR   NOVLIBP  FSTIMESET( LPSTR NewTime, LPSTR userbuff );
   LPSTR   NOVLIBP  FSTIMEGET( LPSTR userbuff );

  /* SV4 */

   BOOL    NOVLIBP  FSDOWN( BOOL ForceFlag );

  /* SV5 */

   LPSTR   NOVLIBP  NWSERIALNUMBERGET( LPSTR userbuff );

  /* SV6 */

   RETCODE NOVLIBP  FSUTILISATIONGET( void );
   RETCODE NOVLIBP  FSMAXOBJECTGET( void );
   RETCODE NOVLIBP  FSPEAKOBJECTGET( void );
   RETCODE NOVLIBP  FSCURRENTOBJECTGET( void );
   RETCODE NOVLIBP  FSMEMORYTOTALGET( void );
   RETCODE NOVLIBP  FSMEMORYWASTEDGET( void );
   RETCODE NOVLIBP  FSPROCESSGET( void );

  /* SV7 */

   BOOL    NOVLIBP  FSFILEPURGE( LPSTR FileSpec, WORD All );
   BOOL    NOVLIBP  FSFILESALVAGE( LPSTR FileSpec );

  /* SV8 */

   RETCODE NOVLIBP  FSBUFFERCOUNTGET( void );
   RETCODE NOVLIBP  FSBUFFERSIZEGET( void );
   RETCODE NOVLIBP  FSBUFFERDIRTYGET( void );
   DWORD   NOVLIBP  FSCACHEHITGET( void );
   DWORD   NOVLIBP  FSCACHEMISSGET( void );

  /* SV9 */

   DWORD   NOVLIBP  FSDISKSIZEGET( WORD Drive );

  /* SVA */

   RETCODE NOVLIBP  FSDISKNUMBERGET( void );
   RETCODE NOVLIBP  FSDRIVEGET( void );
   RETCODE NOVLIBP  FSDISKIOGET( void );

  /* SVB */

   RETCODE NOVLIBP  FSMAXFILEGET( void );
   RETCODE NOVLIBP  FSPEAKFILEGET( void );
   RETCODE NOVLIBP  FSCURRENTFILEGET( void );
   DWORD   NOVLIBP  FSFILEOPENREQUESTGET( void );
   DWORD   NOVLIBP  FSFILEREADREQUESTGET( void );
   DWORD   NOVLIBP  FSFILEWRITEREQUESTGET( void );
   RETCODE NOVLIBP  FSFATCHANGEGET( void );
   RETCODE NOVLIBP  FSFATWRITEERRORGET( void );
   RETCODE NOVLIBP  FSFATFATALERRORGET( void );
   RETCODE NOVLIBP  FSFATSCANERRORGET( void );

  /* SVC */

   LPSTR   NOVLIBP  FSLANNWADDRESSGET( WORD LanBoard, LPSTR userbuff );
   LPSTR   NOVLIBP  FSLANADDRESSGET( WORD LanBoard, LPSTR userbuff );
   LPSTR   NOVLIBP  FSLANNAMEGET( WORD LanBoard, LPSTR userbuff );
   LPSTR   NOVLIBP  FSLANCONFIGGET( WORD LanBoard, LPSTR userbuff );
   RETCODE NOVLIBP  FSLANOPTIONGET( WORD LanBoard );

  /* SVD */

   LPSTR   NOVLIBP  FILOPENFILELIST( WORD ConnNo, WORD Counter, LPSTR userbuff );
   WORD    NOVLIBP  FILOPENCONNLIST( LPSTR FileSpec, WORD Counter );

  /* T1 */

   BOOL    NOVLIBP  TTSINSTALLED( void );
   BOOL    NOVLIBP  TTSACTIVEGET( void );
   BOOL    NOVLIBP  TTSACTIVESET( BOOL OnOff );
   RETCODE NOVLIBP  TTSVOLUMENUMBERGET( void );
   RETCODE NOVLIBP  TTSMAXTRANSACTIONGET( void );
   RETCODE NOVLIBP  TTSPEAKTRANSACTIONGET( void );
   RETCODE NOVLIBP  TTSFSTRANSACTIONGET( void );
   RETCODE NOVLIBP  TTSVOLUMEFREEGET( void );

  /* T2 */

   BOOL    NOVLIBP  TTSBEGIN( void );
   BOOL    NOVLIBP  TTSEND( LPDWORD TTSHandle );
   BOOL    NOVLIBP  TTSABORT( void );
   BOOL    NOVLIBP  TTSSTATUS( DWORD TTSHandle );

  /* T3 */

   RETCODE NOVLIBP  TTSAPPTHRESHOLDGET( );
   RETCODE NOVLIBP  TTSAPPTHRESHOLDSET( WORD Threshold );
   RETCODE NOVLIBP  TTSWSTHRESHOLDGET( );
   RETCODE NOVLIBP  TTSWSTHRESHOLDSET( WORD Threshold );

  /* W1 */

   LPSTR   NOVLIBP  WSOSNAMEGET( LPSTR userbuff );
   LPSTR   NOVLIBP  WSOSVERSIONGET( LPSTR userbuff );
   LPSTR   NOVLIBP  WSLONGNAMEGET( LPSTR userbuff );
   LPSTR   NOVLIBP  WSSHORTNAMEGET( LPSTR userbuff );
   LPSTR   NOVLIBP  WSSHELLVERSIONGET( LPSTR userbuff );

  /* W2 */

   RETCODE NOVLIBP  FSPREFERREDCONNGET( void );
   RETCODE NOVLIBP  FSPREFERREDCONNSET( WORD ConnectionID );
   LPSTR   NOVLIBP  FSPREFERREDNAMEGET( LPSTR userbuff );
   LPSTR   NOVLIBP  FSPREFERREDNAMESET( LPSTR FileServerName, LPSTR userbuff );
   RETCODE NOVLIBP  FSPRIMARYCONNGET( void );
   RETCODE NOVLIBP  FSPRIMARYCONNSET( WORD ConnectionID );
   LPSTR   NOVLIBP  FSPRIMARYNAMEGET( LPSTR userbuff );
   LPSTR   NOVLIBP  FSPRIMARYNAMESET( LPSTR FileServerName, LPSTR userbuff );

  /* Z3 */

   void   NOVLIBP  NOVTASKEND(void) ;

   #ifdef __cplusplus
      }
   #endif

    /* Common NetWare Bindery definitions */

    #define OT_WILD                      (-1)
    #define OT_UNKNOWN                   0x00
    #define OT_USER                      0x01
    #define OT_USER_GROUP                0x02
    #define OT_PRINT_QUEUE               0x03
    #define OT_FILE_SERVER               0x04
    #define OT_JOB_SERVER                0x05
    #define OT_GATEWAY                   0x06
    #define OT_PRINT_SERVER              0x07
    #define OT_ARCHIVE_QUEUE             0x08
    #define OT_ARCHIVE_SERVER            0x09
    #define OT_JOB_QUEUE                 0x0A
    #define OT_ADMINISTRATION            0x0B
    #define OT_NAS_SNA_GATEWAY           0x21
    #define OT_REMOTE_BRIDGE_SERVER      0x24
    #define OT_ADVERTISING_PRINT_SERVER  0x47
    #define OT_BTRIEVE_VAP               0x50
    #define OT_PRINT_QUEUE_USER          0x53

    #define DirGroupAdd(a,b,c)           DirObjectAdd(a,b,c)
    #define DirUserAdd(a,b,c)            DirObjectAdd(a,b,c)
    #define DirGroupDelete(a,b)          DirDeleteObject(a,b)
    #define DirUserDelete(a,b)           DirDeleteObject(a,b)
    #define FilGroupAdd(a,b,c)           DirObjectAdd(a,b,c)
    #define FilUserAdd(a,b,c)            DirObjectAdd(a,b,c)
    #define FilGroupDelete(a,b)          DirObjectDelete(a,b)
    #define FilUserDelete(a,b)           DirObjectDelete(a,b)
    #define FSAccountServerAdd(a,b)      SetPropertyIDAdd(FSNameGet(NOVDEFINT),OT_FILE_SERVER,a,b,"ACCOUNT_SERVERS")
    #define FSBinderyClose()             Bindery(1)
    #define FSAccountServerDelete(a,b)   SetPropertyIDDelete(FSNameGet(NOVDEFINT),OT_FILE_SERVER,a,b,"ACCOUNT_SERVERS")
    #define FSGroupDelete(a)             FSObjectDelete(a,OT_USER_GROUP)
    #define FSQueueDelete(a)             FSObjectDelete(a,OT_PRINT_QUEUE)
    #define FSUserDelete(a)              FSObjectDelete(a,OT_USER)
    #define FSIDGet(a)                   ObjIDGet(a,OT_FILE_SERVER)
    #define FSAccountingEnabledTest()    (FSGetAccVer() == 1)
    #define FSConsoleOperatorList(a,b,c) ObjNameGet(SetPropertyValueGet(a,OT_FILE_SERVER,"OPERATORS",b),c)
    #define FSGroupManagerList(a,b)      ObjNameGet(SetPropertyValueGet("SUPERVISOR",OT_USER,"MANAGERS",a),b)
    #define FSBinderyOpen()              Bindery(0)
    #define FSQueueRename(a,b)           ObjNameChange(a,b,OT_PRINT_QUEUE)
    #define GrpChangeName(a,b)           ObjNameChange(a,b,OT_USER_GROUP)
    #define GrpIDGet(a)                  ObjIDGet(a,OT_USER_GROUP)
    #define GrpNameGet(a,b)              ObjNameGet(a,b)
    #define GrpUserTest(a,b)             SetPropertyIDTest(b,OT_USER_GROUP,a,OT_USER,"GROUP_MEMBERS")
    #define GrpUserList(a,b,c)           ObjNameGet(SetPropertyValueGet(a,OT_USER_GROUP,"GROUP_MEMBERS",b),c)
    #define PSOperatorAdd(a,b)           SetPropertyIDAdd(b,OT_PRINT_SERVER,a,OT_USER,"PS_OPERATORS")
    #define PSUserAdd(a,b)               SetPropertyIDAdd(b,OT_PRINT_SERVER,a,OT_USER,"PS_USERS")
    #define PSOperatorDelete(a,b)        SetPropertyIDDelete(b,OT_PRINT_SERVER,a,OT_USER,"PS_OPERATORS")
    #define PSUserDelete(a,b)            SetPropertyIDDelete(b,OT_PRINT_SERVER,a,OT_USER,"PS_USERS")
    #define PSOperatorList(a,b,c)        ObjNameGet(SetPropertyValueGet(a,OT_PRINT_SERVER,"PS_OPERATORS",b),c)
    #define PSUserList(a,b,c)            ObjNameGet(SetPropertyValueGet(a,OT_PRINT_SERVER,"PS_USERS",b),c)
    #define QueGroupAdd(a,b)             SetPropertyIDAdd(b,OT_PRINT_QUEUE,a,OT_USER_GROUP,"Q_USERS")
    #define QueOperatorAdd(a,b)          SetPropertyIDAdd(b,OT_PRINT_QUEUE,a,OT_USER,"Q_OPERATORS")
    #define QueUserAdd(a,b)              SetPropertyIDAdd(b,OT_PRINT_QUEUE,a,OT_USER,"Q_USERS")
    #define QueGroupDelete(a,b)          SetPropertyIDDelete(b,OT_PRINT_QUEUE,a,OT_USER_GROUP,"Q_USERS")
    #define QueOperatorDelete(a,b)       SetPropertyIDDelete(b,OT_PRINT_QUEUE,a,OT_USER,"Q_OPERATORS")
    #define QueUserDelete(a,b)           SetPropertyIDDelete(b,OT_PRINT_QUEUE,a,OT_USER,"Q_USERS")
    #define QueIDGet(a)                  ObjIDGet(a,OT_PRINT_QUEUE)
    #define QueNameGet(a,b)              ObjNameGet(a,b)
    #define QueOperatorTest(a,b)         SetPropertyIDTest(b,OT_PRINT_QUEUE,a,OT_USER,"Q_OPERATORS")
    #define QueUserTest(a,b)             SetPropertyIDTest(b,OT_PRINT_QUEUE,a,OT_USER,"Q_USERS")
    #define QueOperatorList(a,b,c)       ObjNameGet(SetProperyValueGet(a,OT_PRINT_QUEUE,"Q_OPERATORS",b),c)
    #define QueUserList(a,b)             ObjNameGet(SetProperyValueGet(a,OT_PRINT_QUEUE,"Q_USERS",b),c)
    #define UsrPasswordChange(a,b,c)     ObjPasswordChange(a,b,c,OT_USER)
    #define UsrPasswordTest(a,b)         ObjPasswordTest(a,b,OT_USER)
    #define UsrNameChange(a,b)           ObjNameChange(a,b,OT_USER)
    #define UsrConsoleOperatorDelete(a)  SetPropertyIDDelete(FSNameGet(NOVDEFINT),OT_FILE_SERVER,a,OT_USER,"OPERATORS")
    #define UsrGroupManagerDelete(a)     SetPropertyIDDelete("SUPERVISOR",OT_USER,a,OT_USER,"MANAGERS")
    #define UserSupervisorDelete(a)      SetPropertyIDDelete(a,OT_USER,"SUPERVISOR",OT_USER,"SECURITY_EQUALS")
    #define UsrIDGet(a)                  ObjIDGet(a,OT_USER)
    #define UsrNameGet(a,b)              ObjNameGet(a,b)
    #define UsrConsoleOperatorTest(a)    SetPropertyIDTest(FSNameGet(NOVDEFINT),OT_FILE_SERVER,a,OT_USER,"OPERATORS")
    #define UsrGroupManagerTest(a)       SetPropertyIDTest("SUPERVISOR",OT_USER,a,OT_USER,"MANAGERS")
    #define UsrSupervisorTest(a)         SetPropertyIDTest(a,OT_USER,"SUPERVISOR",OT_USER,"SECURITY_EQUALS")
    #define UsrGroupList(a,b,c)          ObjNameGet(SetProperyValueGet(a,OT_USER,"GROUPS_I'M_IN",b),c)
    #define UsrAccountBalanceSet(a,b)    SetPropertyValueSet(a,OT_USER,"ACCOUNT_BALANCE",1,b)
    #define UsrAccountLimitSet(a,b)      SetPropertyValueSet(a,OT_USER,"ACCOUNT_BALANCE",2,b)
    #define UsrConsoleOperatorSet(a)     SetPropertyIDAdd(FSNameGet(NOVDEFINT),OT_FILE_SERVER,a,OT_USER,"OPERATORS")
    #define UsrGroupManagerSet(a)        SetPropertyIDAdd("SUPERVISOR",OT_USER,a,OT_USER,"MANAGERS")
    #define UsrSupervisorSet(a)          SetPropertyIDAdd(a,OT_USER,"SUPERVISOR",OT_USER,"SECURITY_EQUALS")

    #define __NOVLIBP__

#endif
