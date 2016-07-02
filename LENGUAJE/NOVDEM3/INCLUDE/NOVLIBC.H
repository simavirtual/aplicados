/**************************************************************
*
* NOVLIBC.H     96.05.12
*
* NOVLIB 3.x header for C/C++ (C convention)
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

  /* default values */

  #define NOVDEFLONG          (DWORD)-1L
  #define NOVDEFINT           (WORD)-1

  #define __NOVDEF__
#endif

#ifndef __NOVLIBC__

  #define NOVLIBC   _far cdecl

  #ifdef __cplusplus
     // prevent name mangling for C++
     extern "C" {
  #endif

 /* A1 */

 LONG    NOVLIBC  UsrAccountReserveGet( LPSTR UserName, LPSTR Control );
 BOOL    NOVLIBC  UsrAccountReserveSet( LPSTR ObjectName, DWORD ReserveAmount );
 BOOL    NOVLIBC  UsrAccountChargeAdd( LPSTR ObjectName, WORD ServiceType, DWORD ChargeAmount, WORD CommentType, LPSTR Comment );
 BOOL    NOVLIBC  UsrAccountChargeDelete( LPSTR ObjectName, WORD ServiceType, DWORD CancelHold, WORD CommentType, LPSTR Comment );

 /* B1 */

 LPSTR   NOVLIBC  ObjNameGet( DWORD ObjectID, LPSTR userbuff );
 WORD    NOVLIBC  ObjTypeGet( DWORD ObjectID );
 DWORD   NOVLIBC  ObjIDGet( LPSTR ObjectName, WORD ObjectType );

 /* B2 */

 BOOL    NOVLIBC  ObjPasswordCheck( LPSTR ObjectName, LPSTR PassWord, WORD ObjectType );
 BOOL    NOVLIBC  ObjPasswordChange( LPSTR ObjectName, LPSTR PassWord1, LPSTR PassWord2, WORD ObjectType );

 /* B3 */

 BOOL    NOVLIBC  SetPropertyIDTest( LPSTR ObjectName, WORD ObjectType, LPSTR MemberName, WORD MemberType, LPSTR PropertyName );

 /* B4 */

 BOOL    NOVLIBC  Bindery( BOOL OpenCloseFlag );

 /* B5 */

 DWORD   NOVLIBC  UsrDirCountGet( WORD VolNumber, DWORD ObjectID );
 DWORD   NOVLIBC  UsrFileCountGet( WORD VolNumber, DWORD ObjectID );
 DWORD   NOVLIBC  UsrDiskBlockGet( WORD VolNumber, DWORD ObjectID );
 DWORD   NOVLIBC  UsrDiskFreeGet( DWORD ObjectID );
 DWORD   NOVLIBC  UsrVolumeFreeGet( WORD VolNumber, DWORD ObjectID );
 DWORD   NOVLIBC  UsrVolumeRestrictGet( WORD VolNumber, DWORD ObjectID );
 DWORD   NOVLIBC  UsrVolumeRestrictSet( WORD VolNumber, DWORD ObjectID, DWORD Restriction );

 /* B6 */

  BOOL    NOVLIBC  FSUserAdd( LPSTR ObjectName, LPSTR Password );
  BOOL    NOVLIBC  FSGroupAdd( LPSTR ObjectName);
  BOOL    NOVLIBC  FSObjectDelete( LPSTR ObjectName, WORD ObjectType );
  BOOL    NOVLIBC  FSObjectAdd( LPSTR ObjectName, WORD ObjectType, WORD ObjectFlag, WORD ObjectSec );
  BOOL    NOVLIBC  ObjNameChange( LPSTR OldName, LPSTR NewName, WORD ObjectType );

 /* B7 */

  BOOL    NOVLIBC  GrpUserAdd( LPSTR SourceObj, LPSTR TargetObj );
  BOOL    NOVLIBC  GrpUserDelete( LPSTR SourceObj, LPSTR TargetObj );
  BOOL    NOVLIBC  SetPropertyIDAdd( LPSTR ObjectName, WORD ObjectType, LPSTR MemberName, WORD MemberType, LPSTR PropertyName );
  BOOL    NOVLIBC  SetPropertyIDDelete( LPSTR ObjectName, WORD ObjectType, LPSTR MemberName, WORD MemberType, LPSTR PropertyName );

 /* B8 */

  LPSTR   NOVLIBC  FSObjectList( LPSTR ObjectName, WORD ObjectType, BOOL StartFlag, LPSTR userbuff );
  WORD    NOVLIBC  ObjFlagGet( LPSTR ObjectName, WORD ObjectType );
  WORD    NOVLIBC  ObjSecurityGet( LPSTR ObjectName, WORD ObjectType );
  BOOL    NOVLIBC  ObjPropertyTest( LPSTR ObjectName, WORD ObjectType );

 /* B9 */

  LPSTR   NOVLIBC  UsrFullNameSet( LPSTR ObjectName, LPSTR FullName, LPSTR userbuff );
  LPSTR   NOVLIBC  UsrFullNameGet( LPSTR ObjectName, LPSTR userbuff );
  LPSTR   NOVLIBC  ItmPropertyStringSet( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, WORD Segment, LPSTR Value, LPSTR userbuff );
  LPSTR   NOVLIBC  ItmPropertyStringGet( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, WORD Segment, LPSTR userbuff );
  LPBYTE  NOVLIBC  ItmPropertyValueSet( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, WORD Segment, LPBYTE Value, LPBYTE userbuff );
  LPBYTE  NOVLIBC  ItmPropertyValueGet( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, WORD Segment, LPBYTE userbuff );
  DWORD   NOVLIBC  SetPropertyValueGet( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, WORD Element );
  DWORD   NOVLIBC  SetPropertyValueSet( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, WORD Element, DWORD Value );
  WORD    NOVLIBC  ItmPropertyByteSet( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, WORD Element, LPSTR Value );
  WORD    NOVLIBC  ItmPropertyByteGet( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, WORD Element );
  BOOL    NOVLIBC  ObjPropertyAdd( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, BYTE PropertyFlags, BYTE PropertySecurity );

 /* BA */

  RETCODE NOVLIBC  FSWSAttach( LPSTR ServerName );
  RETCODE NOVLIBC  FSConnIDGet( LPSTR ServerName );

 /* BB */

  LPSTR   NOVLIBC  ObjPropertyList( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName, BOOL StartFlag, LPSTR userbuff );
  RETCODE NOVLIBC  PrpFlagGet( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName );
  RETCODE NOVLIBC  PrpSecurityGet( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName );
  BOOL    NOVLIBC  PrpValueTest( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName );

 /* BC */

  BOOL    NOVLIBC  ObjPropertyDelete( LPSTR ObjectName, WORD ObjectType, LPSTR PropertyName );

 /* C1 */

  RETCODE NOVLIBC  WSConnNumberGet( void );
  LPSTR   NOVLIBC  WSLoginNameGet( WORD ConnNum, LPSTR userbuff );
  RETCODE NOVLIBC  WSLoginTypeGet( WORD ConnNum );
  DWORD   NOVLIBC  WSLoginIDGet( WORD ConnNum );
  LPSTR   NOVLIBC  WSLoginDateGet( WORD ConnNum, LPSTR userbuff );
  LPSTR   NOVLIBC  WSLoginTimeGet( WORD ConnNum, LPSTR userbuff );

 /* C2 */

  BOOL    NOVLIBC  WSConnClear( WORD ConnNum );

 /* C3 */

  RETCODE NOVLIBC  FilLockConnGet( LPSTR FileSpec, DWORD RecNo, WORD Format );

 /* C4 */

  RETCODE NOVLIBC  UsrConnList( LPSTR ObjectName );

 /* C5 */

  BOOL    NOVLIBC  ConnUsed( WORD ConnectionEntry );

 /* C6 */

  BOOL    NOVLIBC  FSWSLogin( LPSTR ObjectName, LPSTR Password, WORD ObjectType );
  BOOL    NOVLIBC  FSWSLogout( LPSTR ServerName, BOOL DetachFlag );
  BOOL    NOVLIBC  FSWSDetach( LPSTR ServerName );

 /* C7 */

  LPSTR   NOVLIBC  WSNetAddressGet( WORD ConnNo, LPSTR userbuff );
  LPSTR   NOVLIBC  WSNodeAddressGet( WORD ConnNo, LPSTR userbuff );

 /* C8 */

  BOOL    NOVLIBC  UsrCurConsoleOperatorTest( void );
  RETCODE NOVLIBC  FSReadLevelGet( void );
  RETCODE NOVLIBC  FSWriteLevelGet( void );

 /* D1 */

  BOOL    NOVLIBC  DirObjectAdd( DWORD ObjectID, LPSTR FileName, WORD RightsMask );
  BOOL    NOVLIBC  DirObjectDelete( DWORD ObjectID, LPSTR FileName );
  RETCODE NOVLIBC  DrvDirHandleGet( WORD Drive );
  RETCODE NOVLIBC  DrvFlagGet( WORD Drive );
  LPSTR   NOVLIBC  DrvCurrentGet( LPSTR userbuff );
  LPSTR   NOVLIBC  DrvCurrentSet( LPSTR Drive, LPSTR userbuff );

 /* D2 */

  RETCODE NOVLIBC  DirEffectiveRightsGet( LPSTR FileName );

 /* D3 */

  RETCODE NOVLIBC  WSEnvFreeGet( void );
  RETCODE NOVLIBC  WSEnvSizeGet( void );
  LPSTR   NOVLIBC  WSEnvVariableGet( LPSTR VarName, LPSTR userbuff );
  LPSTR   NOVLIBC  WSEnvVariableSet( LPSTR VarName, LPSTR NewVar, LPSTR userbuff );
  BOOL    NOVLIBC  SchVectorPathSet( void );
  LPSTR   NOVLIBC  SchOrderDriveGet( WORD SearchOrder, LPSTR userbuff );
  BOOL    NOVLIBC  SchVectorDriveDelete( WORD SearchOrder );
  RETCODE NOVLIBC  DrvSearchOrderGet( LPSTR Drive );
  RETCODE NOVLIBC  DrvDirMap( LPSTR Path, LPSTR Drive, WORD Temp );
  BOOL    NOVLIBC  DrvMapDelete( LPSTR Drive );
  BOOL    NOVLIBC  SchDriveMapDelete( WORD SearchOrder );
  LPSTR   NOVLIBC  SchVectorGet( LPSTR userbuff );
  LPSTR   NOVLIBC  SchVectorSet( LPSTR NewVector, LPSTR userbuff );
  RETCODE NOVLIBC  WSDriveLocalGet( void );
  BOOL    NOVLIBC  SchVectorDriveAdd( LPSTR Drive, WORD SearchOrder );
  RETCODE NOVLIBC  SchDriveDirMap( LPSTR Drive, LPSTR Path, WORD SearchOrder );
  LPSTR   NOVLIBC  WSDriveNetGet( LPSTR userbuff );
  LPSTR   NOVLIBC  DrvNextFreeGet( LPSTR userbuff );
  BOOL    NOVLIBC  DrvRootMap( LPSTR Drive, LPSTR Path );

 /* D4 */

  LPSTR   NOVLIBC  ObjDirList( WORD VolNumber, DWORD ObjectID, BOOL StartFlag, LPSTR userbuff );
  RETCODE NOVLIBC  DirAccessRightsGet( void );
  LPSTR   NOVLIBC  NovRightsString( WORD TrusteeRights, LPSTR userbuff );
  WORD    NOVLIBC  NovRightsValue( LPSTR Mask );

 /* D5 */

  RETCODE NOVLIBC  VolNumberGet( LPSTR VolName );
  LPSTR   NOVLIBC  VolNameGet( WORD VolNumber, LPSTR userbuff );
  DWORD   NOVLIBC  VolBlockMaxGet( WORD VolNumber );
  RETCODE NOVLIBC  VolBlockSizeGet( WORD VolNumber );
  DWORD   NOVLIBC  VolBlockFreeGet( WORD VolNumber );
  DWORD   NOVLIBC  VolBlockPurgeGet( WORD VolNumber );
  DWORD   NOVLIBC  VolBlockNotPurgeGet( WORD VolNumber );
  DWORD   NOVLIBC  VolDirMaxGet( WORD VolNumber );
  DWORD   NOVLIBC  VolDirFreeGet( WORD VolNumber );
  BOOL    NOVLIBC  VolRemoveableTest( WORD VolNumber );

 /* D6 */

  BOOL    NOVLIBC  FSDirAdd( LPSTR Directory, WORD Rights );
  BOOL    NOVLIBC  FSDirDelete( LPSTR Directory );
  BOOL    NOVLIBC  DirNameChange( LPSTR Directory, LPSTR NewName );

 /* D7 */

  LPSTR   NOVLIBC  Nephilim( LPSTR FileSpec, WORD Attributes, LPSTR userbuff );
  LPSTR   NOVLIBC  DirSubDirList( LPSTR FileSpec, LPSTR NewName, LPSTR userbuff );
  DWORD   NOVLIBC  DirAttributeGet( LPSTR FileSpec );
  DWORD   NOVLIBC  DirAttributeSet( LPSTR FileSpec, DWORD Attributes );
  RETCODE NOVLIBC  DirTypeGet( LPSTR FileSpec );
  LPSTR   NOVLIBC  DirCreateDateGet( LPSTR FileSpec, LPSTR userbuff );
  LPSTR   NOVLIBC  DirCreateDateSet( LPSTR FileSpec, LPSTR Date, LPSTR userbuff );
  LPSTR   NOVLIBC  DirCreateTimeGet( LPSTR FileSpec, LPSTR userbuff );
  LPSTR   NOVLIBC  DirCreateTimeSet( LPSTR FileSpec, LPSTR Time, LPSTR userbuff );
  DWORD   NOVLIBC  DirOwnerIDGet( LPSTR FileSpec );
  DWORD   NOVLIBC  DirOwnerIDSet( LPSTR FileSpec, DWORD NewID );
  LPSTR   NOVLIBC  DirArchiveDateGet( LPSTR FileSpec, LPSTR userbuff );
  LPSTR   NOVLIBC  DirArchiveDateSet( LPSTR FileSpec, LPSTR Date, LPSTR userbuff );
  LPSTR   NOVLIBC  DirArchiveTimeGet( LPSTR FileSpec, LPSTR userbuff );
  LPSTR   NOVLIBC  DirArchiveTimeSet( LPSTR FileSpec, LPSTR Time, LPSTR userbuff );
  DWORD   NOVLIBC  DirArchiveIDGet( LPSTR FileSpec );
  DWORD   NOVLIBC  DirArchiveIDSet( LPSTR FileSpec, DWORD ObjectID );
  LPSTR   NOVLIBC  DirModifyDateGet( LPSTR FileSpec, LPSTR userbuff );
  LPSTR   NOVLIBC  DirModifyDateSet( LPSTR FileSpec, LPSTR Date, LPSTR userbuff );
  LPSTR   NOVLIBC  DirModifyTimeGet( LPSTR FileSpec, LPSTR userbuff );
  LPSTR   NOVLIBC  DirModifyTimeSet( LPSTR FileSpec, LPSTR Time, LPSTR userbuff );
  RETCODE NOVLIBC  DirIRMaskGet( LPSTR FileSpec );
  RETCODE NOVLIBC  DirIRMaskSet( LPSTR FileSpec, WORD Mask );
  LPSTR   NOVLIBC  DirFileList( LPSTR FileSpec, LPSTR NewName, LPSTR userbuff );
  DWORD   NOVLIBC  FilAttributeGet( LPSTR FileSpec );
  DWORD   NOVLIBC  FilAttributeSet( LPSTR FileSpec, DWORD NewAttributes );
  RETCODE NOVLIBC  FilTypeGet( LPSTR FileSpec );
  LPSTR   NOVLIBC  FilCreateDateGet( LPSTR FileSpec, LPSTR userbuff );
  LPSTR   NOVLIBC  FilCreateDateSet( LPSTR FileSpec, LPSTR Date, LPSTR userbuff );
  LPSTR   NOVLIBC  FilCreateTimeGet( LPSTR FileSpec, LPSTR userbuff );
  LPSTR   NOVLIBC  FilCreateTimeSet( LPSTR FileSpec, LPSTR Time, LPSTR userbuff );
  DWORD   NOVLIBC  FilOwnerIDGet( LPSTR FileSpec );
  DWORD   NOVLIBC  FilOwnerIDSet( LPSTR FileSpec, DWORD ObjectID );
  LPSTR   NOVLIBC  FilArchiveDateGet( LPSTR FileSpec, LPSTR userbuff );
  LPSTR   NOVLIBC  FilArchiveDateSet( LPSTR FileSpec, LPSTR Date, LPSTR userbuff );
  LPSTR   NOVLIBC  FilArchiveTimeGet( LPSTR FileSpec, LPSTR userbuff );
  LPSTR   NOVLIBC  FilArchiveTimeSet( LPSTR FileSpec, LPSTR Time, LPSTR userbuff );
  DWORD   NOVLIBC  FilArchiveIDGet( LPSTR FileSpec );
  DWORD   NOVLIBC  FilArchiveIDSet( LPSTR FileSpec, DWORD ObjectID );
  LPSTR   NOVLIBC  FilModifyDateGet( LPSTR FileSpec, LPSTR userbuff );
  LPSTR   NOVLIBC  FilModifyDateSet( LPSTR FileSpec, LPSTR Date, LPSTR userbuff );
  LPSTR   NOVLIBC  FilModifyTimeGet( LPSTR FileSpec, LPSTR userbuff );
  LPSTR   NOVLIBC  FilModifyTimeSet( LPSTR FileSpec, LPSTR Time, LPSTR userbuff );
  DWORD   NOVLIBC  FilModifyIDGet( LPSTR FileSpec );
  DWORD   NOVLIBC  FilModifyIDSet( LPSTR FileSpec, DWORD ObjectID );
  LPSTR   NOVLIBC  FilAccessDateGet( LPSTR FileSpec, LPSTR userbuff );
  LPSTR   NOVLIBC  FilAccessDateSet( LPSTR FileSpec, LPSTR Date, LPSTR userbuff );
  RETCODE NOVLIBC  FilIRMaskGet( LPSTR FileSpec );
  RETCODE NOVLIBC  FilIRMaskSet( LPSTR FileSpec, WORD Mask );
  LPSTR   NOVLIBC  NovAttributeString( DWORD Rights, LPSTR userbuff );
  DWORD   NOVLIBC  NovAttributeValue( LPSTR Mask );

 /* D8 */

  LPSTR   NOVLIBC  DrvPathGet( LPSTR Drive, LPSTR userbuff );
  RETCODE NOVLIBC  DrvFSIDGet( LPSTR Drive );
  RETCODE NOVLIBC  DrvDirDepthGet( LPSTR Drive );

 /* D9 */

  DWORD   NOVLIBC  FilNetCopy( LPSTR SourceFile, LPSTR DestFile, DWORD SourceOffset, DWORD DestOffset, DWORD NumOfBytes );

 /* DA */

  DWORD   NOVLIBC  DFlDirEntryGet( void );
  LPSTR   NOVLIBC  DirDeletedFileList( LPSTR Path, LPSTR userbuff );
  DWORD   NOVLIBC  DFlAttributeGet( void );
  RETCODE NOVLIBC  DFlTypeGet( void );
  LPSTR   NOVLIBC  DFlArchiveDateGet( LPSTR userbuff );
  LPSTR   NOVLIBC  DFlArchiveTimeGet( LPSTR userbuff);
  DWORD   NOVLIBC  DFlArchiveIDGet( void );
  LPSTR   NOVLIBC  DFlModifyDateGet( LPSTR userbuff);
  LPSTR   NOVLIBC  DFlModifyTimeGet( LPSTR userbuff);
  DWORD   NOVLIBC  DFlModifyIDGet( void );
  LPSTR   NOVLIBC  DFlAccessDateGet( LPSTR userbuff );
  LPSTR   NOVLIBC  DFlDeleteDateGet( LPSTR userbuff );
  LPSTR   NOVLIBC  DFlDeleteTimeGet( LPSTR userbuff );
  DWORD   NOVLIBC  DFlDeleteIDGet( void );

 /* I3 */

  BOOL    NOVLIBC  IPXInstalled( void );
  RETCODE NOVLIBC  IPXOpen( WORD Socket );
  void    NOVLIBC  IPXSocketClose( void );

 /* I7 */

  LPSTR   NOVLIBC  IPXAddressGet(LPSTR userbuff);
  ERRCODE NOVLIBC  IPXPacketSend( LPSTR FarAddress, LPBYTE Packet, WORD PacketLength );
  ERRCODE NOVLIBC  IPXSocketOpen( WORD Socket );
  LPBYTE  NOVLIBC  IPXPacketGet( LPBYTE userbuff, LPWORD PacketLength );
  WORD    NOVLIBC  IPXSocketNumberGet( void );

 /* M1 */

  BOOL    NOVLIBC  FSMessageLog( LPSTR Message );
  BOOL    NOVLIBC  FSMessageSend( LPSTR Message );
  BOOL    NOVLIBC  WSMessageSend( WORD Connection, LPSTR Message );
  RETCODE NOVLIBC  WSMessageModeSet( WORD Mode );
  RETCODE NOVLIBC  WSMessageModeGet( void );
  LPSTR   NOVLIBC  WSMessageGet( LPSTR userbuff );

 /* N7 */

  LPSTR   NOVLIBC  NovVersionGet( LPSTR userbuff );
  ERRCODE NOVLIBC  NWErrorGet( void );
  ERRCODE NOVLIBC  NWGetErrorGet( void );
  ERRCODE NOVLIBC  NWSetErrorGet( void );
  BOOL    NOVLIBC  Gothic( void );
  WORD    NOVLIBC  NovIntSwap( WORD Value );
  DWORD   NOVLIBC  NovLongSwap( DWORD Value );
  BOOL    NOVLIBC  NovInit( void );

 /* O1 */

  void    NOVLIBC  NovScrPrt( void );

 /* O2 */

  BOOL    NOVLIBC  FSWSSyncronize( void );

 /* P1 */

  BOOL    NOVLIBC  FSPrinterStoppedTest( WORD Printer );
  BOOL    NOVLIBC  FSPrinterOffLineTest( WORD Printer );
  RETCODE NOVLIBC  FSPrinterFormGet( WORD Printer );
  RETCODE NOVLIBC  FSPrinterNumberGet( WORD Printer );

 /* P2 */

  BOOL    NOVLIBC  CapStart( WORD LPTPort );
  BOOL    NOVLIBC  CapEnd( WORD LPTPort );
  BOOL    NOVLIBC  CapFlush( WORD LPTPort );
  BOOL    NOVLIBC  CapCancel( WORD LPTPort );
  RETCODE NOVLIBC  DefaultLPT( WORD LPTPort );

 /* P3 */

  LPSTR   NOVLIBC  CapFSGet( WORD LPTPort, LPSTR userbuff );
  LPSTR   NOVLIBC  CapSetupStringGet( WORD LPTPort, LPSTR userbuff );
  LPSTR   NOVLIBC  CapSetupStringSet( WORD LPTPort, LPSTR NewString, LPSTR userbuff );
  LPSTR   NOVLIBC  CapResetStringGet( WORD LPTPort, LPSTR userbuff );
  LPSTR   NOVLIBC  CapResetStringSet( WORD LPTPort, LPSTR NewString, LPSTR userbuff );
  BOOL    NOVLIBC  CapKeepGet( WORD LPTPort);
  BOOL    NOVLIBC  CapKeepSet( WORD LPTPort, BOOL Flag );
  BOOL    NOVLIBC  CapAutoEndGet( WORD LPTPort);
  BOOL    NOVLIBC  CapAutoEndSet( WORD LPTPort, BOOL Flag );
  BOOL    NOVLIBC  CapFormFeedGet( WORD LPTPort );
  BOOL    NOVLIBC  CapFormFeedSet( WORD LPTPort, BOOL Flag );
  BOOL    NOVLIBC  CapBannerFlagGet( WORD LPTPort );
  BOOL    NOVLIBC  CapBannerFlagSet( WORD LPTPort, BOOL Flag );
  BOOL    NOVLIBC  CapTabFlagGet( WORD LPTPort );
  BOOL    NOVLIBC  CapTabFlagSet( WORD LPTPort, BOOL Flag );
  BOOL    NOVLIBC  CapNotifyFlagGet( WORD LPTPort );
  BOOL    NOVLIBC  CapNotifyFlagSet( WORD LPTPort, BOOL Flag );
  BOOL    NOVLIBC  CapSetup( WORD LPTPort );
  RETCODE NOVLIBC  CapTabSizeGet( WORD LPTPort );
  RETCODE NOVLIBC  CapTabSizeSet( WORD LPTPort, WORD TabSize );
  RETCODE NOVLIBC  CapFSPrinterGet( WORD LPTPort );
  RETCODE NOVLIBC  CapFSPrinterSet( WORD LPTPort, WORD PRNNo );
  RETCODE NOVLIBC  CapCopiesGet( WORD LPTPort );
  RETCODE NOVLIBC  CapCopiesSet( WORD LPTPort, WORD Copies );
  RETCODE NOVLIBC  CapFormNumberGet( WORD LPTPort );
  RETCODE NOVLIBC  CapFormNumberSet( WORD LPTPort, WORD FormNo );
  RETCODE NOVLIBC  CapMaxLineGet( WORD LPTPort );
  RETCODE NOVLIBC  CapMaxLineSet( WORD LPTPort, WORD NewMax );
  RETCODE NOVLIBC  CapMaxCharGet( WORD LPTPort );
  RETCODE NOVLIBC  CapMaxCharSet( WORD LPTPort, WORD NewMax );
  RETCODE NOVLIBC  CapTimeOutGet( WORD LPTPort );
  RETCODE NOVLIBC  CapTimeOutSet( WORD LPTPort, WORD NewTime );
  LPSTR   NOVLIBC  CapBannerTextGet( WORD LPTPort, LPSTR userbuff );
  LPSTR   NOVLIBC  CapBannerTextSet( WORD LPTPort, LPSTR NewName, LPSTR userbuff );
  LPSTR   NOVLIBC  CapFormNameGet( WORD LPTPort, LPSTR userbuff );
  LPSTR   NOVLIBC  CapFormNameSet( WORD LPTPort, LPSTR FormName, LPSTR userbuff );
  LPSTR   NOVLIBC  CapBannerNameGet( LPSTR userbuff );
  LPSTR   NOVLIBC  CapBannerNameSet( LPSTR BannerName, LPSTR userbuff );
  BOOL    NOVLIBC  CapActiveTest( WORD LPTPort );
  DWORD   NOVLIBC  CapQueueGet( WORD LPTPort );
  DWORD   NOVLIBC  CapQueueSet( WORD LPTPort, DWORD ObjectID );

 /* Q1 */

  BOOL    NOVLIBC  FSQueueAdd( LPSTR QueueName, LPSTR Path, WORD Type );

 /* Q2 */

  BOOL    NOVLIBC  QueAddStateGet( DWORD ObjectID );
  BOOL    NOVLIBC  QueAddStateSet( DWORD ObjectID, WORD Value );
  BOOL    NOVLIBC  QueServiceStateGet( DWORD ObjectID );
  BOOL    NOVLIBC  QueServiceStateSet( DWORD ObjectID, WORD Value );
  BOOL    NOVLIBC  QueHaltGet( DWORD ObjectID );
  BOOL    NOVLIBC  QueHaltSet( DWORD ObjectID, BOOL Value );

 /* Q3 */

  RETCODE NOVLIBC  QueQJbList( DWORD ObjectID, BOOL StartFlag );

 /* Q4 */

  DWORD   NOVLIBC  QJbSizeGet( DWORD ObjectID, WORD JobNum );
  BOOL    NOVLIBC  QueQJbDelete( DWORD ObjectID, WORD JobNum );

 /* Q5 */

  LPSTR   NOVLIBC  QJbTimeGet( DWORD ObjectID, WORD JobNum, LPSTR userbuff );
  LPSTR   NOVLIBC  QJbDateGet( DWORD ObjectID, WORD JobNum, LPSTR userbuff );
  LPSTR   NOVLIBC  QJbDeferDateGet( DWORD ObjectID, WORD JobNum, LPSTR userbuff );
  LPSTR   NOVLIBC  QJbDeferDateSet( DWORD ObjectID, WORD JobNum, LPSTR NewDate, LPSTR userbuff );
  LPSTR   NOVLIBC  QJbDeferTimeGet( DWORD ObjectID, WORD JobNum, LPSTR userbuff );
  LPSTR   NOVLIBC  QJbDeferTimeSet( DWORD ObjectID, WORD JobNum, LPSTR NewTime, LPSTR userbuff );
  RETCODE NOVLIBC  QJbWSGet( DWORD ObjectID, WORD JobNum );
  DWORD   NOVLIBC  QJbUserIDGet( DWORD ObjectID, WORD JobNum );
  BOOL    NOVLIBC  QJbAddingTest( DWORD ObjectID, WORD JobNum );
  RETCODE NOVLIBC  QJbFlagGet( DWORD ObjectID, WORD JobNum );
  RETCODE NOVLIBC  QJbFlagSet( DWORD ObjectID, WORD JobNum, WORD NewFlags );
  BOOL    NOVLIBC  QJbRestartGet( DWORD ObjectID, WORD JobNum );
  BOOL    NOVLIBC  QJbRestartSet( DWORD ObjectID, WORD JobNum, WORD Restart );
  BOOL    NOVLIBC  QJbOperatorHoldGet( DWORD ObjectID, WORD JobNum );
  BOOL    NOVLIBC  QJbOperatorHoldSet( DWORD ObjectID, WORD JobNum, WORD Hold );
  BOOL    NOVLIBC  QJbUserHoldGet( DWORD ObjectID, WORD JobNum );
  BOOL    NOVLIBC  QJbUserHoldSet( DWORD ObjectID, WORD JobNum, WORD Hold );
  LPSTR   NOVLIBC  QJbDescriptionGet( DWORD ObjectID, WORD JobNum, LPSTR userbuff );
  LPSTR   NOVLIBC  QJbDescriptionSet( DWORD ObjectID, WORD JobNum, LPSTR Desc, LPSTR userbuff );
  LPSTR   NOVLIBC  QJbFileNameGet( DWORD ObjectID, WORD JobNum, LPSTR userbuff );
  RETCODE NOVLIBC  QJbPositionGet( DWORD ObjectID, WORD JobNum );
  RETCODE NOVLIBC  QJbPositionSet( DWORD ObjectID, WORD JobNum, WORD Position );
  RETCODE NOVLIBC  QJbCopiesGet( DWORD ObjectID, WORD JobNum );
  RETCODE NOVLIBC  QJbCopiesSet( DWORD ObjectID, WORD JobNum, WORD Copies );
  LPSTR   NOVLIBC  QJbBannerGet( DWORD ObjectID, WORD JobNum, LPSTR userbuff );
  LPSTR   NOVLIBC  QJbBannerSet( DWORD ObjectID, WORD JobNum, LPSTR Banner, LPSTR userbuff );

 /* Q6 */

  RETCODE NOVLIBC  QueFileAdd( DWORD ObjectID, LPSTR FileSpec, WORD Flags, LPSTR Description,
                                    WORD Copies, WORD ControlFlags, DWORD ServerID );

 /* S2 */

  BOOL    NOVLIBC  SPXInstalled( void );
  LPSTR   NOVLIBC  SPXVersionNumberGet( LPSTR userbuff );
  RETCODE NOVLIBC  SPXMaxConnGet( void );
  RETCODE NOVLIBC  SPXConnFreeGet( void );
  DWORD   NOVLIBC  PSWSAttach( LPSTR Pserver );
  BOOL    NOVLIBC  PSWSDetach( WORD ConnectionNum );
  WORD    NOVLIBC  PSSocketNumberGet( void );
  WORD    NOVLIBC  PSConnNumberGet( void );
  RETCODE NOVLIBC  PSWSLogin( LPSTR Pserver );
  BOOL    NOVLIBC  PSWSLogout( void );
  BOOL    NOVLIBC  PSDown( WORD DownNow, WORD OutCome );

 /* S4 */

  BOOL    NOVLIBC  PrnJobAbort( WORD PrinterNo, WORD OutCome );
  BOOL    NOVLIBC  PrnStart( WORD PrinterNo );
  BOOL    NOVLIBC  PrnStop( WORD PrinterNo, WORD OutCome );
  BOOL    NOVLIBC  PrnEject( WORD PrinterNo );
  BOOL    NOVLIBC  PrnNotifyObjectAdd( WORD PrinterNo, LPSTR ServerName, LPSTR ObjectName, WORD FirstTime, WORD NextTime, WORD ObjectType );
  BOOL    NOVLIBC  PrnNotifyObjectDelete( WORD PrinterNo, LPSTR ServerName, LPSTR ObjectName, WORD ObjectType );
  BOOL    NOVLIBC  PrnNotifyPeriodChange( WORD PrinterNo, LPSTR ServerName, LPSTR ObjectName, WORD FirstTime, WORD NextTime, WORD ObjectType );
  BOOL    NOVLIBC  PrnFormTopMark( WORD PrinterNo, LPSTR MarkChar );

 /* S5 */

  LPSTR   NOVLIBC  PJbFSGet( WORD PrinterNo, LPSTR userbuff );
  LPSTR   NOVLIBC  PJbQueueGet( WORD PrinterNo, LPSTR userbuff );
  RETCODE NOVLIBC  PJbNumberGet( WORD PrinterNo );
  LPSTR   NOVLIBC  PJbDescriptionGet( WORD PrinterNo, LPSTR userbuff );
  RETCODE NOVLIBC  PJbCopyToDoGet( WORD PrinterNo );
  DWORD   NOVLIBC  PJbSizeGet( WORD PrinterNo );
  RETCODE NOVLIBC  PJbCopyDoneGet( WORD PrinterNo );
  DWORD   NOVLIBC  PJbBytesDoneGet( WORD PrinterNo );
  RETCODE NOVLIBC  PJbFormNumberGet( WORD PrinterNo );
  BOOL    NOVLIBC  PJbTextTest( WORD PrinterNo );

 /* S6 */

  RETCODE NOVLIBC  PrnStatusGet( WORD PrinterNo );
  RETCODE NOVLIBC  PrnErrorStatusGet( WORD PrinterNo );
  BOOL    NOVLIBC  PJbActiveTest( WORD PrinterNo );
  RETCODE NOVLIBC  PrnQueueModeGet( WORD PrinterNo, WORD Mode );
  RETCODE NOVLIBC  PrnFormNumberGet( WORD PrinterNo );
  RETCODE NOVLIBC  PrnFormNumberSet( WORD PrinterNo, WORD FormNum );
  LPSTR   NOVLIBC  PrnFormNameGet( WORD PrinterNo, LPSTR userbuff );
  LPSTR   NOVLIBC  PrnNameGet( WORD PrinterNo, LPSTR userbuff );

 /* S7 */

  BOOL    NOVLIBC  PJbRewind( WORD PrinterNo, WORD ByPage, WORD Relative, WORD Copy, LONG Offset );

 /* S8 */

  BOOL    NOVLIBC  PrnQueueAdd( WORD PrinterNo, LPSTR ServerName, LPSTR QueueName, WORD Priority );
  BOOL    NOVLIBC  PrnQueuePriorityChange( WORD PrinterNo, LPSTR ServerName, LPSTR QueueName, WORD Priority );
  BOOL    NOVLIBC  PrnQueueDelete( WORD PrinterNo, LPSTR ServerName, LPSTR QueueName, WORD Kill, WORD OutCome );

 /* S9 */

  LPSTR   NOVLIBC  PrnQueueList( WORD PrinterNumber, BOOL StartFlag, LPSTR userbuff );
  LPSTR   NOVLIBC  PrnQueueFSGet( LPSTR userbuff);
  RETCODE NOVLIBC  PrnQueuePriorityGet( void );

 /* SA */

  LPSTR   NOVLIBC  PSFSList( BOOL StartFlag, LPSTR userbuff );

 /* SB */

  LPSTR   NOVLIBC  PrnNotifyObjectList( WORD PrinterNumber, BOOL StartFlag, LPSTR userbuff );
  LPSTR   NOVLIBC  NfyObjectServerGet( LPSTR userbuff);
  DWORD   NOVLIBC  NfyObjectTypeGet( void );
  DWORD   NOVLIBC  NfyObjectFirstIntervalGet( void );
  DWORD   NOVLIBC  NfyObjectNextIntervalGet( void );

 /* SC */

  DWORD   NOVLIBC  SPXConnect( LPSTR FarAddress, WORD Socket, WORD TimeOut );
  RETCODE NOVLIBC  SPXConnGet( WORD ConnNum );
  DWORD   NOVLIBC  SPXSocketNumberGet( void );
  BOOL    NOVLIBC  SPXDisconnect( WORD ConnNum );
  ERRCODE NOVLIBC  SPXPacketSend( WORD ConnNum, LPBYTE Packet, WORD PacketLength );
  LPBYTE  NOVLIBC  SPXPacketGet( WORD ConnNum, LPWORD Length, LPBYTE userbuff );
  LPSTR   NOVLIBC  SPXAddressGet( WORD ConnNum, LPSTR userbuff );
  RETCODE NOVLIBC  SPXEventConnGet( void );

 /* SM1 */

  DWORD   NOVLIBC  SemOpen( LPSTR SemaphoreName, WORD Value );
  BOOL    NOVLIBC  SemClose( DWORD SemID );
  RETCODE NOVLIBC  SemUserGet( DWORD SemID );
  RETCODE NOVLIBC  SemValueGet( DWORD SemID );
  BOOL    NOVLIBC  SemValueIncrement( DWORD SemID );

 /* SM2 */

  RETCODE NOVLIBC  WSSemaphoreCountGet( WORD ConnNum );
  RETCODE NOVLIBC  WSSemaphoreValueGet( WORD ConnNum );
  RETCODE NOVLIBC  WSSemaphoreTaskList( WORD ConnNum, BOOL StartFlag );
  LPSTR   NOVLIBC  WSSemaphoreList( WORD ConnNum, BOOL StartFlag, LPSTR userbuff );
  RETCODE NOVLIBC  WSSemaphoreTotalGet( WORD ConnNum );
  RETCODE NOVLIBC  SemWSList( LPSTR SemName );

 /* SM3 */

  BOOL    NOVLIBC  SemValueDecrement( DWORD SemID, WORD Value );

 /* SV1 */

  LPSTR   NOVLIBC  FSNameGet( WORD ConnNum, LPSTR userbuff );
  LPSTR   NOVLIBC  NWVersionNumberGet( LPSTR userbuff );
  RETCODE NOVLIBC  FSConnMaxGet( void );
  RETCODE NOVLIBC  FSPeakConnGet( void );
  RETCODE NOVLIBC  FSCurrentConnGet( void );
  RETCODE NOVLIBC  FSVolumeMaxGet( void );
  RETCODE NOVLIBC  NWRevisionNumberGet( void );
  RETCODE NOVLIBC  FSSFTLevelGet( void );
  RETCODE NOVLIBC  FSTTSLevelGet( void );
  RETCODE NOVLIBC  FSAccountVersionGet( void );
  RETCODE NOVLIBC  FSQueueVersionNumberGet( void );
  RETCODE NOVLIBC  PSVersionNumberGet( void );
  RETCODE NOVLIBC  FSSecurityVersionNumberGet( void );

 /* SV2 */

  BOOL    NOVLIBC  FSLoginStatusSet( BOOL Status );
  BOOL    NOVLIBC  FSLoginStatusGet( void );


 /* SV3 */

  LPSTR   NOVLIBC  FSDateSet( LPSTR NewDate, LPSTR userbuff );
  LPSTR   NOVLIBC  FSDateGet( LPSTR userbuff );
  LPSTR   NOVLIBC  FSTimeSet( LPSTR NewTime, LPSTR userbuff );
  LPSTR   NOVLIBC  FSTimeGet( LPSTR userbuff );

 /* SV4 */

  BOOL    NOVLIBC  FSDown( BOOL ForceFlag );

 /* SV5 */

  LPSTR   NOVLIBC  NWSerialNumberGet( LPSTR userbuff );

 /* SV6 */

  RETCODE NOVLIBC  FSUtilisationGet( void );
  RETCODE NOVLIBC  FSMaxObjectGet( void );
  RETCODE NOVLIBC  FSPeakObjectGet( void );
  RETCODE NOVLIBC  FSCurrentObjectGet( void );
  RETCODE NOVLIBC  FSMemoryTotalGet( void );
  RETCODE NOVLIBC  FSMemoryWastedGet( void );
  RETCODE NOVLIBC  FSProcessGet( void );

 /* SV7 */

  BOOL    NOVLIBC  FSFilePurge( LPSTR FileSpec, WORD All );
  BOOL    NOVLIBC  FSFileSalvage( LPSTR FileSpec );

 /* SV8 */

  RETCODE NOVLIBC  FSBufferCountGet( void );
  RETCODE NOVLIBC  FSBufferSizeGet( void );
  RETCODE NOVLIBC  FSBufferDirtyGet( void );
  DWORD   NOVLIBC  FSCacheHitGet( void );
  DWORD   NOVLIBC  FSCacheMissGet( void );

 /* SV9 */

  DWORD   NOVLIBC  FSDiskSizeGet( WORD Drive );

 /* SVA */

  RETCODE NOVLIBC  FSDiskNumberGet( void );
  RETCODE NOVLIBC  FSDriveGet( void );
  RETCODE NOVLIBC  FSDiskIOGet( void );

 /* SVB */

  RETCODE NOVLIBC  FSMaxFileGet( void );
  RETCODE NOVLIBC  FSPeakFileGet( void );
  RETCODE NOVLIBC  FSCurrentFileGet( void );
  DWORD   NOVLIBC  FSFileOpenRequestGet( void );
  DWORD   NOVLIBC  FSFileReadRequestGet( void );
  DWORD   NOVLIBC  FSFileWriteRequestGet( void );
  RETCODE NOVLIBC  FSFatChangeGet( void );
  RETCODE NOVLIBC  FSFatWriteErrorGet( void );
  RETCODE NOVLIBC  FSFatFatalErrorGet( void );
  RETCODE NOVLIBC  FSFatScanErrorGet( void );

 /* SVC */

  LPSTR   NOVLIBC  FSLanNWAddressGet( WORD LanBoard, LPSTR userbuff );
  LPSTR   NOVLIBC  FSLanAddressGet( WORD LanBoard, LPSTR userbuff );
  LPSTR   NOVLIBC  FSLanNameGet( WORD LanBoard, LPSTR userbuff );
  LPSTR   NOVLIBC  FSLanConfigGet( WORD LanBoard, LPSTR userbuff );
  RETCODE NOVLIBC  FSLanOptionGet( WORD LanBoard );

 /* SVD */

  LPSTR   NOVLIBC  FilOpenFileList( WORD ConnNo, WORD Counter, LPSTR userbuff );
  WORD    NOVLIBC  FilOpenConnList( LPSTR FileSpec, WORD Counter );

 /* T1 */

  BOOL    NOVLIBC  TTSInstalled( void );
  BOOL    NOVLIBC  TTSActiveGet();
  BOOL    NOVLIBC  TTSActiveSet( BOOL OnOff );
  RETCODE NOVLIBC  TTSVolumeNumberGet( void );
  RETCODE NOVLIBC  TTSMaxTransactionGet( void );
  RETCODE NOVLIBC  TTSPeakTransactionGet( void );
  RETCODE NOVLIBC  TTSFSTransactionGet( void );
  RETCODE NOVLIBC  TTSVolumeFreeGet( void );

 /* T2 */

  BOOL    NOVLIBC  TTSBegin( void );
  BOOL    NOVLIBC  TTSEnd( LPDWORD TTSHandle );
  BOOL    NOVLIBC  TTSAbort( void );
  BOOL    NOVLIBC  TTSStatus( DWORD TTSHandle );

 /* T3 */

  RETCODE NOVLIBC  TTSAppThresholdGet( );
  RETCODE NOVLIBC  TTSAppThresholdSet( WORD Threshold );
  RETCODE NOVLIBC  TTSWSThresholdGet( );
  RETCODE NOVLIBC  TTSWSThresholdSet( WORD Threshold );

 /* W1 */

  LPSTR   NOVLIBC  WSOSNameGet( LPSTR userbuff );
  LPSTR   NOVLIBC  WSOSVersionGet( LPSTR userbuff );
  LPSTR   NOVLIBC  WSLongNameGet( LPSTR userbuff );
  LPSTR   NOVLIBC  WSShortNameGet( LPSTR userbuff );
  LPSTR   NOVLIBC  WSShellVersionGet( LPSTR userbuff );

 /* W2 */

  RETCODE NOVLIBC  FSPreferredConnGet( void );
  RETCODE NOVLIBC  FSPreferredConnSet( WORD ConnectionID );
  LPSTR   NOVLIBC  FSPreferredNameGet( LPSTR userbuff );
  LPSTR   NOVLIBC  FSPreferredNameSet( LPSTR FileServerName, LPSTR userbuff );
  RETCODE NOVLIBC  FSPrimaryConnGet( void );
  RETCODE NOVLIBC  FSPrimaryConnSet( WORD ConnectionID );
  LPSTR   NOVLIBC  FSPrimaryNameGet( LPSTR userbuff );
  LPSTR   NOVLIBC  FSPrimaryNameSet( LPSTR FileServerName, LPSTR userbuff );

 /* Z3 */

  void   NOVLIBC  NovTaskEnd(void) ;

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

    #define __NOVLIBC__

#endif
