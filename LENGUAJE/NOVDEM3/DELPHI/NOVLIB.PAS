{ Novlib 3.0 Copyright (c) 1993-96 Assembler Software Manufacturers Inc. }
unit Novlib;

interface

Type PByte     = ^Byte;
     PWord     = ^Word;
     PLongInt  = ^LongInt;

{ NOVLIB error return values }

Const NOVERRLONG:longint = -1;
Const NOVERRINT:integer = -1;

{ NOVLIB Various defines }

Const NOVNODSKRES   = $FFFFFF01;
Const NOVNOVOLRES   = $FFFFFF01;
Const NOVLOKWILD    = 0;
Const NOVLOKCLIPPER = 1;
Const NOVLOKNTX2    = 2;
Const NOVLOKFOX1    = 3;
Const NOVLOKFOX2    = 4;

Const NOVDEFLONG:longint = -1;
Const NOVDEFINT:integer  = -1;

Const NOVTRUE        = TRUE;
Const NOVFALSE       = FALSE;

{ A1 }

function UsrAccountReserveGet(UserName: String;
                      Control: String): LongInt; far;

function UsrAccountChargeAdd(ObjectName: String;
                       ServiceType: Word;
                       ChargeAmount: LongInt;
                       CommentType: Word;
                       Comment: String): WordBool;

function UsrAccountChargeDelete(ObjectName: String;
                       ServiceType: Word;
                       CancelHold: LongInt;
                       CommentType: Word;
                       Comment: String): WordBool;

function UsrAccountReserveSet(ObjectName: String;
                      ReserveAmount: LongInt): WordBool;

{ B1 }


function ObjNameGet(ObjectID: LongInt): String; cdecl; far;

function ObjTypeGet(ObjectID: LongInt): Word;

function ObjIDGet(ObjectName: String;
                  ObjectType: Word): LongInt;

{ B2 }


function ObjPasswordCheck(ObjectName: String;
                    PassWord: String;
                    ObjectType: Word): WordBool;

function ObjPasswordChange(ObjectName: String;
                    PassWord1: String;
                    PassWord2: String;
                    ObjectType: Word): WordBool;

{ B3 }


function SetPropertyIDTest(ObjectName: String;
                    ObjectType: Word;
                    MemberName: String;
                    MemberType: Word;
                    PropertyName: String): WordBool;

{ B4 }


function Bindery(OpenCloseFlag: WordBool): WordBool;

{ B5 }


function UsrDirGet(VolNumber: Word;
                   ObjectID: LongInt): LongInt;

function UsrFileGet(VolNumber: Word;
                   ObjectID: LongInt): LongInt;

function UsrDiskBlockGet(VolNumber: Word;
                      ObjectID: LongInt): LongInt;

function UsrDiskFreeGet(ObjectID: LongInt): LongInt;

function UsrVolumeFreeGet(VolNumber: Word;
                      ObjectID: LongInt): LongInt;

function UsrVolumeRestrictGet(VolNumber: Word;
                      ObjectID: LongInt): LongInt;

function UsrVolumeRestrictSet(VolNumber: Word;
                      ObjectID: LongInt;
                      Restriction: LongInt): LongInt;

{ B6 }


function FSUserAdd(ObjectName: String;
                  Password: String): WordBool;

function FSGroupAdd(ObjectName: String): WordBool;

function FSObjectDelete(ObjectName: String;
                  ObjectType: Word): WordBool;

function FSObjectAdd(ObjectName: String;
                  ObjectType: Word;
                  ObjectFlag: Word;
                  ObjectSec: Word): WordBool;

function ObjNameChange(OldName: String;
                   NewName: String;
                   ObjectType: Word): WordBool;

{ B7 }


function GrpUserAdd(SourceObj: String;
                   TargetObj: String): WordBool;

function GrpUserDelete(SourceObj: String;
                       TargetObj: String): WordBool;

function SetPropertyIDAdd(ObjectName: String;
                     ObjectType: Word;
                     MemberName: String;
                     MemberType: Word;
                     PropertyName: String): WordBool;

function SetPropertyIDDelete(ObjectName: String;
                     ObjectType: Word;
                     MemberName: String;
                     MemberType: Word;
                     PropertyName: String): WordBool;

{ B8 }


function FSObjectList(ObjectName: String;
                  ObjectType: Word; StartFlag: WordBool): String; cdecl; far;

function ObjFlagGet(ObjectName: String;
                   ObjectType: Word): Word;

function ObjSecurityGet(ObjectName: String;
                   ObjectType: Word): Word;

function ObjPropertyTest(ObjectName: String;
                   ObjectType: Word): WordBool;

{ B9 }


function UsrFullNameSet(ObjectName: String;
                      FullName: String): String; cdecl; far;

function UsrFullNameGet(ObjectName: String): String; cdecl; far;

function ItmPropertyStringSet(ObjectName: String;
                      ObjectType: Word;
                      PropertyName: String;
                      Segment: Word;
                      Value: String): String; cdecl; far;

function ItmPropertyStringGet(ObjectName: String;
                      ObjectType: Word;
                      PropertyName: String;
                      Segment: Word): String; cdecl; far;

function ItmPropertyValueSet(ObjectName: String;
                      ObjectType: Word;
                      PropertyName: String;
                      Segment: Word;
                      Value: String): String; cdecl; far;

function ItmPropertyValueGet(ObjectName: String;
                      ObjectType: Word;
                      PropertyName: String;
                      Segment: Word): String; cdecl; far;

function SetPropertyValueSet(ObjectName: String;
                      ObjectType: Word;
                      PropertyName: String;
                      Element: Word;
                      Value: LongInt): LongInt;

function SetPropertyValueGet(ObjectName: String;
                      ObjectType: Word;
                      PropertyName: String;
                      Element: Word): LongInt;

function ItmPropertyByteGet(ObjectName: String;
                       ObjectType: Word;
                       PropertyName: String;
                       Element: Word ): Word;

function ItmPropertyByteSet(ObjectName: String;
                       ObjectType: Word;
                       PropertyName: String;
                       Element: Word;
                       Value: String): Word;

function ObjPropertyAdd(ObjectName: String;
                   ObjectType: Word;
                   PropertyName: String;
                   PropertyFlags: BYTE;
                   PropertySecurity: BYTE): WordBool;

{ BA }


function FSWSAttach(ServerName: String): Integer;

function FSConnIDGet(ServerName: String): Integer;

{ BB }


function ObjPropertyList(ObjectName: String;
                   ObjectType: Word;
                   PropertyName: String;
                   StartFlag: WordBool): String; cdecl; far;

function PrpFlagGet(ObjectName: String;
                   ObjectType: Word;
                   PropertyName: String): Integer;

function PrpSecurityGet(ObjectName: String;
                   ObjectType: Word;
                   PropertyName: String): Integer;

function PrpValueTest(ObjectName: String;
                   ObjectType: Word;
                   PropertyName: String): WordBool;

{ BC }


function ObjPropertyDelete(ObjectName: String;
                   ObjectType: Word;
                   PropertyName: String): WordBool;

{ C1 }


function WSConnNumberGet: Integer;

function WSLoginNameGet(ConnNum: Word): String; cdecl; far;

function WSLoginTypeGet(ConnNum: Word): Integer;

function WSLoginIDGet(ConnNum: Word): LongInt;

function WSLoginDateGet(ConnNum: Word): String; cdecl; far;

function WSLoginTimeGet(ConnNum: Word): String; cdecl; far;

{ C2 }


function WSConnClear(ConnNum: Word): WordBool;

{ C3 }


function LokWSGet(FileSpec: String;
                  RecNo: LongInt;
                  Format: Word): Integer;

{ C4 }


function UsrConnList(ObjectName: String): Integer;

{ C5 }


function ConnUsed(ConnectionEntry: Word): WordBool;

{ C6 }


function FSWSLogin(ObjectName: String;
                   Password: String;
                   ObjectType: Word): WordBool;

function FSWSLogout(ServerName: String;
                    DetachFlag: WordBool): WordBool;

function FSWSDetach(ServerName: String): WordBool;

{ C7 }


function WSNetAddressGet(ConnNo: Word): String; cdecl; far;

function WSNodeAddressGet(ConnNo: Word): String; cdecl; far;

{ C8 }


function UsrCurConsoleOperatorTest: WordBool;

function FSReadLevelGet: Integer;

function FSWriteLevelGet: Integer;

{ D1 }


function DirObjectAdd(ObjectID: LongInt;
                   FileName: String;
                   RightsMask: Word): WordBool;

function DirObjectDelete(ObjectID: LongInt;
                   FileName: String): WordBool;

function DrvDirHandleGet(Drive: Word): Integer;

function DrvFlagGet(Drive: Word): Integer;

function DrvCurrentSet(Drive: String): String; cdecl; far;

function DrvCurrentGet: String; cdecl; far;

{ D2 }


function DirEffectiveRightsGet(FileName: String): Integer;

{ D3 }


function WSEnvFreeGet: Integer;

function WSEnvSizeGet: Integer;

function WSEnvVariableSet(VarName: String;
                     NewVar: String): String; cdecl; far;

function WSEnvVariableGet(VarName: String): String; cdecl; far;

function SchVectorPathSet: WordBool;

function SchOrderDriveGet(SearchOrder: Word): String; cdecl; far;

function SchVectorDriveDelete(SearchOrder: Word): WordBool;

function DrvSearchOrderGet(Drive: String): Integer;

function DrvDirMap(Path: String;
                   Drive: String;
                   Temp: Word): Integer;

function DrvMapDelete(Drive: String): WordBool;

function SchDriveMapDelete(SearchOrder: Word): WordBool;

function SchVectorSet(NewVector: String): String; cdecl; far;

function WSDriveLocalGet: Integer;

function SchVectorDriveAdd(Drive: String;
                      SearchOrder: Word): WordBool;

function SchDriveDirectoryMap(Drive: String;
                      Path: String;
                      SearchOrder: Word): Integer;

function WSDriveNetGet: String;

function DrvNextFreeGet: String;

function DrvRootMap(Drive: String;
                    Path: String): WordBool;

{ D4 }


function ObjDirList(VolNumber: Word;
                   ObjectID: LongInt;
                   StartFlag: WordBool): String; cdecl; far;

function DirAccessRightsGet: Integer;

function NovRightsString(Rights: Word): String; cdecl; far;

Function NovRightsValue(Mask: String): Word;

{ D5 }


function VolNumberGet(VolName: String): Integer;

function VolNameGet(VolNumber: Word): String; cdecl; far;

function VolMaxBlockGet(VolNumber: Word): LongInt;

function VolBlockSizeGet(VolNumber: Word): Integer;

function VolBlockFreeGet(VolNumber: Word): LongInt;

function VolBlockPurgeableGet(VolNumber: Word): LongInt;

function VolBlockNotPurgeableGet(VolNumber: Word): LongInt;

function VolDirMaxGet(VolNumber: Word): LongInt;

function VolDirFreeGet(VolNumber: Word): LongInt;

function VolRemoveableTest(VolNumber: Word): WordBool;

{ D6 }


function FSDirAdd(Directory: String;
                  Rights: Word): WordBool;

function FSDirDelete(Directory: String): WordBool;

function DirNameChange(Directory: String;
                   NewName: String): WordBool;

{ D7 }


function DirSubDirList(FileSpec: String;
                      NewName: String): String; cdecl; far;

function DirAttributeSet(FileSpec: String;
                   Attributes: LongInt): LongInt;

function DirAttributeGet(FileSpec: String): LongInt;

function DirTypeGet(FileSpec: String): Integer;

function DirCreateDateSet(FileSpec: String;
                      Date: String): String; cdecl; far;

function DirCreateDateGet(FileSpec: String): String; cdecl; far;

function DirCreateTimeSet(FileSpec: String;
                      Time: String): String; cdecl; far;

function DirCreateTimeGet(FileSpec: String): String; cdecl; far;

function DirOwnerIDSet(FileSpec: String;
                     NewID: LongInt): LongInt;

function DirOwnerIDGet(FileSpec: String): LongInt;

function DirArchiveDateSet(FileSpec: String;
                      Date: String): String; cdecl; far;

function DirArchiveDateGet(FileSpec: String): String; cdecl; far;

function DirArchiveTimeSet(FileSpec: String;
                      Time: String): String; cdecl; far;

function DirArchiveTimeGet(FileSpec: String): String; cdecl; far;

function DirArchiveIDSet(FileSpec: String;
                     ObjectID: LongInt): LongInt;

function DirArchiveIDGet(FileSpec: String): LongInt;

function DirModifyDateSet(FileSpec: String;
                      Date: String): String; cdecl; far;

function DirModifyDateGet(FileSpec: String): String; cdecl; far;

function DirModifyTimeSet(FileSpec: String;
                      Time: String): String; cdecl; far;

function DirModifyTimeGet(FileSpec: String): String; cdecl; far;

function DirIRMaskSet(FileSpec: String;
                     Mask: Word): Integer;

function DirIRMaskGet(FileSpec: String): Integer;

function DirFileList(FileSpec: String;
                   NewName: String): String; cdecl; far;

function FilAttributeGet(FileSpec: String): LongInt;

function FilAttributeSet(FileSpec: String;
                   NewAttributes: LongInt): LongInt;

function FilTypeGet(FileSpec: String): Integer;

function FilCreateDateSet(FileSpec: String;
                      Date: String): String; cdecl; far;

function FilCreateDateGet(FileSpec: String): String; cdecl; far;

function FilCreateTimeSet(FileSpec: String;
                      Time: String): String; cdecl; far;

function FilCreateTimeGet(FileSpec: String): String; cdecl; far;

function FilOwnerIDSet(FileSpec: String;
                     ObjectID: LongInt): LongInt;

function FilOwnerIDGet(FileSpec: String): LongInt;

function FilArchiveDateSet(FileSpec: String;
                      Date: String): String; cdecl; far;

function FilArchiveDateGet(FileSpec: String): String; cdecl; far;

function FilArchiveTimeSet(FileSpec: String;
                      Time: String): String; cdecl; far;

function FilArchiveTimeGet(FileSpec: String): String; cdecl; far;

function FilArchiveIDSet(FileSpec: String;
                     ObjectID: LongInt): LongInt;

function FilArchiveIDGet(FileSpec: String): LongInt;

function FilModifyDateSet(FileSpec: String;
                      Date: String): String; cdecl; far;

function FilModifyDateGet(FileSpec: String): String; cdecl; far;

function FilModifyTimeSet(FileSpec: String;
                      Time: String): String; cdecl; far;

function FilModifyTimeGet(FileSpec: String): String; cdecl; far;

function FilModifyIDSet(FileSpec: String;
                     ObjectID: LongInt): LongInt;

function FilModifyIDGet(FileSpec: String): LongInt;

function FilAccessDateSet(FileSpec: String;
                      Date: String): String; cdecl; far;

function FilAccessDateGet(FileSpec: String): String; cdecl; far;

function FilIRMaskSet(FileSpec: String;
                     Mask: Word): Integer;

function FilIRMaskGet(FileSpec: String): Integer;

function NovAttributeString(Rights : Longint):String; cdecl; far;

function NovAttributeValue(Mask : string): Longint;

{ D8 }


function DrvPathGet(Drive: String): String; cdecl; far;

function DrvFSIDGet(Drive: String): Integer;

function DrvDirDepthGet(Drive: String): Integer;

{ D9 }


function FilNetCopy(SourceFile: String;
                   DestFile: String;
                   SourceOffset: LongInt;
                   DestOffset: LongInt;
                   NumOfBytes: LongInt): LongInt;

{ DA }


function DflDirEntryGet: LongInt;

function DirDeletedFileList(Path: String): String; cdecl; far;

function DflAttributeGet: LongInt;

function DflTypeGet: Integer;

function DflArchiveDateGet: String; cdecl; far;

function DflArchiveTimeGet: String; cdecl; far;

function DflArchiveIDGet: LongInt;

function DflModifyDateGet: String; cdecl; far;

function DflModifyTimeGet: String; cdecl; far;

function DflModifyIDGet: LongInt;

function DflAccessDateGet: String; cdecl; far;

function DflDeleteDateGet: String; cdecl; far;

function DflDeleteTimeGet: String; cdecl; far;

function DflDeleteIDGet: LongInt;

{ I3 }


function IPXInstalled: WordBool;

function IPXOpen(Socket: Word): Integer;

procedure IPXSocketClose;

{ I7 }
function IPXAddressGet: String;

function IPXPacketSend(FarAddress: String;
                   Packet: PByte;
                   PacketLength: Word): Integer;

function IPXSocketOpen(Socket: Word): Integer;

function IPXPacketGet(userbuff: PByte): PByte;

function IPXSocketNumberGet: Word;

{ M1 }


function FSMessageLog(Message: String): WordBool;

function FSMessageSend(Message: String): WordBool;

function WSMessageSend(Connection: Word;
                  Message: String): WordBool;

function WSMessageModeSet(Mode: Word): Integer;

function WSMessageGet: String; cdecl; far;

{ N7 }


function NovVersionGet: String; cdecl; far;

function NWErrorGet: Integer;

function NovIntSwap(Value: Word): Word;

function NovLongSwap(Value: LongInt): LongInt;

function NWGetErrorGet: Integer;

function NWSetErrorGet: Integer;


{ O1 }


{ procedure NOVPRTSC;}

{ O2 }


function FSWSSynchronize: Word;

{ P1 }


function FSPrinterStoppedTest(Printer: Word): WordBool;

function FSPrinterOfflineTest(Printer: Word): WordBool;

function FSPrinterFormGet(Printer: Word): Integer;

function FSPrinterNumberGet(Printer: Word): Integer;

{ P2 }


function CapStart(LPTPort: Word): WordBool;

function CapEnd(LPTPort: Word): WordBool;

function CapFlush(LPTPort: Word): WordBool;

function CapCancel(LPTPort: Word): WordBool;

function DefaultLpt(LPTPort: Word): Integer;

{ P3 }


function CapFSGet(LPTPort: Word): String; cdecl; far;

function CapSetupStringGet(LPTPort: Word): String; cdecl; far;

function CapSetupStringSet(LPTPort: Word;
                      NewString: String): String; cdecl; far;

function CapResetStringGet(LPTPort: Word): String; cdecl; far;

function CapResetStringSet(LPTPort: Word;
                      NewString: String): String; cdecl; far;

function CapKeepSet(LPTPort: Word;
                    Flag: WordBool): WordBool;

function CapKeepGet(LPTPort: Word): WordBool;

function CapAutoEndSet(LPTPort: Word;
                       Flag: WordBool): WordBool;

function CapAutoEndGet(LPTPort: Word): WordBool;

function CapFormFeedSet(LPTPort: Word;
                      Flag: WordBool): WordBool;

function CapFormFeedGet(LPTPort: Word): WordBool;

function CapBannerFlagSet(LPTPort: Word;
                      Flag: WordBool): WordBool;

function CapBannerFlagGet(LPTPort: Word): WordBool;

function CapTabFlagSet(LPTPort: Word;
                      Flag: WordBool): WordBool;

function CapTabFlagGet(LPTPort: Word): WordBool;

function CapNotifyFlagGet(LPTPort: Word): WordBool;

function CapNotifyFlagSet(LPTPort: Word;
                      Flag: WordBool): WordBool;

function CapSetUp(LPTPort: Word): WordBool;

function CapTabSizeSet(LPTPort: Word;
                      TabSize: Word): Integer;

function CapTabSizeGet(LPTPort: Word): Integer;

function CapFSPrinterGet(LPTPort: Word): Integer;

function CapFSPrinterSet(LPTPort: Word;
                     PRNNo: Word): Integer;

function CapCopiesSet(LPTPort: Word;
                      Copies: Word): Integer;

function CapCopiesGet(LPTPort: Word): Integer;

function CapFormNumberSet(LPTPort: Word;
                     FormNo: Word): Integer;

function CapFormNumberGet(LPTPort: Word): Integer;

function CapMaxLineSet(LPTPort: Word;
                      NewMax: Word): Integer;

function CapMaxLineGet(LPTPort: Word): Integer;

function CapMaxCharSet(LPTPort: Word;
                      NewMax: Word): Integer;

function CapMaxCharGet(LPTPort: Word): Integer;

function CapTimeOutSet(LPTPort: Word;
                      NewTime: Word): Integer;

function CapTimeOutGet(LPTPort: Word): Integer;

function CapBannerTextSet(LPTPort: Word;
                      NewName: String): String; cdecl; far;

function CapBannerTextGet(LPTPort: Word): String; cdecl; far;

function CapFormNameSet(LPTPort: Word;
                     FormName: String): String; cdecl; far;

function CapFormNameGet(LPTPort: Word): String; cdecl; far;

function CapBannerNameSet(BannerName: String): String; cdecl; far;

function CapBannerNameGet : String; cdecl; far;

function CapActiveTest(LPTPort: Word): WordBool;

function CapQueueSet(LPTPort: Word;
                   ObjectID: LongInt): LongInt;

function CapQueueGet(LPTPort: Word): LongInt;

{ Q1 }


function FSQueueAdd(QueueName: String;
                  Path: String;
                  QType: Word): WordBool;

{ Q2 }

function QueAddStateGet(ObjectID: LongInt): WordBool;

function QueAddStateSet(ObjectID: LongInt;
                   Value: WordBool): WordBool;

function QueServiceStateGet(ObjectID: LongInt): WordBool;

function QueServiceStateSet(ObjectID: LongInt;
                   Value: WordBool): WordBool;

function QueHaltGet(ObjectID: LongInt): WordBool;

function QueHaltSet(ObjectID: LongInt;
                 Value: WordBool): WordBool;

{ Q3 }


function QueQjbList(ObjectID: LongInt; StartFlag: WordBool): Integer;

{ Q4 }


function QjbSizeGet(ObjectID: LongInt;
                    JobNum: Word): LongInt;

function QueQjbDelete(ObjectID: LongInt;
                   JobNum: Word): WordBool;

{ Q5 }


function QjbTimeGet(ObjectID: LongInt;
                   JobNum: Word): String; cdecl; far;

function QjbDateGet(ObjectID: LongInt;
                   JobNum: Word): String; cdecl; far;

function QjbDeferDateSet(ObjectID: LongInt;
                     JobNum: Word;
                     NewDate: String): String; cdecl; far;

function QjbDeferDateGet(ObjectID: LongInt;
                     JobNum: Word): String; cdecl; far;

function QjbDeferTimeSet(ObjectID: LongInt;
                     JobNum: Word;
                     NewTime: String): String; cdecl; far;

function QjbDeferTimeGet(ObjectID: LongInt;
                     JobNum: Word): String; cdecl; far;

function QjbWSGet(ObjectID: LongInt;
                  JobNum: Word): Integer;

function QjbUserIDGet(ObjectID: LongInt;
                     JobNum: Word): LongInt;

function QjbAddingTest(ObjectID: LongInt;
                     JobNum: Word): WordBool;

function QjbFlagGet(ObjectID: LongInt;
                   JobNum: Word): Integer;

function QjbFlagSet(ObjectID: LongInt;
                   JobNum: Word;
                   NewFlags: Word): Integer;

function QjbRestartGet(ObjectID: LongInt;
                       JobNum: Word): WordBool;

function QjbRestartSet(ObjectID: LongInt;
                       JobNum: Word;
                       Restart: WordBool): WordBool;

function QjbOperatorHoldGet(ObjectID: LongInt;
                      JobNum: Word): WordBool;

function QjbOperatorHoldSet(ObjectID: LongInt;
                      JobNum: Word;
                      Hold: WordBool): WordBool;

function QjbUserHoldGet(ObjectID: LongInt;
                      JobNum: Word): WordBool;

function QjbUserHoldSet(ObjectID: LongInt;
                      JobNum: Word;
                      Hold: WordBool): WordBool;

function QjbDescriptionGet(ObjectID: LongInt;
                    JobNum: Word): String; cdecl; far;

function QjbDescriptionSet(ObjectID: LongInt;
                    JobNum: Word;
                    Desc: String): String; cdecl; far;

function QjbFileNameGet(ObjectID: LongInt;
                      JobNum: Word): String; cdecl; far;

function QjbPositionGet(ObjectID: LongInt;
                   JobNum: Word): Integer;

function QjbPositionSet(ObjectID: LongInt;
                   JobNum: Word;
                   Position: Word): Integer;

function QjbCopiesGet(ObjectID: LongInt;
                      JobNum: Word): Integer;

function QjbCopiesSet(ObjectID: LongInt;
                      JobNum: Word;
                      Copies: Word): Integer;

function QjbBannerGet(ObjectID: LongInt;
                   JobNum: Word): String; cdecl; far;


function QjbBannerSet(ObjectID: LongInt;
                   JobNum: Word;
                   Banner: String): String; cdecl; far;

{ Q6 }


function QueFileAdd(ObjectID: LongInt;
                   FileSpec: String;
                   Flags: Word;
                   Description: String;
                   Copies: Word;
                   ControlFlags: Word;
                   ServerID: LongInt): Integer;
{ S2 }


function SpxInstalled: WordBool;

function SpxVersionNumberGet: String; cdecl; far;

function SpxMaxConnGet: Integer;

function SpxFreeConnGet: Integer;

function PSWSAttach(Pserver: String): LongInt;

function PSWSDetach(ConnectionNum: Word): WordBool;

function PSSocketNumberGet: Word;

function PSConnNumberGet: Word;

function PSWSLogin(Pserver: String): Integer;

function PSWSLogout: WordBool;

function PSDown(DownNow: Word;
                OutCome: Word): WordBool;

{ S4 }


function PrnJobAbort(PrinterNo: Word;
                   OutCome: Word): WordBool;

function PrnStart(PrinterNo: Word): WordBool;

function PrnStop(PrinterNo: Word;
                 OutCome: Word): WordBool;

function PrnEject(PrinterNo: Word): WordBool;

function PrnNotifyObjectAdd(PrinterNo: Word;
                      ServerName: String;
                      ObjectName: String;
                      FirstTime: Word;
                      NextTime: Word;
                      ObjectType: Word): WordBool;

function PrnNotifyObjectDelete(PrinterNo: Word;
                      ServerName: String;
                      ObjectName: String;
                      ObjectType: Word): WordBool;

function PrnNotifyPeriodChange(PrinterNo: Word;
                      ServerName: String;
                      ObjectName: String;
                      FirstTime: Word;
                      NextTime: Word;
                      ObjectType: Word): WordBool;

function PrnFormTopMark(PrinterNo: Word;
                      MarkChar: String): WordBool;

{ S5 }


function PjbFSGet(PrinterNo: Word): String; cdecl; far;

function PjbQueueGet(PrinterNo: Word): String; cdecl; far;

function PjbNumberGet(PrinterNo: Word): Integer;

function PjbDescriptionGet(PrinterNo: Word): String; cdecl; far;

function PjbCopyToDoGet(PrinterNo: Word): Integer;

function PjbSizeGet(PrinterNo: Word): LongInt;

function PjbCopyDoneGet(PrinterNo: Word): Integer;

function PjbByteDoneGet(PrinterNo: Word): LongInt;

function PjbFormNumberGet(PrinterNo: Word): Integer;

function PjbTextTest(PrinterNo: Word): WordBool;

{ S6 }


function PrnStatusGet(PrinterNo: Word): Integer;

function PrnErrorStatusGet(PrinterNo: Word): Integer;

function PjbActiveTest(PrinterNo: Word): WordBool;

function PrnQueueModeGet(PrinterNo: Word;
                      Mode: Word): Integer;

function PrnFormNumberSet(PrinterNo: Word;
                     FormNum: Word): Integer;

function PrnFormNameGet(PrinterNo: Word): String; cdecl; far;

function PrnNameGet(PrinterNo: Word): String; cdecl; far;

{ S7 }


function PjbRewind(PrinterNo: Word;
                   ByPage: Word;
                   Relative: Word;
                   Copy: Word;
                   Offset: LongInt): WordBool;

{ S8 }


function PrnQueueAdd(PrinterNo: Word;
                   ServerName: String;
                   QueueName: String;
                   Priority: Word): WordBool;

function PrnQueuePriorityChange(PrinterNo: Word;
                      ServerName: String;
                      QueueName: String;
                      Priority: Word): WordBool;

function PrnQueueDelete(PrinterNo: Word;
                   ServerName: String;
                   QueueName: String;
                   Kill: Word;
                   OutCome: Word): WordBool;

{ S9 }


function PrnQueueList(PrinterNumber: Word; StartFlag: WordBool): String; cdecl; far;

function PrnQueueFSGet: String;

function PrnQueuePriorityGet: Integer;

{ SA }


function PSFSList(StartFlag: WordBool): String; cdecl; far;

{ SB }


function PrnNotifyObjectList(PrinterNumber: Word; StartFlag: WordBool): String; cdecl; far;

function NfyObjectServerGet: String; cdecl; far;

function NfyObjectTypeGet: LongInt;

function NfyObjectFirstIntervalGet: LongInt;

function NfyObjectNextIntervalGet: LongInt;

{ SC }


function SpxConnect(FarAddress: String;
                   Socket: Word;
                   TimeOut: Word): LongInt;

function SpxConnGet(ConnNum: Word): Integer;

function SpxSocketNumberGet: LongInt;

function SpxDisconnect(ConnNum: Word): WordBool;

function SpxPacketSend(ConnNum: Word;
                   Packet: PByte;
                   PacketLength: Word): Integer;

function SpxPacketGet(ConnNum: Word; Length: PWord; Packet:PByte): PByte; far;

function SpxAddressGet(ConnNum: Word): String; cdecl; far;

{ SM1 }

function SemOpen(SemaphoreName: String;
                 Value: Word): LongInt;

function SemClose(SemID: LongInt): WordBool;

function SemUserGet(SemID: LongInt): Integer;

function SemValueGet(SemID: LongInt): Integer;

function SemValueIncrement(SemID: LongInt): WordBool;

{ SM2 }


function WSSemaphoreCountGet(ConnNum: Word): Integer;

function WSSemaphoreValueGet(ConnNum: Word): Integer;

function WSSemaphoreTaskList(ConnNum: Word; StartFlag: WordBool): Integer;

function WSSemaphoreList(ConnNum: Word; StartFlag: WordBool): String; cdecl; far;

function WSSemaphoreTotalGet(ConnNum: Word): Integer;

function SemWSList(SemName: String): Integer;

{ SM3 }


function SemValueDecrement(SemID: LongInt;
                   Value: Word): WordBool;

{ SV1 }


function FSNameGet(ConnNum: Word): String; cdecl; far;

function NWVersionNumberGet: String; cdecl; far;

function FSConnMaxGet: Integer;

function FSPeakConnGet: Integer;

function FSCurrentConnGet: Integer;

function FSVolumeMaxGet: Integer;

function NWRevisionNumberGet: Integer;

function FSSFTLevelGet: Integer;

function FSTTSLevelGet: Integer;

function FSAccountingVersionGet: Integer;

function FSQueueVersionNumberGet: Integer;

function PSVersionNumberGet: Integer;

function FSSecurityVersionNumberGet: Integer;


{ SV2 }


function FSLoginStatusSet(Status: WordBool): WordBool;

{ SV3 }

function FSDateGet: String; cdecl; far;
function FSDateSet(NewDate: String): String; cdecl; far;
function FSTimeGet:String; cdecl; far;
function FSTimeSet(NewTime: String): String; cdecl; far;


{ SV4 }


function FSDown(ForceFlag: WordBool): WordBool;

{ SV5 }


function NWSerialNumberGet: String;

{ SV6 }


function FSUtilisationGet: Integer;

function FSMaxObjectGet: Integer;

function FSPeakObjectGet: Integer;

function FSCurrentObjectGet: Integer;

function FSMemoryTotalGet: Integer;

function FSMemoryWastedGet: Integer;

function FSProcessGet: Integer;

{ SV7 }


function FSFilePurge(FileSpec: String;
                    All: Word): WordBool;

function FSFileSalvage(FileSpec: String): WordBool;

{ SV8 }


function FSBufferCountGet: Integer;

function FSBufferSizeGet: Integer;

function FSBufferDirtyGet: Integer;

function FSCacheHitGet: LongInt;

function FSCacheMissGet: LongInt;

{ SV9 }


function FSDiskSizeGet(Drive: Word): LongInt;

{ SVA }


function FSDiskNumberGet: Integer;

function FSDriveGet: Integer;

function FSDiskIOGet: Integer;

{ SVB }


function FSMaxFileGet: Integer;

function FSPeakFileGet: Integer;

function FSCurrentFileGet: Integer;

function FSFileOpenRequestGet: LongInt;

function FSFileReadRequestGet: LongInt;

function FSFileWriteRequestGet: LongInt;

function FSFATChangeGet: Integer;

function FSFATWriteErrorGet: Integer;

function FSFATFatalErrorGet: Integer;

function FSFATScanErrorGet: Integer;

{ SVC }


function FSLanNWAddressGet(LanBoard: Word): String; cdecl; far;
function FSLanAddressGet(LanBoard: Word): String; cdecl; far;

function FSLanNameGet(LanBoard: Word): String; cdecl; far;

function FSLanConfigGet(LanBoard: Word): String; cdecl; far;

function FSLanOptionGet(LanBoard: Word): Integer;

{ SVD }


function FilOpenFileList(ConnNo: Word;
                     Counter: Word): String; cdecl; far;

function FilOpenConnList(FileSpec: String;
                     Counter: Word): Word;

{ T1 }


function TTSInstalled: WordBool;

function TTSEnable(OnOff: WordBool): WordBool;

function TTSVolumeNumberGet: Integer;

function TTSMaxTransactionGet: Integer;

function TTSPeakTransactionGet: Integer;

function TTSFSTransactionGet: Integer;

function TTSVolumeSpaceGet: Integer;

{ T2 }


function TTSBegin: WordBool;

function TTSEnd(TTSHandle: PLongInt): WordBool;

function TTSAbort: WordBool;

function TTSStatus(TTSHandle: LongInt): WordBool;

{ T3 }


function TTSAppThresholdSet(Threshold: Word): Integer;

function TTSWSThresholdSet(Threshold: Word): Integer;

{ W1 }


function WSOSNameGet: String;

function WSOSVersionGet: String;

function WSLongNameGet: String;

function WSShortNameGet: String;

function WSShellVersionGet: String;

{ W2 }
function FSPreferredConnGet: Integer;

function FSPreferredConnSet(ConnectionID: Word): Integer;

function FSPreferredNameGet: String; cdecl; far;

function FSPreferredNameSet(FileServerName: String): String; cdecl; far;

function FSPrimaryConnGet: Integer;

function FSPrimaryConnSet(ConnectionID: Word): Integer;

function FSPrimaryNameGet: String; cdecl; far;

function FSPrimaryNameSet(FileServerName: String): String; cdecl; far;

{ Z3 }

procedure NovTaskEnd;

{ Common NetWare Bindery definitions }
Const OT_WILD                        = (-1);
Const OT_UNKNOWN                     = $00;
Const OT_USER                        = $01;
Const OT_USER_GROUP                  = $02;
Const OT_PRINT_QUEUE                 = $03;
Const OT_FILE_SERVER                 = $04;
Const OT_JOB_SERVER                  = $05;
Const OT_GATEWAY                     = $06;
Const OT_PRINT_SERVER                = $07;
Const OT_ARCHIVE_QUEUE               = $08;
Const OT_ARCHIVE_SERVER              = $09;
Const OT_JOB_QUEUE                   = $0A;
Const OT_ADMINISTRATION              = $0B;
Const OT_NAS_SNA_GATEWAY             = $21;
Const OT_REMOTE_BRIDGE_SERVER        = $24;
Const OT_ADVERTISING_PRINT_SERVER    = $47;
Const OT_BTRIEVE_VAP                 = $50;
Const OT_PRINT_QUEUE_USER            = $53;

{ prototypes }
function DirGroupAdd ( GroupID: longint; Path: String; Rights: integer): Wordbool;
function DirUserAdd ( UserID: longint; Path: String; Rights: integer): Wordbool;
function DirGroupDelete ( GroupID: longint; Path: String): WordBool;
function DirUserDelete ( UserID: longint; Path: String): WordBool;
function FSAccountServerAdd ( Server: String; ObjectType: integer): WordBool;
function FSBinderyClose : WordBool;
function FSAccountServerDelete ( Server: String; ObjectType: integer): WordBool;
function FSGroupDelete ( GroupName: String) : WordBool;
function FSQueueDelete ( QueueName: String): WordBool;
function FSUserDelete ( UserName: String): WordBool;
function FSIDGet ( ServerName: String): integer;
{ !!! function FSIsAccEnab : WordBool; }
function FSConsoleOperatorList ( ServerName: String; Offset: integer): String;
function FSGroupManagerList ( Offset: integer): String;
{ !!! function FSOpenBindery : word;  }
function FSQueueRename ( OldName: String; NewName: String): WordBool;
function GrpNameChange ( OldName: String; NewName: String): WordBool;
function GrpIDGet ( GroupName: String): longint;
function GrpNameGet ( GroupID: longint): String;
function GrpUserTest ( UserName: String; GroupName: String): WordBool;
function GrpUserList ( GroupName: String; Offset: integer): String;
function PSOperatorAdd ( UserName: String; PrintServer: String): WordBool;
function PSUserAdd ( UserName: String; PrintServer: String): WordBool;
function PSOperatorDelete ( UserName: String; PrintServer: String): WordBool;
function PSUserDelete ( UserName: String; PrintServer: String): WordBool;
function PSOperatorList ( PrintServer: String; Offset: integer): String;
function PSUserList ( PrintServer: String; Offset: integer): String;
function QueGroupAdd ( GroupName: String; QueueName: String): WordBool;
function QueOperatorAdd ( UserName: String; QueueName: String): WordBool;
function QueUserAdd ( UserName: String; QueueName: String): WordBool;
function QueGroupDelete ( GroupName: String; QueueName: String): WordBool;
function QueOperatorDelete ( UserName: String; QueueName: String): WordBool;
function QueUserDelete ( UserName: String; QueueName: String): WordBool;
function QueIDGet ( QueueName: String): longint;
function QueNameGet ( QueueID: longint): String;
function QueOperatorTest ( UserName: String; QueueName: String): WordBool;
function QueUserTest ( UserName: String; QueueName: String): WordBool;
function QueOperatorList ( QueueName: String; Offset: integer): String;
function QueUserList ( QueueName: String; Offset: integer): String;
function UsrNameChange ( CurrentName: String; NewName: String): WordBool;
function UsrPasswordChange ( UserName: String; NewPassword: String; OldPassword: String): WordBool;
function UsrPasswordCheck ( UserName: String; Password: String): WordBool;
function UsrConsoleOperatorDelete ( UserName: String): WordBool;
function UsrGroupManagerDelete ( UserName: String): WordBool;
function UsrSupervisorDelete ( UserName: String): WordBool;
function UsrIDGet ( UserName: String): longint;
function UsrNameGet ( UserID: longint): String;
function UsrConsoleOperatorTest ( UserName: String): WordBool;
function UsrGroupManagerTest ( UserName: String): WordBool;
function UsrSupervisorTest ( UserName: String): WordBool;
function UsrGroupList ( UserName: String; Offset: integer): String;
function UsrAccountBalanceSet ( UserName: String; Balance: longint): longint;
function UsrAccountLimitSet ( UserName: String; CreditLimit: longint): longint;
function UsrConsoleOperatorSet ( UserName: String): WordBool;
function UsrGroupManagerSet ( UserName: String): WordBool;
function UsrSupervisorSet ( UserName: String): WordBool;

implementation

function UsrAccountReserveGet(UserName: String;
                      Control: String): LongInt;
                      external 'NOVLIB' name 'USRACCOUNTRESERVEGET_DP16';

function UsrAccountChargeAdd(ObjectName: String;
                       ServiceType: Word;
                       ChargeAmount: LongInt;
                       CommentType: Word;
                       Comment: String): WordBool;
                       external 'NOVLIB' name 'USRACCOUNTCHARGEADD_DP16';

function UsrAccountChargeDelete(ObjectName: String;
                       ServiceType: Word;
                       CancelHold: LongInt;
                       CommentType: Word;
                       Comment: String): WordBool;
                       external 'NOVLIB' name 'USRACCOUNTCHARGEDELETE_DP16';

function UsrAccountReserveSet(ObjectName: String;
                      ReserveAmount: LongInt): WordBool;
                      external 'NOVLIB' name 'USRACCOUNTRESERVESET_DP16';

function ObjNameGet(ObjectID: LongInt): String;
                      external 'NOVLIB' name '_OBJNAMEGET_DP16';

function ObjTypeGet(ObjectID: LongInt): Word; external 'NOVLIB';

function ObjIDGet(ObjectName: String;
                  ObjectType: Word): LongInt;
                  external 'NOVLIB' name 'OBJIDGET_DP16';

function ObjPasswordCheck(ObjectName: String;
                         PassWord: String;
                         ObjectType: Word): WordBool;
                         external 'NOVLIB' name 'OBJPASSWORDCHECK_DP16';

function ObjPasswordChange(ObjectName: String;
                    PassWord1: String;
                    PassWord2: String;
                    ObjectType: Word): WordBool;
                    external 'NOVLIB' name 'OBJPASSWORDCHANGE_DP16';

function SetPropertyIDTest(ObjectName: String;
                    ObjectType: Word;
                    MemberName: String;
                    MemberType: Word;
                    PropertyName: String): WordBool;
                    external 'NOVLIB' name 'SETPROPERTYIDTEST_DP16';

function Bindery(OpenCloseFlag: WordBool): WordBool;
                    external 'NOVLIB';

function UsrDirGet(VolNumber: Word;
                   ObjectID: LongInt): LongInt;
                   external 'NOVLIB';

function UsrFileGet(VolNumber: Word;
                   ObjectID: LongInt): LongInt;
                   external 'NOVLIB';

function UsrDiskBlockGet(VolNumber: Word;
                      ObjectID: LongInt): LongInt;
                      external 'NOVLIB';

function UsrDiskFreeGet(ObjectID: LongInt): LongInt;
                      external 'NOVLIB';

function UsrVolumeFreeGet(VolNumber: Word;
                      ObjectID: LongInt): LongInt;
                      external 'NOVLIB';

function UsrVolumeRestrictGet(VolNumber: Word;
                      ObjectID: LongInt): LongInt;
                      external 'NOVLIB';

function UsrVolumeRestrictSet(VolNumber: Word;
                      ObjectID: LongInt;
                      Restriction: LongInt): LongInt;
                      external 'NOVLIB';

function FSUserAdd(ObjectName: String;
                  Password: String): WordBool;
                  external 'NOVLIB' name 'FSUSERADD_DP16';

function FSGroupAdd(ObjectName: String): WordBool;
                  external 'NOVLIB' name 'FSGROUPADD_DP16';

function FSObjectDelete(ObjectName: String;
                  ObjectType: Word): WordBool;
                  external 'NOVLIB' name 'FSOBJECTDELETE_DP16';

function FSObjectAdd(ObjectName: String;
                  ObjectType: Word;
                  ObjectFlag: Word;
                  ObjectSec: Word): WordBool;
                  external 'NOVLIB' name 'FSOBJECTADD_DP16';

function ObjNameChange(OldName: String;
                   NewName: String;
                   ObjectType: Word): WordBool;
                   external 'NOVLIB' name 'OBJNAMECHANGE_DP16';

function GrpUserAdd(SourceObj: String;
                   TargetObj: String): WordBool;
                   external 'NOVLIB' name 'GRPUSERADD_DP16';

function GrpUserDelete(SourceObj: String;
                   TargetObj: String): WordBool;
                   external 'NOVLIB' name 'GRPUSERDELETE_DP16';

function SetPropertyIDAdd(ObjectName: String;
                     ObjectType: Word;
                     MemberName: String;
                     MemberType: Word;
                     PropertyName: String): WordBool;
                     external 'NOVLIB' name 'SETPROPERTYIDADD_DP16';

function SetPropertyIDDelete(ObjectName: String;
                     ObjectType: Word;
                     MemberName: String;
                     MemberType: Word;
                     PropertyName: String): WordBool;
                     external 'NOVLIB' name 'SETPROPERTYIDDELETE_DP16';

function FSObjectList(ObjectName: String;
                  ObjectType: Word; StartFlag: WordBool): String;
                  external 'NOVLIB' name '_FSOBJECTLIST_DP16';

function OBJFlagGet(ObjectName: String;
                   ObjectType: Word): Word;
                   external 'NOVLIB' name 'OBJFLAGGET_DP16';

function ObjSecurityGet(ObjectName: String;
                   ObjectType: Word): Word;
                   external 'NOVLIB' name 'OBJSECURITYGET_DP16';

function ObjPropertyTest(ObjectName: String;
                   ObjectType: Word): WordBool;
                   external 'NOVLIB' name 'OBJPROPERTYTEST_DP16';

function UsrFullNameSet(ObjectName: String;
                      FullName: String): String;
                      external 'NOVLIB' name '_USRFULLNAMESET_DP16';

function UsrFullNameGet(ObjectName: String): String;
                      external 'NOVLIB' name '_USRFULLNAMEGET_DP16';

function ItmPropertyStringSet(ObjectName: String;
                      ObjectType: Word;
                      PropertyName: String;
                      Segment: Word;
                      Value: String): String;
                      external 'NOVLIB' name '_ITMPROPERTYSTRINGSET_DP16';

function ItmPropertyStringGet(ObjectName: String;
                      ObjectType: Word;
                      PropertyName: String;
                      Segment: Word): String;
                      external 'NOVLIB' name '_ITMPROPERTYSTRINGGET_DP16';

function ItmPropertyValueSet(ObjectName: String;
                      ObjectType: Word;
                      PropertyName: String;
                      Segment: Word;
                      Value: String): String;
                      external 'NOVLIB' name '_ITMPROPERTYVALUESET_DP16';


function ItmPropertyValueGet(ObjectName: String;
                      ObjectType: Word;
                      PropertyName: String;
                      Segment: Word): String;
                      external 'NOVLIB' name '_ITMPROPERTYVALUEGET_DP16';

function SetPropertyValueSet(ObjectName: String;
                      ObjectType: Word;
                      PropertyName: String;
                      Element: Word;
                      Value: LongInt): LongInt;
                      external 'NOVLIB' name 'SETPROPERTYVALUESET_DP16';

function SetPropertyValueGet(ObjectName: String;
                      ObjectType: Word;
                      PropertyName: String;
                      Element: Word): LongInt;
                      external 'NOVLIB' name 'SETPROPERTYVALUEGET_DP16';

function ItmPropertyByteSet(ObjectName: String;
                       ObjectType: Word;
                       PropertyName: String;
                       Element: Word;
                       Value: String): Word;
                       external 'NOVLIB' name 'ITMPROPERTYBYTESET_DP16';

function ItmPropertyByteGet(ObjectName: String;
                       ObjectType: Word;
                       PropertyName: String;
                       Element: Word): Word;
                       external 'NOVLIB' name 'ITMPROPERTYBYTEGET_DP16';

function ObjPropertyAdd(ObjectName: String;
                   ObjectType: Word;
                   PropertyName: String;
                   PropertyFlags: BYTE;
                   PropertySecurity: BYTE): WordBool;
                   external 'NOVLIB' name 'OBJPROPERTYADD_DP16';

function FSWSAttach(ServerName: String): Integer;
                   external 'NOVLIB' name 'FSWSATTACH_DP16';

function FSConnIDGet(ServerName: String): Integer;
                   external 'NOVLIB' name 'FSCONNIDGET_DP16';

function ObjPropertyList(ObjectName: String;
                   ObjectType: Word;
                   PropertyName: String; StartFlag: WordBool): String;
                   external 'NOVLIB' name '_OBJPROPERTYLIST_DP16';

function PrpFlagGet(ObjectName: String;
                   ObjectType: Word;
                   PropertyName: String): Integer; external 'NOVLIB' name 'PRPFLAGGET_DP16';

function PrpSecurityGet(ObjectName: String;
                   ObjectType: Word;
                   PropertyName: String): Integer; external 'NOVLIB' name 'PRPSECURITYGET_DP16';

function PrpValueTest(ObjectName: String;
                   ObjectType: Word;
                   PropertyName: String): WordBool; external 'NOVLIB' name 'PRPVALUETEST_DP16';

function ObjPropertyDelete(ObjectName: String;
                   ObjectType: Word;
                   PropertyName: String): WordBool; external 'NOVLIB' name 'OBJPROPERTYDELETE_DP16';

function WSConnNumberGet: Integer; external 'NOVLIB';

function WSLoginNameGet(ConnNum: Word): String;
                    external 'NOVLIB' name '_WSLOGINNAMEGET_DP16';

function WSLoginTypeGet(ConnNum: Word): Integer; external 'NOVLIB';

function WSLoginIDGet(ConnNum: Word): LongInt; external 'NOVLIB';

function WSLoginDateGet(ConnNum: Word): String;
                    external 'NOVLIB' name '_WSLOGINDATEGET_DP16';

function WSLoginTimeGet(ConnNum: Word): String;
                    external 'NOVLIB' name '_WSLOGINTIMEGET_DP16';

function WSConnClear(ConnNum: Word): WordBool; external 'NOVLIB';

function LokWSGet(FileSpec: String;
                  RecNo: LongInt;
                  Format: Word): Integer;
                  external 'NOVLIB' name 'LOKWSGET_DP16';

function UsrConnList(ObjectName: String): Integer; external 'NOVLIB' name 'USRCONNLIST_DP16';

function ConnUsed(ConnectionEntry: Word): WordBool; external 'NOVLIB';

function FSWSLogin(ObjectName: String;
                   Password: String;
                   ObjectType: Word): WordBool;
                   external 'NOVLIB' name 'FSWSLOGIN_DP16';

function FSWSLogout(ServerName: String;
                    DetachFlag: WordBool): WordBool;
                    external 'NOVLIB' name 'FSWSLOGOUT_DP16';

function FSWSDetach(ServerName: String): WordBool;
                    external 'NOVLIB' name 'FSWSDETACH_DP16';

function WSNetAddressGet(ConnNo: Word): String;
                      external 'NOVLIB' name '_WSNETADDRESSGET_DP16';

function WSNodeAddressGet(ConnNo: Word): String;
                    external 'NOVLIB' name '_WSNODEADDRESSGET_DP16';

function UsrCurConsoleOperatorTest: WordBool; external 'NOVLIB';

function FSReadLevelGet: Integer; external 'NOVLIB';

function FSWriteLevelGet: Integer; external 'NOVLIB';

function DirObjectAdd(ObjectID: LongInt;
                   FileName: String;
                   RightsMask: Word): WordBool;
                   external 'NOVLIB' name 'DIROBJECTADD_DP16';

function DirObjectDelete(ObjectID: LongInt;
                   FileName: String): WordBool;
                   external 'NOVLIB' name 'DIROBJECTDELETE_DP16';

function DrvDirHandleGet(Drive: Word): Integer; external 'NOVLIB';

function DrvFlagGet(Drive: Word): Integer; external 'NOVLIB';

function DrvCurrentSet(Drive: String): String;
                   external 'NOVLIB' name '_DRVCURRENTSET_DP16';

function DrvCurrentGet: String;
                   external 'NOVLIB' name '_DRVCURRENTGET_DP16';

function DirEffectiveRightsGet(FileName: String): Integer; external 'NOVLIB' name 'DIREFFECTIVERIGHTSGET_DP16';

function WSEnvFreeGet: Integer; external 'NOVLIB';

function WSEnvSizeGet: Integer; external 'NOVLIB';

function WSEnvVariableSet(VarName: String;
                     NewVar: String): String;
                     external 'NOVLIB' name '_WSENVVARIABLESET_DP16';

function WSEnvVariableGet(VarName: String): String;
                     external 'NOVLIB' name '_WSENVVARIABLEGET_DP16';

function SchVectorPathSet: WordBool; external 'NOVLIB';

function SchOrderDriveGet(SearchOrder: Word): String;
                      external 'NOVLIB' name '_SCHORDERDRIVEGET_DP16';

function SchVectorDriveDelete(SearchOrder: Word): WordBool; external 'NOVLIB';

function DrvSearchOrderGet(Drive: String): Integer; external 'NOVLIB' name 'DRVSEARCHORDERGET_SP16';

function DrvDirMap(Path: String;
                   Drive: String;
                   Temp: Word): Integer; external 'NOVLIB' name 'DRVDIRMAP_DP16';

function DrvMapDelete(Drive: String): WordBool; external 'NOVLIB' name 'DRVMAPDELETE_DP16';

function SchDriveMapDelete(SearchOrder: Word): WordBool; external 'NOVLIB';

function SchVectorSet(NewVector: String): String;
                   external 'NOVLIB' name '_SCHVECTORSET_DP16';

function WSDriveLocalGet: Integer; external 'NOVLIB';

function SchVectorDriveAdd(Drive: String;
                      SearchOrder: Word): WordBool; external 'NOVLIB' name 'SCHVECTORDRIVEADD_DP16';

function SchDriveDirectoryMap(Drive: String;
                      Path: String;
                      SearchOrder: Word): Integer;
                      external 'NOVLIB' name 'SCHDRIVEDIRECTORYMAP_DP16';

function WSDriveNetGet: String;
                      external 'NOVLIB' name '_WSDRIVENETGET_DP16';

function DrvNextFreeGet: String;
                     external 'NOVLIB' name '_DRVNEXTFREEGET_DP16';

function DrvRootMap(Drive: String;
                    Path: String): WordBool; external 'NOVLIB' name 'DRVROOTMAP_DP16';

function ObjDirList(VolNumber: Word;
                   ObjectID: LongInt; StartFlag: WordBool): String;
                   external 'NOVLIB' name '_OBJDIRLIST_DP16';

function DirAccessRightsGet: Integer; external 'NOVLIB';

function NovRightsString(Rights: Word): String;
                      external 'NOVLIB' name '_NOVRIGHTSSTRING_DP16';

function NovRightsValue(Mask: String): Word;
                      external 'NOVLIB' name 'NOVRIGHTSVALUE_DP16';

function VolNumberGet(VolName: String): Integer;
                   external 'NOVLIB' name 'VOLNUMBERGET_DP16';

function VolNameGet(VolNumber: Word): String;
                   external 'NOVLIB' name '_VOLNAMEGET_DP16';

function VolMaxBlockGet(VolNumber: Word): LongInt; external 'NOVLIB';

function VolBlockSizeGet(VolNumber: Word): Integer; external 'NOVLIB';

function VolBlockFreeGet(VolNumber: Word): LongInt; external 'NOVLIB';

function VolBlockPurgeableGet(VolNumber: Word): LongInt; external 'NOVLIB';

function VolBlockNotPurgeableGet(VolNumber: Word): LongInt; external 'NOVLIB';

function VolDirMaxGet(VolNumber: Word): LongInt; external 'NOVLIB';

function VolDirFreeGet(VolNumber: Word): LongInt; external 'NOVLIB';

function VolRemoveableTest(VolNumber: Word): WordBool; external 'NOVLIB';

function FSDirAdd(Directory: String;
                  Rights: Word): WordBool;
                  external 'NOVLIB' name 'FSDIRADD_DP16';

function FSDirDelete(Directory: String): WordBool;
                  external 'NOVLIB' name 'FSDIRDELETE_DP16';

function DirNameChange(Directory: String;
                   NewName: String): WordBool;
                   external 'NOVLIB' name 'DIRNAMECHANGE_DP16';

function DirSubDirList(FileSpec: String;
                      NewName: String): String;
                      external 'NOVLIB' name '_DIRSUBDIRLIST_DP16';

function DirAttributeGet(FileSpec: String): LongInt;
                   external 'NOVLIB' name 'DIRATTRIBUTEGET_DP16';

function DirAttributeSet(FileSpec: String;
                   Attributes: LongInt): LongInt;
                   external 'NOVLIB' name 'DIRATTRIBUTESET_DP16';

function DirTypeGet(FileSpec: String): Integer; external 'NOVLIB' name 'DIRTYPEGET_DP16';

function DirCreateDateGet(FileSpec: String): String;
                      external 'NOVLIB' name '_DIRCREATEDATEGET_DP16';

function DirCreateDateSet(FileSpec: String;
                      Date: String): String;
                      external 'NOVLIB' name '_DIRCREATEDATESET_DP16';

function DirCreateTimeGet(FileSpec: String): String;
                      external 'NOVLIB' name '_DIRCREATETIMEGET_DP16';

function DirCreateTimeSet(FileSpec: String;
                      Time: String): String;
                      external 'NOVLIB' name '_DIRCREATETIMESET_DP16';

function DirOwnerIDGet(FileSpec: String): LongInt;
                     external 'NOVLIB' name 'DIROWNERIDGET_DP16';

function DirOwnerIDSet(FileSpec: String;
                     NewID: LongInt): LongInt;
                     external 'NOVLIB' name 'DIROWNERIDSET_DP16';

function DirArchiveDateGet(FileSpec: String): String;
                      external 'NOVLIB' name '_DIRARCHIVEDATEGET_DP16';

function DirArchiveDateSet(FileSpec: String;
                      Date: String): String;
                      external 'NOVLIB' name '_DIRARCHIVEDATESET_DP16';

function DirArchiveTimeGet(FileSpec: String): String;
                      external 'NOVLIB' name '_DIRARCHIVETIMEGET_DP16';

function DirArchiveTimeSet(FileSpec: String;
                      Time: String): String;
                      external 'NOVLIB' name '_DIRARCHIVETIMESET_DP16';

function DirArchiveIDGet(FileSpec: String): LongInt;
                     external 'NOVLIB' name 'DIRARCHIVEIDGET_DP16';


function DirArchiveIDSet(FileSpec: String;
                     ObjectID: LongInt): LongInt;
                     external 'NOVLIB' name 'DIRARCHIVEIDSET_DP16';

function DirModifyDateGet(FileSpec: String): String;
                      external 'NOVLIB' name '_DIRMODIFYDATEGET_DP16';

function DirModifyDateSet(FileSpec: String;
                      Date: String): String;
                      external 'NOVLIB' name '_DIRMODIFYDATESET_DP16';

function DirModifyTimeGet(FileSpec: String): String;
                      external 'NOVLIB' name '_DIRMODIFYTIMEGET_DP16';


function DirModifyTimeSet(FileSpec: String;
                      Time: String): String;
                      external 'NOVLIB' name '_DIRMODIFYTIMESET_DP16';

function DirIRMaskGet(FileSpec: String): Integer;
                     external 'NOVLIB' name 'DIRIRSMASKGET_DP16';


function DirIRMaskSet(FileSpec: String;
                     Mask: Word): Integer;
                     external 'NOVLIB' name 'DIRIRMASKSET_DP16';

function DirFileList(FileSpec: String;
                   NewName: String): String;
                   external 'NOVLIB' name '_DIRFILELIST_DP16';

function FilAttributeGet(FileSpec: String): LongInt;
                   external 'NOVLIB' name 'FILATTRIBUTEGET_DP16';

function FilAttributeSet(FileSpec: String;
                   NewAttributes: LongInt): LongInt;
                   external 'NOVLIB' name 'FILATTRIBUTESET_DP16';

function FilTypeGet(FileSpec: String): Integer;
                   external 'NOVLIB' name 'FILTYPEGET_DP16';

function FilCreateDateGet(FileSpec: String): String;
                      external 'NOVLIB' name '_FILCREATEDATEGET_DP16';

function FilCreateDateSet(FileSpec: String;
                      Date: String): String;
                      external 'NOVLIB' name '_FILCREATEDATESET_DP16';

function FilCreateTimeGet(FileSpec: String): String;
                      external 'NOVLIB' name '_FILCREATETIMEGET_DP16';

function FilCreateTimeSet(FileSpec: String;
                      Time: String): String;
                      external 'NOVLIB' name '_FILCREATETIMESET_DP16';

function FilOwnerIDGet(FileSpec: String): LongInt; external 'NOVLIB' name 'FILOWNERIDGET_DP16';


function FilOwnerIDSet(FileSpec: String;
                     ObjectID: LongInt): LongInt; external 'NOVLIB' name 'FILOWNERIDSET_DP16';

function FilArchiveDateGet(FileSpec: String): String;
                      external 'NOVLIB' name '_FILARCHIVEDATEGET_DP16';


function FilArchiveDateSet(FileSpec: String;
                      Date: String): String;
                      external 'NOVLIB' name '_FILARCHIVEDATESET_DP16';

function FilArchiveTimeGet(FileSpec: String): String;
                      external 'NOVLIB' name '_FILARCHIVETIMEGET_DP16';


function FilArchiveTimeSet(FileSpec: String;
                      Time: String): String;
                      external 'NOVLIB' name '_FILARCHIVETIMESET_DP16';

function FilArchiveIDGet(FileSpec: String): LongInt;
                      external 'NOVLIB' name 'FILARCHIVEIDGET_DP16';

function FilArchiveIDSet(FileSpec: String;
                     ObjectID: LongInt): LongInt; external 'NOVLIB' name 'FILARCHIVEIDSET_DP16';

function FilModifyDateGet(FileSpec: String): String;
                      external 'NOVLIB' name '_FILMODIFYDATEGET_DP16';


function FilModifyDateSet(FileSpec: String;
                      Date: String): String;
                      external 'NOVLIB' name '_FILMODIFYDATESET_DP16';

function FilModifyTimeGet(FileSpec: String): String;
                      external 'NOVLIB' name '_FILMODIFYTIMEGET_DP16';

function FilModifyTimeSet(FileSpec: String;
                      Time: String): String;
                      external 'NOVLIB' name '_FILMODIFYTIMESET_DP16';

function FilModifyIDGet(FileSpec: String): LongInt;
                     external 'NOVLIB' name 'FILMODIFYIDGET_DP16';


function FilModifyIDSet(FileSpec: String;
                     ObjectID: LongInt): LongInt;
                     external 'NOVLIB' name 'FILMODIFYIDSET_DP16';

function FilAccessDateGet(FileSpec: String): String;
                      external 'NOVLIB' name '_FILACCESSDATEGET_DP16';

function FilAccessDateSet(FileSpec: String;
                      Date: String): String;
                      external 'NOVLIB' name '_FILACCESSDATESET_DP16';

function FilIRMaskGet(FileSpec: String): Integer;
                     external 'NOVLIB' name 'FILIRMASKGET_DP16';


function FilIRMaskSet(FileSpec: String;
                     Mask: Word): Integer;
                     external 'NOVLIB' name 'FILIRMASKSET_DP16';

function NovAttributeString(Rights : Longint): String;
                     external 'NOVLIB' name '_NOVATTRIBUTESTRING_DP16';

function NovAttributeValue(Mask : string): Longint;
                     external 'NOVLIB' name 'NOVATTRIBUTEVALUE_DP16';

function DrvPathGet(Drive: String): String;
                   external 'NOVLIB' name '_DRVPATHGET_DP16';

function DrvFSIDGet(Drive: String): Integer; external 'NOVLIB' name 'DRVFSIDGET_DP16';

function DrvDirDepthGet(Drive: String): Integer; external 'NOVLIB' name 'DRVDIRDEPTHGET_DP16';

function FilNetCopy(SourceFile: String;
                   DestFile: String;
                   SourceOffset: LongInt;
                   DestOffset: LongInt;
                   NumOfBytes: LongInt): LongInt; external 'NOVLIB' name 'FILNETCOPY_DP16';

function DFLDirEntryGet: LongInt; external 'NOVLIB';

function DirDeletedFileList(Path: String): String;
                   external 'NOVLIB' name '_DIRDELETEDFILELIST_DP16';

function DflAttributeGet: LongInt; external 'NOVLIB';

function DflTypeGet: Integer; external 'NOVLIB';

function DflArchiveDateGet: String; external 'NOVLIB' name '_DFLARCHIVEDATEGET_DP16';

function DflArchiveTimeGet: String;  external 'NOVLIB' name '_DFLARCHIVETIMEGET_DP16';

function DflArchiveIDGet: LongInt; external 'NOVLIB';

function DflModifyDateGet: String;  external 'NOVLIB' name '_DFLMODIFYDATEGET_DP16';

function DflModifyTimeGet: String;  external 'NOVLIB' name '_DFLMODIFYTIMEGET_DP16';

function DflModifyIDGet: LongInt; external 'NOVLIB';

function DflAccessDateGet: String;  external 'NOVLIB' name '_DFLACCESSDATEGET_DP16';

function DflDeleteDateGet: String;  external 'NOVLIB' name '_DFLDELETEDATEGET_DP16';

function DflDeleteTimeGet: String;  external 'NOVLIB' name '_DFLDELETETIMEGET_DP16';

function DflDeleteIDGet: LongInt; external 'NOVLIB';

function IPXInstalled: WordBool; external 'NOVLIB';

function IPXOpen(Socket: Word): Integer; external 'NOVLIB';

procedure IPXSocketClose; external 'NOVLIB';

function IPXAddressGet: String; external 'NOVLIB' name '_IPXADDRESSGET_DP16';

function IPXPacketSend(FarAddress: String;
                   Packet: PByte;
                   PacketLength: Word): Integer; external 'NOVLIB' name 'IPXPACKETSEND_DP16';

function IPXSocketOpen(Socket: Word): Integer; external 'NOVLIB';

function IPXPacketGet(userbuff: PByte): PByte; external 'NOVLIB';

function IPXSocketNumberGet: Word; external 'NOVLIB';

function FSMessageLog(Message: String): WordBool; external 'NOVLIB' name 'FSMESSAGELOG_DP16';

function FSMessageSend(Message: String): WordBool; external 'NOVLIB' name 'FSMESSAGESEND_DP16';

function WSMessageSend(Connection: Word;
                  Message: String): WordBool; external 'NOVLIB' name 'WSMESSAGESEND_DP16';

function WSMessageModeSet(Mode: Word): Integer; external 'NOVLIB' name 'WSMESSAGEMODESET_DP16';

function WSMessageGet: String;  external 'NOVLIB' name '_WSMESSAGEGET_DP16';

function NovVersionGet: String;  external 'NOVLIB' name '_NOVVERSIONGET_DP16';

function NWErrorGet: Integer; external 'NOVLIB';

function NWGetErrorGet: Integer; external 'NOVLIB';

function NWSetErrorGet: Integer; external 'NOVLIB';

function NovIntSwap(Value: Word): Word; external 'NOVLIB';

function NovLongSwap(Value: LongInt): LongInt; external 'NOVLIB';

function FSWSSynchronize: Word; external 'NOVLIB';

function FSPrinterStoppedTest(Printer: Word): WordBool; external 'NOVLIB';

function FSPrinterOfflineTest(Printer: Word): WordBool; external 'NOVLIB';

function FSPrinterFormGet(Printer: Word): Integer; external 'NOVLIB';

function FSPrinterNumberGet(Printer: Word): Integer; external 'NOVLIB';

function CapStart(LPTPort: Word): WordBool; external 'NOVLIB';

function CapEnd(LPTPort: Word): WordBool; external 'NOVLIB';

function CapFlush(LPTPort: Word): WordBool; external 'NOVLIB';

function CapCancel(LPTPort: Word): WordBool; external 'NOVLIB';

function DefaultLpt(LPTPort: Word): Integer; external 'NOVLIB';

function CapFSGet(LPTPort: Word): String;
                   external 'NOVLIB' name '_CAPFSGET_DP16';

function CapSetupStringGet(LPTPort: Word): String;
                       external 'NOVLIB' name '_CAPSETUPSTRINGGET_DP16';

function CapSetupStringSet(LPTPort: Word;
                      NewString: String): String;
                       external 'NOVLIB' name '_CAPSETUPSTRINGSET_DP16';

function CapResetStringGet(LPTPort: Word): String;
                       external 'NOVLIB' name '_CAPRESETSTRINGGET_DP16';


function CapResetStringSet(LPTPort: Word;
                      NewString: String): String;
                       external 'NOVLIB' name '_CAPRESETSTRINGGET_DP16';

function CapKeepGet(LPTPort: Word): WordBool; external 'NOVLIB';

function CapKeepSet(LPTPort: Word;
                    Flag: WordBool): WordBool; external 'NOVLIB';

function CapAutoEndGet(LPTPort: Word): WordBool; external 'NOVLIB';

function CapAutoEndSet(LPTPort: Word;
                       Flag: WordBool): WordBool; external 'NOVLIB';

function CapFormFeedGet(LPTPort: Word): WordBool; external 'NOVLIB';

function CapFormFeedSet(LPTPort: Word;
                      Flag: WordBool): WordBool; external 'NOVLIB';

function CapBannerFlagGet(LPTPort: Word): WordBool; external 'NOVLIB';

function CapBannerFlagSet(LPTPort: Word;
                      Flag: WordBool): WordBool; external 'NOVLIB';

function CapTabFlagGet(LPTPort: Word): WordBool; external 'NOVLIB';

function CapTabFlagSet(LPTPort: Word;
                      Flag: WordBool): WordBool; external 'NOVLIB';

function CapNotifyFlagGet(LPTPort: Word): WordBool; external 'NOVLIB';

function CapNotifyFlagSet(LPTPort: Word;
                      Flag: WordBool): WordBool; external 'NOVLIB';

function CapSetup(LPTPort: Word): WordBool; external 'NOVLIB';

function CapTabSizeGet(LPTPort: Word): Integer; external 'NOVLIB';

function CapTabSizeSet(LPTPort: Word;
                      TabSize: Word): Integer; external 'NOVLIB';

function CapFSPrinterGet(LPTPort: Word): Integer; external 'NOVLIB';

function CapFSPrinterSet(LPTPort: Word;
                     PRNNo: Word): Integer; external 'NOVLIB';

function CapCopiesGet(LPTPort: Word): Integer; external 'NOVLIB';

function CapCopiesSet(LPTPort: Word;
                      Copies: Word): Integer; external 'NOVLIB';

function CapFormNumberGet(LPTPort: Word): Integer; external 'NOVLIB';

function CapFormNumberSet(LPTPort: Word;
                     FormNo: Word): Integer; external 'NOVLIB';

function CapMaxLineGet(LPTPort: Word): Integer; external 'NOVLIB';

function CapMaxLineSet(LPTPort: Word;
                      NewMax: Word): Integer; external 'NOVLIB';

function CapMaxCharGet(LPTPort: Word): Integer; external 'NOVLIB';

function CapMaxCharSet(LPTPort: Word;
                      NewMax: Word): Integer; external 'NOVLIB';

function CapTimeOutGet(LPTPort: Word): Integer; external 'NOVLIB';

function CapTimeOutSet(LPTPort: Word;
                      NewTime: Word): Integer; external 'NOVLIB';

function CapBannerTextGet(LPTPort: Word): String;
                       external 'NOVLIB' name '_CAPBANNERTEXTGET_DP16';

function CapBannerTextSet(LPTPort: Word;
                      NewName: String): String;
                       external 'NOVLIB' name '_CAPBANNERTEXTSET_DP16';

function CapFormNameGet(LPTPort: Word): String;
                      external 'NOVLIB' name '_CAPFORMNAMEGET_DP16';

function CapFormNameSet(LPTPort: Word;
                     FormName: String): String;
                      external 'NOVLIB' name '_CAPFORMNAMESET_DP16';

function CapBannerNameGet: String;
                      external 'NOVLIB' name '_CAPBANNERNAMEGET_DP16';

function CapBannerNameSet(BannerName: String): String;
                       external 'NOVLIB' name '_CAPBANNERNAMESET_DP16';

function CapActiveTest(LPTPort: Word): WordBool; external 'NOVLIB';

function CapQueueGet(LPTPort: Word): LongInt; external 'NOVLIB';

function CapQueueSet(LPTPort: Word;
                   ObjectID: LongInt): LongInt; external 'NOVLIB';

function FSQueueAdd(QueueName: String;
                  Path: String;
                  QType: Word): WordBool; external 'NOVLIB' name 'FSQUEUEADD_DP16';

function QueAddStateGet(ObjectID: LongInt): WordBool; external 'NOVLIB';

function QueAddStateSet(ObjectID: LongInt;
                   Value: WordBool): WordBool; external 'NOVLIB';

function QueServiceStateGet(ObjectID: LongInt): WordBool; external 'NOVLIB';

function QueServiceStateSet(ObjectID: LongInt;
                   Value: WordBool): WordBool; external 'NOVLIB';

function QueHaltGet(ObjectID: LongInt): WordBool; external 'NOVLIB';

function QueHaltSet(ObjectID: LongInt;
                 Value: WordBool): WordBool; external 'NOVLIB';

function QueQjbList(ObjectID: LongInt; StartFlag: WordBool): Integer; external 'NOVLIB';

function QjbSizeGet(ObjectID: LongInt;
                    JobNum: Word): LongInt; external 'NOVLIB';

function QueQjbDelete(ObjectID: LongInt;
                   JobNum: Word): WordBool; external 'NOVLIB';

function QjbTimeGet(ObjectID: LongInt;
                   JobNum: Word): String;
                    external 'NOVLIB' name '_QJBTIMEGET_DP16';

function QjbDateGet(ObjectID: LongInt;
                   JobNum: Word): String;
                    external 'NOVLIB' name '_QJBDATEGET_DP16';

function QjbDeferDateGet(ObjectID: LongInt;
                     JobNum: Word): String;
                     external 'NOVLIB' name '_QJBDEFERDATEGET_DP16';


function QjbDeferDateSet(ObjectID: LongInt;
                     JobNum: Word;
                     NewDate: String): String;
                     external 'NOVLIB' name '_QJBDEFERDATESET_DP16';

function QjbDeferTimeGet(ObjectID: LongInt;
                     JobNum: Word): String;
                      external 'NOVLIB' name '_QJBDEFERTIMEGET_DP16';


function QjbDeferTimeSet(ObjectID: LongInt;
                     JobNum: Word;
                     NewTime: String): String;
                      external 'NOVLIB' name '_QJBDEFERTIMESET_DP16';

function QjbWSGet(ObjectID: LongInt;
                  JobNum: Word): Integer; external 'NOVLIB';

function QjbUserIDGet(ObjectID: LongInt;
                     JobNum: Word): LongInt; external 'NOVLIB';

function QjbAddingTest(ObjectID: LongInt;
                     JobNum: Word): WordBool; external 'NOVLIB';

function QjbFlagGet(ObjectID: LongInt;
                   JobNum: Word): Integer; external 'NOVLIB';

function QjbFlagSet(ObjectID: LongInt;
                   JobNum: Word;
                   NewFlags: Word): Integer; external 'NOVLIB';

function QjbRestartGet(ObjectID: LongInt;
                       JobNum: Word): WordBool; external 'NOVLIB';

function QjbRestartSet(ObjectID: LongInt;
                       JobNum: Word;
                       Restart: WordBool): WordBool; external 'NOVLIB';

function QjbOperatorHoldGet(ObjectID: LongInt;
                      JobNum: Word): WordBool; external 'NOVLIB';

function QjbOperatorHoldSet(ObjectID: LongInt;
                      JobNum: Word;
                      Hold: WordBool): WordBool; external 'NOVLIB';

function QjbUserHoldGet(ObjectID: LongInt;
                      JobNum: Word): WordBool; external 'NOVLIB';

function QjbUserHoldSet(ObjectID: LongInt;
                      JobNum: Word;
                      Hold: WordBool): WordBool; external 'NOVLIB';

function QjbDescriptionGet(ObjectID: LongInt;
                    JobNum: Word): String;
                     external 'NOVLIB' name '_QJBDESCRIPTIONGET_DP16';

function QjbDescriptionSet(ObjectID: LongInt;
                    JobNum: Word;
                    Desc: String): String;
                     external 'NOVLIB' name '_QJBDESCRIPTIONSET_DP16';

function QjbFileNameGet(ObjectID: LongInt;
                      JobNum: Word): String;
                      external 'NOVLIB' name '_QJBFILENAMEGET_DP16';

function QjbPositionGet(ObjectID: LongInt;
                   JobNum: Word): Integer; external 'NOVLIB';

function QjbPositionSet(ObjectID: LongInt;
                   JobNum: Word;
                   Position: Word): Integer; external 'NOVLIB';

function QjbCopiesGet(ObjectID: LongInt;
                      JobNum: Word): Integer; external 'NOVLIB';

function QjbCopiesSet(ObjectID: LongInt;
                      JobNum: Word;
                      Copies: Word): Integer; external 'NOVLIB';

function QjbBannerGet(ObjectID: LongInt;
                      JobNum: Word): String;
                      external 'NOVLIB' name '_QJBBANNERGET_DP16';

function QjbBannerSet(ObjectID: LongInt;
                      JobNum: Word;
                      Banner: String): String;
                      external 'NOVLIB' name '_QJBBANNERSET_DP16';

function QueFileAdd(ObjectID: LongInt;
                   FileSpec: String;
                   Flags: Word;
                   Description: String;
                   Copies: Word;
                   ControlFlags: Word;
                   ServerID: LongInt): Integer; external 'NOVLIB' name 'QUEFILEADD_DP16';

function SpxInstalled: WordBool; external 'NOVLIB';

function SpxVersionNumberGet: String;  external 'NOVLIB' name '_SPXVERSIONNUMBERGET_DP16';

function SpxMaxConnGet: Integer; external 'NOVLIB';

function SpxFreeConnGet: Integer; external 'NOVLIB';

function PSWSAttach(Pserver: String): LongInt; external 'NOVLIB' name 'PSWSATTACH_DP16';

function PSWSDetach(ConnectionNum: Word): WordBool; external 'NOVLIB';

function PSSocketNumberGet: Word; external 'NOVLIB';

function PSConnNumberGet: Word; external 'NOVLIB';

function PSWSLogin(Pserver: String): Integer; external 'NOVLIB' name 'PSWSLOGIN_DP16';

function PSWSLogout: WordBool; external 'NOVLIB';

function PSDown(DownNow: Word;
                OutCome: Word): WordBool; external 'NOVLIB';

function PrnJobAbort(PrinterNo: Word;
                   OutCome: Word): WordBool; external 'NOVLIB';

function PrnStart(PrinterNo: Word): WordBool; external 'NOVLIB';

function PrnStop(PrinterNo: Word;
                 OutCome: Word): WordBool; external 'NOVLIB';

function PrnEject(PrinterNo: Word): WordBool; external 'NOVLIB';

function PrnNotifyObjectAdd(PrinterNo: Word;
                      ServerName: String;
                      ObjectName: String;
                      FirstTime: Word;
                      NextTime: Word;
                      ObjectType: Word): WordBool; external 'NOVLIB' name 'PRNNOTIFYOBJECTADD_DP16';

function PrnNotifyObjectDelete(PrinterNo: Word;
                      ServerName: String;
                      ObjectName: String;
                      ObjectType: Word): WordBool; external 'NOVLIB' name 'PRNNOTIFYOBJECTDELETE_DP16';

function PrnNotifyPeriodChange(PrinterNo: Word;
                      ServerName: String;
                      ObjectName: String;
                      FirstTime: Word;
                      NextTime: Word;
                      ObjectType: Word): WordBool; external 'NOVLIB' name 'PRNNOTIFYPERIODCHANGE_DP16';

function PrnFormTopMark(PrinterNo: Word;
                      MarkChar: String): WordBool; external 'NOVLIB' name 'PRNFORMTOPMARK_DP16';

function PjbFSGet(PrinterNo: Word): String;
                   external 'NOVLIB' name '_PJBFSGET_DP16';

function PjbQueueGet(PrinterNo: Word): String;
                    external 'NOVLIB' name '_PJBQUEUEGET_DP16';

function PjbNumberGet(PrinterNo: Word): Integer; external 'NOVLIB';

function PjbDescriptionGet(PrinterNo: Word): String;
                     external 'NOVLIB' name '_PJBDESCRIPTIONGET_DP16';

function PjbCopyToDoGet(PrinterNo: Word): Integer; external 'NOVLIB';

function PjbSizeGet(PrinterNo: Word): LongInt; external 'NOVLIB';

function PjbCopyDoneGet(PrinterNo: Word): Integer; external 'NOVLIB';

function PjbByteDoneGet(PrinterNo: Word): LongInt; external 'NOVLIB';

function PjbFormNumberGet(PrinterNo: Word): Integer; external 'NOVLIB';

function PjbTextTest(PrinterNo: Word): WordBool; external 'NOVLIB';

function PrnStatusGet(PrinterNo: Word): Integer; external 'NOVLIB';

function PrnErrorStatusGet(PrinterNo: Word): Integer; external 'NOVLIB';

function PjbActiveTest(PrinterNo: Word): WordBool; external 'NOVLIB';

function PrnQueueModeGet(PrinterNo: Word;
                      Mode: Word): Integer; external 'NOVLIB';

function PrnFormNumberSet(PrinterNo: Word;
                     FormNum: Word): Integer; external 'NOVLIB';

function PrnFormNameGet(PrinterNo: Word): String;
                      external 'NOVLIB' name '_PRNFORMNAMEGET_DP16';

function PrnNameGet(PrinterNo: Word): String;
                    external 'NOVLIB' name '_PRNNAMEGET_DP16';

function PjbRewind(PrinterNo: Word;
                   ByPage: Word;
                   Relative: Word;
                   Copy: Word;
                   Offset: LongInt): WordBool;  external 'NOVLIB';

function PrnQueueAdd(PrinterNo: Word;
                   ServerName: String;
                   QueueName: String;
                   Priority: Word): WordBool; external 'NOVLIB' name 'PRNQUEUEADD_DP16';

function PrnQueuePriorityChange(PrinterNo: Word;
                      ServerName: String;
                      QueueName: String;
                      Priority: Word): WordBool; external 'NOVLIB' name 'PRNQUEUEPRIORITYCHANGE_DP16';

function PrnQueueDelete(PrinterNo: Word;
                   ServerName: String;
                   QueueName: String;
                   Kill: Word;
                   OutCome: Word): WordBool; external 'NOVLIB' name 'PRNQUEUEDELETE_DP16';

function PrnQueueList(PrinterNumber: Word; StartFlag: WordBool): String;
                    external 'NOVLIB' name '_PRNQUEUELIST_DP16';

function PrnQueueFSGet: String;  external 'NOVLIB' name '_PRNQUEUEFSGET_DP16';

function PrnQueuePriorityGet: Integer; external 'NOVLIB';

function PSFSList(StartFlag: WordBool): String;
                  external 'NOVLIB' name '_PSFSLIST_DP16';

function PrnNotifyObjectList(PrinterNumber: Word; StartFlag: WordBool): String;
                       external 'NOVLIB' name '_PRNNOTIFYOBJECTLIST_D16';

function NfyObjectServerGet: String;  external 'NOVLIB' name '_NFYOBJECTSERVERGET_DP16';

function NfyObjectTypeGet: LongInt; external 'NOVLIB';

function NfyObjectFirstIntervalGet: LongInt; external 'NOVLIB';

function NfyObjectNextIntervalGet: LongInt; external 'NOVLIB';

function SpxConnect(FarAddress: String;
                   Socket: Word;
                   TimeOut: Word): LongInt; external 'NOVLIB' name 'SPXCONNECT_DP16';

function SpxConnGet(ConnNum: Word): Integer; external 'NOVLIB';

function SpxSocketNumberGet: LongInt; external 'NOVLIB';

function SpxDisconnect(ConnNum: Word): WordBool; external 'NOVLIB';

function SpxPacketSend(ConnNum: Word;
                   Packet: PByte;
                   PacketLength: Word): Integer; external 'NOVLIB';

function SpxPacketGet(ConnNum: Word; Length: PWord; Packet: PByte): PByte; external 'NOVLIB';

function SpxAddressGet(ConnNum: Word): String;
                        external 'NOVLIB' name '_SPXCONNADDRESSGET_DP16';

function SemOpen(SemaphoreName: String;
                 Value: Word): LongInt; external 'NOVLIB' name 'SEMOPEN_DP16';

function SemClose(SemID: LongInt): WordBool;  external 'NOVLIB';

function SemUserGet(SemID: LongInt): Integer;  external 'NOVLIB';

function SemValueGet(SemID: LongInt): Integer;  external 'NOVLIB';

function SemValueIncrement(SemID: LongInt): WordBool;  external 'NOVLIB';

function WSSemaphoreCountGet(ConnNum: Word): Integer;  external 'NOVLIB';

function WSSemaphoreValueGet(ConnNum: Word): Integer;  external 'NOVLIB';

function WSSemaphoreTaskList(ConnNum: Word; StartFlag: WordBool): Integer;  external 'NOVLIB';

function WSSemaphoreList(ConnNum: Word; StartFlag: WordBool): String;
                   external 'NOVLIB' name '_WSSEMAPHORELIST_DP16';

function WSSemaphoreTotalGet(ConnNum: Word): Integer;  external 'NOVLIB';

function SemWSList(SemName: String): Integer;  external 'NOVLIB' name 'SEMWSLIST_DP16';

function SemValueDecrement(SemID: LongInt;
                   Value: Word): WordBool;  external 'NOVLIB';

function FSNameGet(ConnNum: Word): String;
                   external 'NOVLIB' name '_FSNAMEGET_DP16';

function NWVersionNumberGet: String;
                      external 'NOVLIB' name '_NWVERSIONNUMBERGET_DP16';

function FSConnMaxGet: Integer;  external 'NOVLIB';

function FSPeakConnGet: Integer;  external 'NOVLIB';

function FSCurrentConnGet: Integer;  external 'NOVLIB';

function FSVolumeMaxGet: Integer;  external 'NOVLIB';

function NWRevisionNumberGet: Integer;  external 'NOVLIB';

function FSSFTLevelGet: Integer;  external 'NOVLIB';

function FSTTSLevelGet: Integer;  external 'NOVLIB';

function FSAccountingVersionGet: Integer;  external 'NOVLIB';

function FSQueueVersionNumberGet: Integer;  external 'NOVLIB';

function PSVersionNumberGet: Integer;  external 'NOVLIB';

function FSSecurityVersionNumberGet: Integer;  external 'NOVLIB';

function FSLoginStatusSet(Status: WordBool): WordBool;  external 'NOVLIB';

function FSDateGet: String; external 'NOVLIB' name '_FSDATEGET_DP16';

function FSDateSet(NewDate: String): String;
                   external 'NOVLIB' name '_FSDATESET_DP16';

function FSTimeGet: String; external 'NOVLIB' name '_FSTIMEGET_DP16';

function FSTimeSet(NewTime: String): String;
                   external 'NOVLIB' name '_FSTIMESET_DP16';

function FSDown(ForceFlag: WordBool): WordBool;  external 'NOVLIB';

function NWSerialNumberGet: String;
                      external 'NOVLIB' name '_NWSERIALNUMBERGET_DP16';

function FSUtilisationGet: Integer;  external 'NOVLIB';

function FSMaxObjectGet: Integer;  external 'NOVLIB';

function FSPeakObjectGet: Integer;  external 'NOVLIB';

function FSCurrentObjectGet: Integer;  external 'NOVLIB';

function FSMemoryTotalGet: Integer;  external 'NOVLIB';

function FSMemoryWastedGet: Integer;  external 'NOVLIB';

function FSProcessGet: Integer;  external 'NOVLIB';

function FSFilePurge(FileSpec: String;
                    All: Word): WordBool;  external 'NOVLIB' name 'FSFILEPURGE_DP16';

function FSFileSalvage(FileSpec: String): WordBool;  external 'NOVLIB' name 'FSFILESALVAGE_DP16';

function FSBufferCountGet: Integer;  external 'NOVLIB';

function FSBufferSizeGet: Integer;  external 'NOVLIB';

function FSBufferDirtyGet: Integer;  external 'NOVLIB';

function FSCacheHitGet: LongInt;  external 'NOVLIB';

function FSCacheMissGet: LongInt;  external 'NOVLIB';

function FSDiskSizeGet(Drive: Word): LongInt;  external 'NOVLIB';

function FSDiskNumberGet: Integer;  external 'NOVLIB';

function FSDriveGet: Integer;  external 'NOVLIB';

function FSDiskIOGet: Integer;  external 'NOVLIB';

function FSMaxFileGet: Integer;  external 'NOVLIB';

function FSPeakFileGet: Integer;  external 'NOVLIB';

function FSCurrentFileGet: Integer;  external 'NOVLIB';

function FSFileOpenRequestGet: LongInt;  external 'NOVLIB';

function FSFileReadRequestGet: LongInt;  external 'NOVLIB';

function FSFileWriteRequestGet: LongInt;  external 'NOVLIB';

function FSFatChangeGet: Integer;  external 'NOVLIB';

function FSFatWriteErrorGet: Integer;  external 'NOVLIB';

function FSFatFatalErrorGet: Integer;  external 'NOVLIB';

function FSFatScanErrorGet: Integer;  external 'NOVLIB';

function FSLanNWAddressGet(LanBoard: Word): String;
                        external 'NOVLIB' name '_FSLANNWADDRESSGET_DP16' ;

function FSLanAddressGet(LanBoard: Word): String;
                      external 'NOVLIB' name '_FSLANADDRESSGET_DP16';

function FSLanNameGet(LanBoard: Word): String;
                      external 'NOVLIB' name '_FSLANNAMEGET_DP16';

function FSLanConfigGet(LanBoard: Word): String;
                         external 'NOVLIB' name '_FSLANCONFIGGET_DP16';

function FSLanOptionGet(LanBoard: Word): Integer;  external 'NOVLIB';

function FilOpenFileList(ConnNo: Word;
                     Counter: Word): String;  external 'NOVLIB' name '_FILOPENFILELIST_DP16';

function FilOpenConnList(FileSpec: String;
                     Counter: Word): Word;  external 'NOVLIB' name 'FILOPENCONNLIST_DP16';

function TTSInstalled: WordBool;  external 'NOVLIB';

function TTSEnable(OnOff: WordBool): WordBool;  external 'NOVLIB';

function TTSVolumeNumberGet: Integer;  external 'NOVLIB';

function TTSMaxTransactionGet: Integer;  external 'NOVLIB';

function TTSPeakTransactionGet: Integer;  external 'NOVLIB';

function TTSFSTransactionGet: Integer;  external 'NOVLIB';

function TTSVolumeSpaceGet: Integer;  external 'NOVLIB';

function TTSBegin: WordBool;  external 'NOVLIB';

function TTSEnd(TTSHandle: PLongInt): WordBool;  external 'NOVLIB';

function TTSAbort: WordBool;  external 'NOVLIB';

function TTSStatus(TTSHandle: LongInt): WordBool;  external 'NOVLIB';

function TTSAppThresholdSet(Threshold: Word): Integer;  external 'NOVLIB';

function TTSWSThresholdSet(Threshold: Word): Integer;  external 'NOVLIB';

function WSOSNameGet: String;  external 'NOVLIB' name '_WSOSNAMEGET_DP16' ;

function WSOSVersionGet: String;  external 'NOVLIB' name '_WSOSVERSIONGET_DP16' ;

function WSLongNameGet: String;  external 'NOVLIB' name '_WSLONGNAMEGET_DP16' ;

function WSShortNameGet: String;  external 'NOVLIB' name '_WSSHORTNAMEGET_DP16' ;

function WSShellVersionGet: String;  external 'NOVLIB' name '_WSSHELLVERSIONGET_DP16';

function FSPreferredConnGet: Integer;  external 'NOVLIB';

function FSPreferredConnSet(ConnectionID: Word): Integer;  external 'NOVLIB';

function FSPreferredNameGet: String;  external 'NOVLIB' name '_FSPREFERREDNAMEGET_DP16';

function FSPreferredNameSet(FileServerName: String): String;  external 'NOVLIB' name '_FSPREFERREDNAMESET_DP16';

function FSPrimaryConnGet: Integer;  external 'NOVLIB';

function FSPrimaryConnSet(ConnectionID: Word): Integer;  external 'NOVLIB';

function FSPrimaryNameGet: String;  external 'NOVLIB' name '_FSPRIMARYNAMEGET_DP16';

function FSPrimaryNameSet(FileServerName: String): String;  external 'NOVLIB' name '_FSPRIMARYNAMESET_DP16';

procedure NovTaskEnd;  external 'NOVLIB';

{----------------------------------------}
function DirGroupAdd ( GroupID: longint; Path: String; Rights: integer): WordBool;
begin
        DirGroupAdd := DirObjectAdd(GroupID, Path, Rights);
end;
{----------------------------------------}
function DirUserAdd ( UserID: longint; Path: String; Rights: integer): WordBool;
begin
        DirUserAdd := DirObjectAdd(UserID, Path, Rights);
end;
{----------------------------------------}
function DirGroupDelete ( GroupID: longint; Path: String): WordBool;
begin
        DirGroupDelete := DirObjectDelete(GroupID, Path);
end;
{----------------------------------------}
function DirUserDelete ( UserID: longint; Path: String): WordBool;
begin
        DirUserDelete := DirObjectDelete(UserID, Path);
end;
{----------------------------------------}
function FSAccountServerAdd ( Server: String; ObjectType: integer): WordBool;
begin
   FSAccountServerAdd := SetPropertyIDAdd(FSNameGet(NOVDEFINT), OT_FILE_SERVER,
                                     Server, ObjectType, 'ACCOUNT_SERVERS');
end;
{----------------------------------------}
function FSBinderyClose : WordBool;
begin
        FSBinderyClose := Bindery(TRUE);
end;
{----------------------------------------}
function FSAccountServerDelete ( Server: String; ObjectType: integer): WordBool;
begin
     FSAccountServerDelete := SetPropertyIDDelete(FSNameGet(NOVDEFINT), OT_FILE_SERVER,
                                Server, ObjectType, 'ACCOUNT_SERVERS');
end;
{----------------------------------------}
function FSGroupDelete ( GroupName: String): WordBool;
begin
        FSGroupDelete := FSObjectDelete(GroupName, OT_USER_GROUP);
end;
{----------------------------------------}
function FSQueueDelete ( QueueName: String): WordBool;
begin
        FSQueueDelete := FSObjectDelete(QueueName, OT_PRINT_QUEUE);
end;
{----------------------------------------}
function FSUserDelete ( UserName: String): WordBool;
begin
        FSUserDelete := FSObjectDelete(UserName, OT_USER);
end;
{----------------------------------------}
function FSIDGet ( ServerName: String): integer;
begin
        FSIDGet := ObjIDGet(ServerName, OT_FILE_SERVER);
end;
{----------------------------------------}
function FSAccountingEnabledTest : Boolean;
begin
        FSAccountingEnabledTest := (FSAccountingVersionGet = 1);
end;
{----------------------------------------}
function FSConsoleOperatorList ( ServerName: String; Offset: integer): String;
begin
  FSConsoleOperatorList := ObjNameGet(SetPropertyValueGet(ServerName, OT_FILE_SERVER,
              'OPERATORS', Offset));
end;
{----------------------------------------}
function FSGroupManagerList ( Offset: integer): String;
begin
  FSGroupManagerList := ObjNameGet(SetPropertyValueGet('SUPERVISOR', OT_USER,
                                      'MANAGERS', Offset));
end;
{----------------------------------------}
function FSBinderyOpen : WordBool;
begin
        FSBinderyOpen := Bindery(FALSE);
end;
{----------------------------------------}
function FSQueueRename ( OldName: String; NewName: String): WordBool;
begin
        FSQueueRename := ObjNameChange(OldName, NewName, OT_PRINT_QUEUE);
end;
{----------------------------------------}
function GrpNameChange ( OldName: String; NewName: String): WordBool;
begin
     GrpNameChange := ObjNameChange(OldName, NewName, OT_USER_GROUP);
end;
{----------------------------------------}
function GrpIDGet ( GroupName: String): longint;
begin
  GrpIDGet := ObjIDGet(GroupName, OT_USER_GROUP);
end;
{----------------------------------------}
function GrpNameGet ( GroupID: longint): String;
begin
  GrpNameGet := ObjNameGet(GroupID);
end;
{----------------------------------------}
function GrpUserTest ( UserName: String; GroupName: String): WordBool;
begin
  GrpUserTest := SetPropertyIDTest(GroupName, OT_USER_GROUP, UserName, OT_USER, 'GROUP_MEMBERS');
end;
{----------------------------------------}
function GrpUserList ( GroupName: String; Offset: integer): String;
begin
  GrpUserList := ObjNameGet(SetPropertyValueGet(GroupName, OT_USER_GROUP,
               'GROUP_MEMBERS', Offset));
end;
{----------------------------------------}
function PSOperatorAdd ( UserName: String; PrintServer: String): WordBool;
begin
  PSOperatorAdd := SetPropertyIDAdd(PrintServer, OT_Print_SERVER, UserName,
                OT_USER, 'PS_OPERATORS');
end;
{----------------------------------------}
function PSUserAdd ( UserName: String; PrintServer: String): WordBool;
begin
  PSUserAdd := SetPropertyIDAdd(PrintServer, OT_Print_SERVER, UserName,
                 OT_USER, 'PS_USERS');
end;
{----------------------------------------}
function PSOperatorDelete ( UserName: String; PrintServer: String): WordBool;
begin
  PSOperatorDelete := SetPropertyIDDelete(PrintServer, OT_Print_SERVER, UserName,
             OT_USER, 'PS_OPERATORS');
end;
{----------------------------------------}
function PSUserDelete ( UserName: String; PrintServer: String): WordBool;
begin
  PSUserDelete := SetPropertyIDDelete(PrintServer, OT_Print_SERVER, UserName,
            OT_USER, 'PS_USERS');
end;
{----------------------------------------}
function PSOperatorList ( PrintServer: String; Offset: integer): String;
begin
  PSOperatorList := ObjNameGet(SetPropertyValueGet(PrintServer, OT_Print_SERVER,
            'PS_OPERATORS', Offset));
end;
{----------------------------------------}
function PSUserList ( PrintServer: String; Offset: integer): String;
begin
  PSUserList := ObjNameGet(SetPropertyValueGet(PrintServer,
     OT_Print_SERVER, 'PS_USERS', Offset));
end;
{----------------------------------------}
function QueGroupAdd ( GroupName: String; QueueName: String): WordBool;
begin
  QueGroupAdd := SetPropertyIDAdd(QueueName, OT_PRINT_QUEUE, GroupName, OT_USER_GROUP, 'Q_USERS');
end;
{----------------------------------------}
function QueOperatorAdd ( UserName: String; QueueName: String): WordBool;
begin
  QueOperatorAdd := SetPropertyIDAdd(QueueName, OT_PRINT_QUEUE, UserName, OT_USER, 'Q_OPERATORS');
end;
{----------------------------------------}
function QueUserAdd ( UserName: String; QueueName: String): WordBool;
begin
  QueUserAdd := SetPropertyIDAdd(QueueName, OT_PRINT_QUEUE, UserName, OT_USER, 'Q_USERS');
end;
{----------------------------------------}
function QueGroupDelete ( GroupName: String; QueueName: String): WordBool;
begin
  QueGroupDelete := SetPropertyIDDelete(QueueName, OT_PRINT_QUEUE, GroupName, OT_USER_GROUP, 'Q_USERS');
end;
{----------------------------------------}
function QueOperatorDelete ( UserName: String; QueueName: String): WordBool;
begin
  QueOperatorDelete := SetPropertyIDDelete(QueueName, OT_PRINT_QUEUE, UserName, OT_USER, 'Q_OPERATORS');
end;
{----------------------------------------}
function QueUserDelete ( UserName: String; QueueName: String): WordBool;
begin
  QueUserDelete := SetPropertyIDDelete(QueueName, OT_PRINT_QUEUE, UserName, OT_USER, 'Q_USERS');
end;
{----------------------------------------}
function QueIDGet ( QueueName: String): longint;
begin
  QueIDGet := ObjIDGet(QueueName, OT_PRINT_QUEUE);
end;
{----------------------------------------}
function QueNameGet ( QueueID: longint): String;
begin
  QueNameGet := ObjNameGet(QueueID);
end;
{----------------------------------------}
function QueOperatorTest( UserName: String; QueueName: String): WordBool;
begin
  QueOperatorTest := SetPropertyIDTest(QueueName, OT_PRINT_QUEUE, UserName, OT_USER, 'Q_OPERATORS');
end;
{----------------------------------------}
function QueUserTest ( UserName: String; QueueName: String): WordBool;
begin
  QueUserTest := SetPropertyIDTest(QueueName, OT_PRINT_QUEUE, UserName, OT_USER, 'Q_USERS');
end;
{----------------------------------------}
function QueOperatorList ( QueueName: String; Offset: integer): String;
begin
  QueOperatorList := ObjNameGet(SetPropertyValueGet(QueueName, OT_PRINT_QUEUE,
              'Q_OPERATORS', Offset));
end;
{----------------------------------------}
function QueUserList ( QueueName: String; Offset: integer): String;
begin
  QueUserList := ObjNameGet(SetPropertyValueGet(QueueName, OT_PRINT_QUEUE,
            'Q_USERS', Offset));
end;
{----------------------------------------}
function UsrNameChange ( CurrentName: String; NewName: String): WordBool;
begin
  UsrNameChange := ObjNameChange(CurrentName, NewName, OT_USER);
end;
{----------------------------------------}
function UsrPasswordChange ( UserName: String; NewPassword: String; OldPassword: String): WordBool;
begin
  UsrPasswordChange := ObjPasswordChange(UserName, NewPassword, OldPassword, OT_USER);
end;
{----------------------------------------}
function UsrPasswordCheck ( UserName: String; Password: String): WordBool;
begin
  UsrPasswordCheck := ObjPasswordCheck(UserName, Password, OT_USER);
end;
{----------------------------------------}
function UsrConsoleOperatorDelete ( UserName: String): WordBool;
begin
  UsrConsoleOperatorDelete := SetPropertyIDDelete(FSNameGet(NOVDEFINT),
          OT_FILE_SERVER, UserName, OT_USER, 'OPERATORS');
end;
{----------------------------------------}
function UsrGroupManagerDelete ( UserName: String): WordBool;
begin
  UsrGroupManagerDelete := SetPropertyIDDelete('SUPERVISOR', OT_USER, UserName, OT_USER, 'MANAGERS');
end;
{----------------------------------------}
function UsrSupervisorDelete ( UserName: String): WordBool;
begin
  UsrSupervisorDelete := SetPropertyIDDelete(UserName, OT_USER, 'SUPERVISOR', OT_USER, 'SECURITY_EQUALS');
end;
{----------------------------------------}
function UsrIDGet ( UserName: String): longint;
begin
  UsrIDGet := ObjIDGet(UserName, OT_USER);
end;
{----------------------------------------}
function UsrNameGet ( UserID: longint): String;
begin
  UsrNameGet := ObjNameGet(UserID);
end;
{----------------------------------------}
function UsrConsoleOperatorTest ( UserName: String): WordBool;
begin
  UsrConsoleOperatorTest := SetPropertyIDTest(FSNameGet(NOVDEFINT), OT_FILE_SERVER, UserName, OT_USER, 'OPERATORS');
end;
{----------------------------------------}
function UsrGroupManagerTest ( UserName: String): WordBool;
begin
  UsrGroupManagerTest := SetPropertyIDTest('SUPERVISOR', OT_USER, UserName, OT_USER, 'MANAGERS');
end;
{----------------------------------------}
function UsrSupervisorTest ( UserName: String): WordBool;
begin
  UsrSupervisorTest := SetPropertyIDTest(UserName, OT_USER, 'SUPERVISOR', OT_USER, 'SECURITY_EQUALS');
end;
{----------------------------------------}
function UsrGroupList ( UserName: String; Offset: integer): String;
begin
  UsrGroupList := ObjNameGet(SetPropertyValueGet(UserName, OT_USER, 'GROUPS_I''M_IN', Offset));
end;
{----------------------------------------}
function UsrAccountBalanceSet( UserName: String; Balance: longint): longint;
begin
  UsrAccountBalanceSet := SetPropertyValueSet(UserName, OT_USER, 'ACCOUNT_BALANCE', 1, Balance);
end;
{----------------------------------------}
function UsrAccountLimitSet ( UserName: String; CreditLimit: longint): longint;
begin
  UsrAccountLimitSet := SetPropertyValueSet(UserName, OT_USER, 'ACCOUNT_BALANCE', 2, CreditLimit);
end;
{----------------------------------------}
function UsrConsoleOperatorSet ( UserName: String): WordBool;
begin
  UsrConsoleOperatorSet := SetPropertyIDAdd(FSNameGet(NOVDEFINT), OT_FILE_SERVER, UserName, OT_USER, 'OPERATORS');
end;
{----------------------------------------}
function UsrGroupManagerSet ( UserName: String): WordBool;
begin
  UsrGroupManagerSet := SetPropertyIDAdd('SUPERVISOR', OT_USER, UserName, OT_USER, 'MANAGERS');
end;
{----------------------------------------}
function UsrSupervisorSet ( UserName: String): WordBool;
begin
  UsrSupervisorSet := SetPropertyIDAdd(UserName, OT_USER, 'SUPERVISOR', OT_USER, 'SECURITY_EQUALS');
end;
end.
