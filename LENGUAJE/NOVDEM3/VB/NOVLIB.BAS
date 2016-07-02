'-----------------------------------------
'
'   Novlib 3.0 Visual Basic Support
'   Copyright (C) ASM Incorporated, 1992, 96
'
'-----------------------------------------
'
' Common NetWare Bindery definitions
'
Global Const OT_WILD% = (-1)
Global Const OT_UNKNOWN% = &H0
Global Const OT_USER% = &H1
Global Const OT_USER_GROUP% = &H2
Global Const OT_PRINT_QUEUE% = &H3
Global Const OT_FILE_SERVER% = &H4
Global Const OT_JOB_SERVER% = &H5
Global Const OT_GATEWAY% = &H6
Global Const OT_PRINT_SERVER% = &H7
Global Const OT_ARCHIVE_QUEUE% = &H8
Global Const OT_ARCHIVE_SERVER% = &H9
Global Const OT_JOB_QUEUE% = &HA
Global Const OT_ADMINISTRATION% = &HB
Global Const OT_NAS_SNA_GATEWAY% = &H21
Global Const OT_REMOTE_BRIDGE_SERVER% = &H24
Global Const OT_TIME_SYNCHRONIZATION_SERVER% = &H2D
Global Const OT_ARCHIVE_SERVER_DYNAMIC_SAP% = &H2E
Global Const OT_ADVERTISING_PRINT_SERVER% = &H47
Global Const OT_BTRIEVE_VAP% = &H50
Global Const OT_PRINT_QUEUE_USER% = &H53

Global Const NOVERRINT% = -1
Global Const NOVERRLONG& = -1&

Global Const NOVDEFINT% = -1
Global Const NOVDEFLONG& = -1&

Declare Function Bindery Lib "NOVLIB.DLL" (ByVal Flag As Integer) As Integer
Declare Function CapActiveTest Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapAutoEndGet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapAutoEndSet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer, ByVal NewFlag As Integer) As Integer
Declare Function CapBannerFlagGet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapBannerFlagSet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer, ByVal NewFlag As Integer) As Integer
Declare Function CapBannerNameGet Lib "NOVLIB.DLL" Alias "CAPBANNERNAMEGET_VB16" () As String
Declare Function CapBannerNameSet Lib "NOVLIB.DLL" Alias "CAPBANNERNAMESET_VB16" (ByVal NewBanner As String) As String
Declare Function CapBannerTextGet Lib "NOVLIB.DLL" Alias "CAPBANNERTEXTGET_VB16" (ByVal LPTNumber As Integer) As String
Declare Function CapBannerTextSet Lib "NOVLIB.DLL" Alias "CAPBANNERTEXTSET_VB16" (ByVal LPTNumber As Integer, ByVal NewText As String) As String
Declare Function CapCancel Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapCopiesGet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapCopiesSet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer, ByVal NewCopies As Integer) As Integer
Declare Function CapEnd Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapFlush Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapFormFeedGet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapFormFeedSet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer, ByVal NewFlag As Integer) As Integer
Declare Function CapFormNameGet Lib "NOVLIB.DLL" Alias "CAPFORMNAMEGET_VB16" (ByVal LPTNumber As Integer) As String
Declare Function CapFormNameSet Lib "NOVLIB.DLL" Alias "CAPFORMNAMESET_VB16" (ByVal LPTNumber As Integer, ByVal NewForm As String) As String
Declare Function CapFormNumberGet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapFormNumberSet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer, ByVal NewFormNumber As Integer) As Integer
Declare Function CapFSGet Lib "NOVLIB.DLL" Alias "CAPFSGET_VB16" (ByVal LPTNumber As Integer) As String
Declare Function CapFSPrinterGet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapFSPrinterSet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer, ByVal NewPinter As Integer) As Integer
Declare Function CapKeepGet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapKeepSet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer, ByVal NewFlag As Integer) As Integer
Declare Function CapMaxCharGet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapMaxCharSet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer, ByVal NewMaxChars As Integer) As Integer
Declare Function CapMaxLineGet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapMaxLineSet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer, ByVal NewLines As Integer) As Integer
Declare Function CapNotifyFlagGet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapNotifyFlagSet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer, ByVal NewFlag As Integer) As Integer
Declare Function CapQueueGet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Long
Declare Function CapQueueSet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer, ByVal QueueID As Long) As Long
Declare Function CapResetStringGet Lib "NOVLIB.DLL" Alias "CAPRESETSTRINGGET_VB16" (ByVal LPTNumber As Integer) As String
Declare Function CapResetStringSet Lib "NOVLIB.DLL" Alias "CAPRESETSTRINGSET_VB16" (ByVal LPTNumber As Integer, ByVal NewString As String) As String
Declare Function CapSetup Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapSetupStringGet Lib "NOVLIB.DLL" Alias "CAPSETUPSTRINGGET_VB16" (ByVal LPTNumber As Integer) As String
Declare Function CapSetupStringSet Lib "NOVLIB.DLL" Alias "CAPSETUPSTRINGSET_VB16" (ByVal LPTNumber As Integer, ByVal NewString As String) As String
Declare Function CapStart Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapTabFlagGet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapTabFlagSet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer, ByVal NewFlag As Integer) As Integer
Declare Function CapTabSizeGet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapTabSizeSet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer, ByVal NewTabSize As Integer) As Integer
Declare Function CapTimeOutGet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer) As Integer
Declare Function CapTimeOutSet Lib "NOVLIB.DLL" (ByVal LPTNumber As Integer, ByVal Newtimeout As Integer) As Integer
Declare Function ConnUsed Lib "NOVLIB.DLL" (ByVal ConnectionEntry As Integer) As Integer
Declare Function DefaultLPT Lib "NOVLIB.DLL" (ByVal Port As Integer) As Integer
Declare Function DflAccessDateGet Lib "NOVLIB.DLL" Alias "DFLACCESSDATEGET_VB16" () As String
Declare Function DflArchiveDateGet Lib "NOVLIB.DLL" Alias "DFLARCHIVEDATEGET_VB16" () As String
Declare Function DflArchiveIDGet Lib "NOVLIB.DLL" () As Long
Declare Function DflArchiveTimeGet Lib "NOVLIB.DLL" Alias "DFLARCHIVETIMEGET_VB16" () As String
Declare Function DflAttributeGet Lib "NOVLIB.DLL" () As Long
Declare Function DflDeleteDateGet Lib "NOVLIB.DLL" Alias "DFLDELETEDATEGET_VB16" () As String
Declare Function DflDeleteIDGet Lib "NOVLIB.DLL" () As Long
Declare Function DflDeleteTimeGet Lib "NOVLIB.DLL" Alias "DFLDELETETIMEGET_VB16" () As String
Declare Function DflDirEntryGet Lib "NOVLIB.DLL" () As Long
Declare Function DflModIDGet Lib "NOVLIB.DLL" () As Long
Declare Function DflModifyDateGet Lib "NOVLIB.DLL" Alias "DFLMODIFYDATEGET_VB16" () As String
Declare Function DflModifyTimeGet Lib "NOVLIB.DLL" Alias "DFLMODIFYTIMEGET_VB16" () As String
Declare Function DflTypeGet Lib "NOVLIB.DLL" () As Integer
Declare Function DirAccessRightsGet Lib "NOVLIB.DLL" () As Integer
Declare Function DirArchiveDateGet Lib "NOVLIB.DLL" Alias "DIRARCHIVEDATEGET_VB16" (ByVal Path As String) As String
Declare Function DirArchiveDateSet Lib "NOVLIB.DLL" Alias "DIRARCHIVEDATESET_VB16" (ByVal Path As String, ByVal NewDate As String) As String
Declare Function DirArchiveIDGet Lib "NOVLIB.DLL" (ByVal Path As String) As Long
Declare Function DirArchiveIDSet Lib "NOVLIB.DLL" (ByVal Path As String, ByVal NewID As Long) As Long
Declare Function DirArchiveTimeGet Lib "NOVLIB.DLL" Alias "DIRARCHIVETIMEGET_VB16" (ByVal Path As String) As String
Declare Function DirArchiveTimeSet Lib "NOVLIB.DLL" Alias "DIRARCHIVETIMESET_VB16" (ByVal Path As String, ByVal NewTime As String) As String
Declare Function DirCreateDateGet Lib "NOVLIB.DLL" Alias "DIRCREATEDATESET_VB16" (ByVal Path As String) As String
Declare Function DirCreateDateSet Lib "NOVLIB.DLL" Alias "DIRCREATEDATESET_VB16" (ByVal Path As String, ByVal NewDate As String) As String
Declare Function DirCreateTimeGet Lib "NOVLIB.DLL" Alias "DIRCREATETIMEGET_VB16" (ByVal Path As String) As String
Declare Function DirCreateTimeSet Lib "NOVLIB.DLL" Alias "DIRCREATETIMESET_VB16" (ByVal Path As String, ByVal NewTime As String) As String
Declare Function DirDeletedFileList Lib "NOVLIB.DLL" Alias "DIRDELETEDFILELIST_VB16" (ByVal Path As String) As String
Declare Function DirEffectiveRightsGet Lib "NOVLIB.DLL" (ByVal Path As String) As Integer
Declare Function DirFileList Lib "NOVLIB.DLL" Alias "DIRFILELIST_VB16" (ByVal FileSpec As String, ByVal NewName As String) As String
Declare Function DirIRMaskGet Lib "NOVLIB.DLL" (ByVal Path As String) As Integer
Declare Function DirIRMaskSet Lib "NOVLIB.DLL" (ByVal Path As String, ByVal NewMask As Integer) As Integer
Declare Function DirModifyDateGet Lib "NOVLIB.DLL" Alias "DIRMODIFYDATEGET_VB16" (ByVal Path As String) As String
Declare Function DirModifyDateSet Lib "NOVLIB.DLL" Alias "DIRMODIFYDATESET_VB16" (ByVal Path As String, ByVal NewDate As String) As String
Declare Function DirModifyTimeGet Lib "NOVLIB.DLL" Alias "DIRMODIFYTIMEGET_VB16" (ByVal Path As String) As String
Declare Function DirModifyTimeSet Lib "NOVLIB.DLL" Alias "DIRMODIFYTIMESET_VB16" (ByVal Path As String, ByVal NewTime As String) As String
Declare Function DirNameChange Lib "NOVLIB.DLL" (ByVal OldName As String, ByVal NewName As String) As Integer
Declare Function DirObjectAdd Lib "NOVLIB.DLL" (ByVal ObjectID As Long, ByVal Path As String, ByVal Rights As Integer) As Integer
Declare Function DirObjectDelete Lib "NOVLIB.DLL" (ByVal ObjectID As Long, ByVal Path As String) As Integer
Declare Function DirOwnerIDGet Lib "NOVLIB.DLL" (ByVal Path As String) As Long
Declare Function DirOwnerIDSet Lib "NOVLIB.DLL" (ByVal Path As String, ByVal NewID As Long) As Long
Declare Function DirAttributeGet Lib "NOVLIB.DLL" (ByVal Path As String, ByVal NewAtt As Long) As Long
Declare Function DirAttributeSet Lib "NOVLIB.DLL" (ByVal Path As String, ByVal NewAtt As Long) As Long
Declare Function DirSubDirList Lib "NOVLIB.DLL" Alias "DIRSUBDIRLIST_VB16" (ByVal FileSpec As String, ByVal NewName As String) As String
Declare Function DirTypeGet Lib "NOVLIB.DLL" (ByVal Path As String) As Integer
Declare Function DrvCurrentGet Lib "NOVLIB.DLL" Alias "DRVCURRENTGET_VB16" () As String
Declare Function DrvCurrentSet Lib "NOVLIB.DLL" Alias "DRVCURRENTSET_VB16" (ByVal Drive As String) As String
Declare Function DrvDirDepthGet Lib "NOVLIB.DLL" (ByVal Drive As String) As Integer
Declare Function DrvDirHandleGet Lib "NOVLIB.DLL" (ByVal Drive As Integer) As Integer
Declare Function DrvDirMap Lib "NOVLIB.DLL" (ByVal Path As String, ByVal Drive As String, ByVal Temp As Integer) As Integer
Declare Function DrvFlagGet Lib "NOVLIB.DLL" (ByVal Drive As Integer) As Integer
Declare Function DrvGetFSID Lib "NOVLIB.DLL" (ByVal Drive As String) As Integer
Declare Function DrvMapDelete Lib "NOVLIB.DLL" (ByVal Drive As String) As Integer
Declare Function DrvMapRoot Lib "NOVLIB.DLL" (ByVal Drive As String, ByVal Path As String) As Integer
Declare Function DrvNextFreeGet Lib "NOVLIB.DLL" Alias "DRVNEXTFREEGET_VB16" () As String
Declare Function DrvPathGet Lib "NOVLIB.DLL" Alias "DRVPATHGET_VB16" (ByVal Drive As String) As String
Declare Function DrvSearchOrderGet Lib "NOVLIB.DLL" (ByVal Drive As String) As Integer
Declare Function FilAccessDateGet Lib "NOVLIB.DLL" Alias "FILACCESSDATEGET_VB16" (ByVal Path As String) As String
Declare Function FilAccessDateSet Lib "NOVLIB.DLL" Alias "FILACCESSDATESET_VB16" (ByVal Path As String, ByVal NewDate As String) As String
Declare Function FilArchiveDateGet Lib "NOVLIB.DLL" Alias "FILARCHIVEDATEGET_VB16" (ByVal Path As String) As String
Declare Function FilArchiveDateSet Lib "NOVLIB.DLL" Alias "FILARCHIVEDATESET_VB16" (ByVal Path As String, ByVal NewDate As String) As String
Declare Function FilArchiveIDGet Lib "NOVLIB.DLL" (ByVal Path As String) As Long
Declare Function FilArchiveIDSet Lib "NOVLIB.DLL" (ByVal Path As String, ByVal NewID As Long) As Long
Declare Function FilArchiveTimeGet Lib "NOVLIB.DLL" Alias "FILARCHIVETIMEGET_VB16" (ByVal Path As String) As String
Declare Function FilArchiveTimeSet Lib "NOVLIB.DLL" Alias "FILARCHIVETIMESET_VB16" (ByVal Path As String, ByVal NewTime As String) As String
Declare Function FilAttributeGet Lib "NOVLIB.DLL" (ByVal Path As String) As Long
Declare Function FilAttributeSet Lib "NOVLIB.DLL" (ByVal Path As String, ByVal NewAttrib As Long) As Long
Declare Function FilCreateDateGet Lib "NOVLIB.DLL" Alias "FILCREATEDATEGET_VB16" (ByVal Path As String) As String
Declare Function FilCreateDateSet Lib "NOVLIB.DLL" Alias "FILCREATEDATESET_VB16" (ByVal Path As String, ByVal NewDate As String) As String
Declare Function FilCreateTimeGet Lib "NOVLIB.DLL" Alias "FILCREATETIMEGET_VB16" (ByVal Path As String) As String
Declare Function FilCreateTimeSet Lib "NOVLIB.DLL" Alias "FILCREATETIMESET_VB16" (ByVal Path As String, ByVal NewTime As String) As String
Declare Function FilIRMaskGet Lib "NOVLIB.DLL" (ByVal Path As String) As Integer
Declare Function FilIRMaskSet Lib "NOVLIB.DLL" (ByVal Path As String, ByVal NewRights As Integer) As Integer
Declare Function FilModifyDateGet Lib "NOVLIB.DLL" Alias "FILMODIFYDATEGET_VB16" (ByVal Path As String) As String
Declare Function FilModifyDateSet Lib "NOVLIB.DLL" Alias "FILMODIFYDATESET_VB16" (ByVal Path As String, ByVal NewDate As String) As String
Declare Function FilModifyIDGet Lib "NOVLIB.DLL" (ByVal Path As String) As Long
Declare Function FilModifyIDSet Lib "NOVLIB.DLL" (ByVal Path As String, ByVal NewID As Long) As Long
Declare Function FilModifyTimeGet Lib "NOVLIB.DLL" Alias "FILMODIFYTIMEGET_VB16" (ByVal Path As String) As String
Declare Function FilModifyTimeSet Lib "NOVLIB.DLL" Alias "FILMODIFYTIMESET_VB16" (ByVal Path As String, ByVal NewTime As String) As String
Declare Function FilNetCopy Lib "NOVLIB.DLL" (ByVal Source As String, ByVal Dest As String, ByVal SourceOffset As Long, ByVal DestOffset As Long, ByVal Length As Long) As Long
Declare Function FilOpenConnList Lib "NOVLIB.DLL" (ByVal Path As String, ByVal Counter As Integer) As Integer
Declare Function FilOpenFileList Lib "NOVLIB.DLL" Alias "FILOPENFILELIST_VB16" (ByVal ConnectionNumber As Integer, ByVal Counter As Integer) As String
Declare Function FilOwnerIDGet Lib "NOVLIB.DLL" (ByVal Path As String) As Long
Declare Function FilOwnerIDSet Lib "NOVLIB.DLL" (ByVal Path As String, ByVal NewID As Long) As Long
Declare Function FilTypeGet Lib "NOVLIB.DLL" (ByVal FileSpec As String) As Integer
Declare Function FSAccountingVersionGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSBufferDirtyGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSBufferCountGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSBufferSizeGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSCacheHitGet Lib "NOVLIB.DLL" () As Long
Declare Function FSCacheMissGet Lib "NOVLIB.DLL" () As Long
Declare Function FSConnIDGet Lib "NOVLIB.DLL" (ByVal FileServer As String) As Integer
Declare Function FSCurrentConnGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSCurrentObjectGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSDateGet Lib "NOVLIB.DLL" Alias "FSDATEGET_VB16" () As String
Declare Function FSDateSet Lib "NOVLIB.DLL" Alias "FSDATESET_VB16" (ByVal NewDate As String) As String
Declare Function FSDirAdd Lib "NOVLIB.DLL" (ByVal FileSpec As String, ByVal Rights As Integer) As Integer
Declare Function FSDirDelete Lib "NOVLIB.DLL" (ByVal FileSpec As String) As Integer
Declare Function FSDiskIOGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSDiskNumberGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSDiskSizeGet Lib "NOVLIB.DLL" (ByVal DriveNumber As Integer) As Long
Declare Function FSDown Lib "NOVLIB.DLL" (ByVal ForceFlag As Integer) As Integer
Declare Function FSDriveGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSFatChgGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSFatFatalErrorGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSFatScanErrorGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSFatWriteErrorGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSFileOpenRequestGet Lib "NOVLIB.DLL" () As Long
Declare Function FSFilePurge Lib "NOVLIB.DLL" (ByVal Path As String, ByVal AllFlag As Integer) As Integer
Declare Function FSFileReadRequestGet Lib "NOVLIB.DLL" () As Long
Declare Function FSFileSalvage Lib "NOVLIB.DLL" (ByVal FileName As String) As Integer
Declare Function FSFileWriteRequestGet Lib "NOVLIB.DLL" () As Long
Declare Function FSGroupAdd Lib "NOVLIB.DLL" (ByVal GroupName As String) As Integer
Declare Function FSLanAddressGet Lib "NOVLIB.DLL" Alias "FSLANADDRESSGET_VB16" (ByVal LanBoard As Integer) As String
Declare Function FSLanConfigGet Lib "NOVLIB.DLL" Alias "FSLANCONFIGGET_VB16" (ByVal LanBoard As Integer) As String
Declare Function FSLanNameGet Lib "NOVLIB.DLL" Alias "FSLANNAMEGET_VB16" (ByVal LanBoard As Integer) As String
Declare Function FSLanNWAddressGet Lib "NOVLIB.DLL" Alias "FSLANNWADDRESSGET_VB16" (ByVal LanBoard As Integer) As String
Declare Function FSLanOptionGet Lib "NOVLIB.DLL" (ByVal LanBoard As Integer) As Integer
Declare Function FSLoginStatusGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSLoginStatusSet Lib "NOVLIB.DLL" (ByVal LoginStatus As Integer) As Integer
Declare Function FSConnMaxGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSMaxFileOpenGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSMaxObjectGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSVolumeMaxGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSMemoryTotalGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSMemoryWastedGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSMessageLog Lib "NOVLIB.DLL" (ByVal Message As String) As Integer
Declare Function FSMessageSend Lib "NOVLIB.DLL" (ByVal Message As String) As Integer
Declare Function FSNameGet Lib "NOVLIB.DLL" Alias "FSNAMEGET_VB16" (ByVal ServerConID As Integer) As String
Declare Function FSObjectAdd Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal ObjectFlags As Integer, ByVal ObjectSecurity As Integer) As Integer
Declare Function FSObjectDelete Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal ObjectType As Integer) As Integer
Declare Function FSObjectList Lib "NOVLIB.DLL" Alias "FSOBJECTLIST_VB16" (ByVal SearchSpecStr As String, ByVal ObjectType As Integer, ByVal StartFlag As Integer) As String
Declare Function FSOpenFileGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSPeakConnGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSPeakFileGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSPeakObjectGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSPreferredConnGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSPreferredConnSet Lib "NOVLIB.DLL" (ByVal ConnectionID As Integer) As Integer
Declare Function FSPreferredNameGet Lib "NOVLIB.DLL" () As String
Declare Function FSPreferredNameSet Lib "NOVLIB.DLL" (ByVal FileServer As String) As String
Declare Function FSPrimaryConnGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSPrimaryConnSet Lib "NOVLIB.DLL" (ByVal ConnectionID As Integer) As Integer
Declare Function FSPrimaryNameGet Lib "NOVLIB.DLL" () As String
Declare Function FSPrimaryNameSet Lib "NOVLIB.DLL" (ByVal FileServer As String) As String
Declare Function FSPrinterFormGet Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer) As Integer
Declare Function FSPrinterNumberGet Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer) As Integer
Declare Function FSPrinterOfflineTest Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer) As Integer
Declare Function FSPrinterStoppedTest Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer) As Integer
Declare Function FSProcessGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSQueueAdd Lib "NOVLIB.DLL" (ByVal Queue As String, ByVal Path As String, ByVal ObjectType As Integer) As Integer
Declare Function FSQueueVersionNumberGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSReadLevelGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSSecurityVersionNumberGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSSFTLevelGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSTimeGet Lib "NOVLIB.DLL" Alias "FSTIMEGET_VB16" () As String
Declare Function FSTimeSet Lib "NOVLIB.DLL" Alias "FSTIMESET_VB16" (ByVal NewTime As String) As String
Declare Function FSTTSLevelGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSUserAdd Lib "NOVLIB.DLL" (ByVal UserName As String, ByVal Password As String) As Integer
Declare Function FSUtilisationGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSWriteLevelGet Lib "NOVLIB.DLL" () As Integer
Declare Function FSWSAttach Lib "NOVLIB.DLL" (ByVal FileServer As String) As Integer
Declare Function FSWSDetach Lib "NOVLIB.DLL" (ByVal FileServer As String) As Integer
Declare Function FSWSLogin Lib "NOVLIB.DLL" (ByVal UserName As String, ByVal Password As String, ByVal ObjectType As Integer) As Integer
Declare Function FSWSLogout Lib "NOVLIB.DLL" (ByVal FileServer As String, ByVal DetachFlag As Integer) As Integer
Declare Function FSWSSyncronize Lib "NOVLIB.DLL" () As Integer
Declare Function GrpUserAdd Lib "NOVLIB.DLL" (ByVal UserName As String, ByVal GroupName As String) As Integer
Declare Function GrpUserDelete Lib "NOVLIB.DLL" (ByVal UserName As String, ByVal GroupName As String) As Integer
Declare Function IPXAddressGet Lib "NOVLIB.DLL" Alias "IPXADDRESSGET_VB16" () As String
Declare Function IPXInstalled Lib "NOVLIB.DLL" () As Integer
Declare Function IPXPacketGet Lib "NOVLIB.DLL" Alias "IPXPACKETGET_VB16" (Length As Integer) As String
Declare Function IPXPacketSend Lib "NOVLIB.DLL" Alias "IPXPACKETSEND_VB16" (ByVal Address As String, Packet As String, ByVal Length As Integer) As Integer
Declare Function IPXSocketNumberGet Lib "NOVLIB.DLL" () As Integer
Declare Sub IPXSocketClose Lib "NOVLIB.DLL" ()
Declare Function IPXSocketOpen Lib "NOVLIB.DLL" (ByVal NewSocket As Integer) As Integer
Declare Function ItmPropertyByteGet Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal PropertyName As String, ByVal Offset As Integer) As Integer
Declare Function ItmPropertyByteSet Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal PropertyName As String, ByVal Offset As Integer, ByVal NewByteStr As String) As Integer
Declare Function ItmPropertyStringGet Lib "NOVLIB.DLL" Alias "ITMPROPERTYSTRINGGET_VB16" (ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal PropertyName As String, ByVal SegmentNumber As Integer) As String
Declare Function ItmPropertyStringSet Lib "NOVLIB.DLL" Alias "ITMPROPERTYSTRINGSET_VB16" (ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal PropertyName As String, ByVal SegmentNumber As Integer, ByVal NewValueStr As String) As String
Declare Function ItmPropertyValueGet Lib "NOVLIB.DLL" Alias "ITMPROPERTYVALUEGET_VB16" (ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal PropertyName As String, ByVal SegmentNumber As Integer) As String
Declare Function ItmPropertyValueSet Lib "NOVLIB.DLL" Alias "ITMPROPERTYVALUESET_VB16" (ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal PropertyName As String, ByVal SegmentNumber As Integer, ByVal NewValueStr As String) As String
Declare Function LokGetWS Lib "NOVLIB.DLL" (ByVal FileName As String, ByVal RecordNumber As Long, ByVal Frmat As Integer) As Integer
Declare Function NfyObjectFirstIntervalGet Lib "NOVLIB.DLL" () As String
Declare Function NfyObjectNextIntervalGet Lib "NOVLIB.DLL" () As Long
Declare Function NfyObjectServerGet Lib "NOVLIB.DLL" Alias "NFYOBJECTSERVERGET_VB16" () As String
Declare Function NfyObjectTypeGet Lib "NOVLIB.DLL" Alias "NFYOBJECTTYPEGET_VB16" () As String
Declare Function NovAttributeString Lib "NOVLIB.DLL" Alias "NOVATTRIBUTESTRING_VB16" (ByVal Rights As Long) As String
Declare Function NovAttributeValue Lib "NOVLIB.DLL" (ByVal Mask As String) As Long
Declare Function NovIntSwap Lib "NOVLIB.DLL" (ByVal Word As Integer) As Integer
Declare Function NovLongSwap Lib "NOVLIB.DLL" (ByVal DWord As Long) As Long
Declare Function NovRightsString Lib "NOVLIB.DLL" Alias "NOVRIGHTSSTRING_VB16" (ByVal Rights As Long) As String
Declare Function NovRightsValue Lib "NOVLIB.DLL" (ByVal Mask As String) As Long
Declare Sub NovTaskEnd Lib "NOVLIB.DLL" ()
Declare Function NovVersionGet Lib "NOVLIB.DLL" Alias "NOVVERSIONGET_VB16" () As String
Declare Function NWErrorGet Lib "NOVLIB.DLL" () As Integer
Declare Function NWGetErrorGet Lib "NOVLIB.DLL" () As Integer
Declare Function NWRevisionNumberGet Lib "NOVLIB.DLL" () As Integer
Declare Function NWSerialNumberGet Lib "NOVLIB.DLL" Alias "NWSERIALNUMBERGET_VB16" () As String
Declare Function NWSetErrorGet Lib "NOVLIB.DLL" () As Integer
Declare Function NWVersionNumberGet Lib "NOVLIB.DLL" Alias "NWVERSIONNUMBERGET_VB16" () As String
Declare Function ObjDirList Lib "NOVLIB.DLL" Alias "OBJDIRLIST_VB16" (ByVal VolumeNumber As Integer, ByVal ObjectID As Long, ByVal StartFlag As Integer) As String
Declare Function ObjFlagGet Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal ObjectType As Integer) As Integer
Declare Function ObjIDGet Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal ObjectType As Integer) As Long
Declare Function ObjNameChange Lib "NOVLIB.DLL" (ByVal OldName As String, ByVal NewName As String, ByVal ObjectType As Integer) As Integer
Declare Function ObjNameGet Lib "NOVLIB.DLL" Alias "OBJNAMEGET_VB16" (ByVal ObjectID As Long) As String
Declare Function ObjPasswordChange Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal NewPassword As String, ByVal OldPassword As String, ByVal ObjectType As Integer) As Integer
Declare Function ObjPasswordCheck Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal Password As String, ByVal ObjectType As Integer) As Integer
Declare Function ObjPropertyAdd Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal PropertyName As String, ByVal PropertyFlags As Integer, ByVal SecurityLevel As Integer) As Integer
Declare Function ObjPropertyDelete Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal PropertyName As String) As Integer
Declare Function ObjPropertyList Lib "NOVLIB.DLL" Alias "OBJPROPERTYLIST_VB16" (ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal PropertyName As String, ByVal StartFlag As Integer) As String
Declare Function ObjPropertyTest Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal ObjectType As Integer) As Integer
Declare Function ObjSecurityGet Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal ObjectType As Integer) As Integer
Declare Function ObjTypeGet Lib "NOVLIB.DLL" (ByVal ObjectID As Long) As Integer
Declare Function PjbActiveTest Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer) As Integer
Declare Function PjbBytesDoneGet Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer) As Long
Declare Function PjbCopyDoneGet Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer) As Integer
Declare Function PjbCopyToDoGet Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer) As Integer
Declare Function PjbDescriptionGet Lib "NOVLIB.DLL" Alias "PJBDESCRIPTIONGET_VB16" (ByVal PrinterNumber As Integer) As String
Declare Function PjbFormNumberGet Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer) As Integer
Declare Function PjbFSGet Lib "NOVLIB.DLL" Alias "PJBFSGET_VB16" (ByVal PrinterNumber As Integer) As String
Declare Function PjbNumberGet Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer) As Integer
Declare Function PjbQueueGet Lib "NOVLIB.DLL" Alias "PJBQUEUEGET_VB16" (ByVal PrinterNumber As Integer) As String
Declare Function PjbRewind Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer, ByVal PageFlag As Integer, ByVal AbsoluteFlag As Integer, ByVal Copies As Integer, ByVal Amount As Long) As Integer
Declare Function PjbSizeGet Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer) As Long
Declare Function PjbTextTest Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer) As Integer
Declare Function PrnEject Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer) As Integer
Declare Function PrnErrorStatusGet Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer) As Integer
Declare Function PrnFormNameGet Lib "NOVLIB.DLL" Alias "PRNFORMNAMEGET_VB16" (ByVal PrinterNumber As Integer) As String
Declare Function PrnFormNumberGet Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer) As Integer
Declare Function PrnFormNumberSet Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer, ByVal FormNumber As Integer) As Integer
Declare Function PrnFormTopMark Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer, ByVal MarkerChar As String) As Integer
Declare Function PrnJobAbort Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer, ByVal Outcome As Integer) As Integer
Declare Function PrnNameGet Lib "NOVLIB.DLL" Alias "PRNNAMEGET_VB16" (ByVal PrinterNumber As Integer) As String
Declare Function PrnNotifyObjectAdd Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer, ByVal FileServer As String, ByVal ObjectName As String, ByVal First As Integer, ByVal Nxt As Integer, ByVal ObjectType As Integer) As Integer
Declare Function PrnNotifyObjectDelete Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer, ByVal FileServer As String, ByVal ObjectName As String, ByVal ObjectType As Integer) As Integer
Declare Function PrnNotifyObjectList Lib "NOVLIB.DLL" Alias "PRNNOTIFYOBJECTLIST_VB16" (ByVal PrinterNumber As Integer, ByVal StartFlag As Integer) As String
Declare Function PrnNotifyPeriodChange Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer, ByVal FileServer As String, ByVal ObjectName As String, ByVal First As Integer, ByVal Nxt As Integer, ByVal ObjectType As Integer) As Integer
Declare Function PrnQueueAdd Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer, ByVal FileServer As String, ByVal QueueName As String, ByVal Priority As Integer) As Integer
Declare Function PrnQueueDelete Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer, ByVal FileServer As String, ByVal QueueName As String, ByVal Force As Integer, ByVal Outcome As Integer) As Integer
Declare Function PrnQueueFSGet Lib "NOVLIB.DLL" Alias "PRNQUEUEFSGET_VB16" () As String
Declare Function PrnQueueList Lib "NOVLIB.DLL" Alias "PRNQUEUELIST_VB16" (ByVal PrinterNumber As Integer, ByVal StartFlag As Integer) As String
Declare Function PrnQueueModeGet Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer, ByVal NewMode As Integer) As Integer
Declare Function PrnQueuePriorityChange Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer, ByVal FileServer As String, ByVal QueueName As String, ByVal Priority As Integer) As Integer
Declare Function PrnQueuePriorityGet Lib "NOVLIB.DLL" () As Integer
Declare Function PrnStart Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer) As Integer
Declare Function PrnStatusGet Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer) As Integer
Declare Function PrnStop Lib "NOVLIB.DLL" (ByVal PrinterNumber As Integer, ByVal Outcome As Integer) As Integer
Declare Function PrpFlagGet Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal PropertyName As String) As Integer
Declare Function PrpSecurityGet Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal PropertyName As String) As Integer
Declare Function PrpValueTest Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal PropertyName As String) As Integer
Declare Function PSConnNumberGet Lib "NOVLIB.DLL" () As Integer
Declare Function PSDown Lib "NOVLIB.DLL" (ByVal Force As Integer, ByVal Outcome As Integer) As Integer
Declare Function PSFSList Lib "NOVLIB.DLL" Alias "PSFSLIST_VB16" (ByVal StartFlag As Integer) As String
Declare Function PSSocketNumberGet Lib "NOVLIB.DLL" () As Integer
Declare Function PSVersionNumberGet Lib "NOVLIB.DLL" () As Integer
Declare Function PSWSAttach Lib "NOVLIB.DLL" (ByVal PrintServer As String) As Long
Declare Function PSWSDetach Lib "NOVLIB.DLL" (ByVal ConnectionNumber As Long) As Integer
Declare Function PSWSLogin Lib "NOVLIB.DLL" (ByVal PrintServer As String) As Integer
Declare Function PSWSLogout Lib "NOVLIB.DLL" () As Integer
Declare Function QjbAddingTest Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal JobNumber As Integer) As Integer
Declare Function QJbBannerGet Lib "NOVLIB.DLL" Alias "QJBBANNETGET_VB16" (ByVal QueueID As Long, ByVal JobNumber As Integer) As String
Declare Function QJbBannerSet Lib "NOVLIB.DLL" Alias "QJBBANNERSET_VB16" (ByVal QueueID As Long, ByVal JobNumber As Integer, ByVal NewBannerStr As String) As String
Declare Function QJbCopiesGet Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal JobNumber As Integer) As Integer
Declare Function QJbCopiesSet Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal JobNumber As Integer, ByVal NewCopies As Integer) As Integer
Declare Function QJbDateGet Lib "NOVLIB.DLL" Alias "QJBDATEGET_VB16" (ByVal QueueID As Long, ByVal JobNumber As Integer) As String
Declare Function QJbDeferDateGet Lib "NOVLIB.DLL" Alias "QJBDEFERDATEGET_VB16" (ByVal QueueID As Long, ByVal JobNumber As Integer) As String
Declare Function QJbDeferDateSet Lib "NOVLIB.DLL" Alias "QJBDEFERDATESET_VB16" (ByVal QueueID As Long, ByVal JobNumber As Integer, ByVal NewDateStr As String) As String
Declare Function QJbDeferTimeGet Lib "NOVLIB.DLL" Alias "QJBDEFERTIMEGET_VB16" (ByVal QueueID As Long, ByVal JobNumber As Integer) As String
Declare Function QJbDeferTimeSet Lib "NOVLIB.DLL" Alias "QJBDEFERTIMESET_VB16" (ByVal QueueID As Long, ByVal JobNumber As Integer, ByVal NewTimeStr As String) As String
Declare Function QJBDescriptionGet Lib "NOVLIB.DLL" Alias "QJBDESCRIPTIONGET_VB16" (ByVal QueueID As Long, ByVal JobNumber As Integer) As String
Declare Function QJbDescriptionSet Lib "NOVLIB.DLL" Alias "QJBDESCRIPTIONSET_VB16" (ByVal QueueID As Long, ByVal JobNumber As Integer, ByVal NewDescStr As String) As String
Declare Function QJbFileNameGet Lib "NOVLIB.DLL" Alias "QJBFILENAMEGET_VB16" (ByVal QueueID As Long, ByVal JobNumber As Integer) As String
Declare Function QJbFlagGet Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal JobNumber As Integer) As Integer
Declare Function QJbFlagSet Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal JobNumber As Integer, ByVal NewFlag As Integer) As Integer
Declare Function QJbOperatorHoldGet Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal JobNumber As Integer) As Integer
Declare Function QJbOperatorHoldSet Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal JobNumber As Integer, ByVal Hold As Integer) As Integer
Declare Function QJBPositionGet Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal JobNumber As Integer) As Integer
Declare Function QJbPositionSet Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal JobNumber As Integer, ByVal NewPosition As Integer) As Integer
Declare Function QJbRestartGet Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal JobNumber As Integer) As Integer
Declare Function QJbRestartSet Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal JobNumber As Integer, ByVal NewFlag As Integer) As Integer
Declare Function QJbSizeGet Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal JobNumber As Integer) As Long
Declare Function QJbTimeGet Lib "NOVLIB.DLL" Alias "QJBTIMEGET_VB16" (ByVal QueueID As Long, ByVal JobNumber As Integer) As String
Declare Function QJbUserHoldGet Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal JobNumber As Integer) As Integer
Declare Function QJbUserHoldSet Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal JobNumber As Integer, ByVal Hold As Integer) As Integer
Declare Function QJBUserIDGet Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal JobNumber As Integer) As Long
Declare Function QJbWSGet Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal JobNumber As Integer) As Integer
Declare Function QueAddStateGet Lib "NOVLIB.DLL" (ByVal QueueID As Long) As Integer
Declare Function QueAddStateSet Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal Add As Integer) As Integer
Declare Function QueFileAdd Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal Path As String, ByVal Control As Integer, ByVal Description As String, ByVal Copies As Integer, ByVal Flags As Integer, ByVal ServerID As Long) As Integer
Declare Function QueHaltGet Lib "NOVLIB.DLL" (ByVal QueueID As Long) As Integer
Declare Function QueHaltSet Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal Halt As Integer) As Integer
Declare Function QueQJbDelete Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal JobNumber As Integer) As Integer
Declare Function QueQJbList Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal StartFlag As Integer) As Integer
Declare Function QueServiceStateGet Lib "NOVLIB.DLL" (ByVal QueueID As Long) As Integer
Declare Function QueServiceStateSet Lib "NOVLIB.DLL" (ByVal QueueID As Long, ByVal Service As Integer) As Integer
Declare Function SchDriveDirMap Lib "NOVLIB.DLL" (ByVal Drive As String, ByVal Path As String, Order As Integer) As Integer
Declare Function SchDriveMapDelete Lib "NOVLIB.DLL" (ByVal Order As Integer) As Integer
Declare Function SchOrderDriveGet Lib "NOVLIB.DLL" Alias "SCHORDERDRIVEGET_VB16" (ByVal Order As Integer) As String
Declare Function SchVectorDriveAdd Lib "NOVLIB.DLL" (ByVal Drive As String, ByVal Order As Integer) As Integer
Declare Function SchVectorDriveDelete Lib "NOVLIB.DLL" (ByVal Order As Integer) As Integer
Declare Function SchVectorPathSet Lib "NOVLIB.DLL" () As Integer
Declare Function SchVectorGet Lib "NOVLIB.DLL" Alias "SCHVECTORGET_VB16" () As String
Declare Function SchVectorSet Lib "NOVLIB.DLL" Alias "SCHVECTORSET_VB16" (ByVal NewVector As String) As String
Declare Function SemClose Lib "NOVLIB.DLL" (ByVal SemID As Long) As Integer
Declare Function SemOpen Lib "NOVLIB.DLL" (ByVal SemName As String, ByVal SemValue As Integer) As Long
Declare Function SemUserGet Lib "NOVLIB.DLL" (ByVal SemID As Long) As Integer
Declare Function SemValueDecrement Lib "NOVLIB.DLL" (ByVal SemID As Long, ByVal Timeout As Integer) As Integer
Declare Function SemValueGet Lib "NOVLIB.DLL" (ByVal SemID As Long) As Integer
Declare Function SemValueIncrement Lib "NOVLIB.DLL" (ByVal SemID As Long) As Integer
Declare Function SemWSList Lib "NOVLIB.DLL" (ByVal SemName As String) As Integer
Declare Function SetPropertyIDAdd Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal Property As String) As Integer
Declare Function SetPropertyIDDelete Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal Property As String) As Integer
Declare Function SetPropertyIDTest Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal Property As String) As Integer
Declare Function SetPropertyValueGet Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal PropertyName As String, ByVal Offset As Integer) As Long
Declare Function SetPropertyValueSet Lib "NOVLIB.DLL" (ByVal ObjectName As String, ByVal ObjectType As Integer, ByVal PropertyName As String, ByVal Offset As Integer, ByVal NewValueLong As Long) As Long
Declare Function SPXAddressGet Lib "NOVLIB.DLL" Alias "SPXADDRESSGET_VB16" (ByVal ConnectionNumber As Integer) As String
Declare Function SPXConnect Lib "NOVLIB.DLL" (ByVal Address As String, ByVal SocketNumber As Integer, ByVal Tme As Integer) As Long
Declare Function SPXConnFreeGet Lib "NOVLIB.DLL" () As Integer
Declare Function SPXConnGet Lib "NOVLIB.DLL" (ByVal ConnectionNumber As Integer) As Integer
Declare Function SPXDisconnect Lib "NOVLIB.DLL" (ByVal ConnectionNumber As Integer) As Integer
Declare Function SPXInstalled Lib "NOVLIB.DLL" () As Integer
Declare Function SPXMaxConnGet Lib "NOVLIB.DLL" () As Integer
Declare Function SPXPacketGet Lib "NOVLIB.DLL" Alias "SPXPACKETGET_VB16" (ByVal ConnectionNumber As Integer, Length As Integer) As String
Declare Function SPXPacketSend Lib "NOVLIB.DLL" Alias "SPXPACKETSEND_VB16" (ByVal ConnectionNumber As Integer, Packet As String, ByVal Length As Integer) As Integer
Declare Function SPXSocketNumberGet Lib "NOVLIB.DLL" () As Long
Declare Function SPXVersionNumberGet Lib "NOVLIB.DLL" Alias "SPXVERSIONNUMBERGET_VB16" () As String
Declare Function TTSAbort Lib "NOVLIB.DLL" () As Integer
Declare Function TTSAppThresholdGet Lib "NOVLIB.DLL" () As Integer
Declare Function TTSAppThresholdSet Lib "NOVLIB.DLL" (ByVal FileLocks As Integer) As Integer
Declare Function TTSBegin Lib "NOVLIB.DLL" () As Integer
Declare Function TTSActiveGet Lib "NOVLIB.DLL" () As Integer
Declare Function TTSActiveSet Lib "NOVLIB.DLL" (ByVal EnableFlag As Integer) As Integer
Declare Function TTSEnd Lib "NOVLIB.DLL" (TransactionID As Long) As Integer
Declare Function TTSFSTransactionGet Lib "NOVLIB.DLL" () As Integer
Declare Function TTSMaxTransactionGet Lib "NOVLIB.DLL" () As Integer
Declare Function TTSPeakTransactionGet Lib "NOVLIB.DLL" () As Integer
Declare Function TTSVolumeNumberGet Lib "NOVLIB.DLL" () As Integer
Declare Function TTSVolumeFreeGet Lib "NOVLIB.DLL" () As Integer
Declare Function TTSStatus Lib "NOVLIB.DLL" (ByVal TransactionID As Long) As Integer
Declare Function TTSInstalled Lib "NOVLIB.DLL" () As Integer
Declare Function TTSWSThresholdGet Lib "NOVLIB.DLL" () As Integer
Declare Function TTSWSThresholdSet Lib "NOVLIB.DLL" (ByVal FileLocks As Integer) As Integer
Declare Function UsrAccountChargeAdd Lib "NOVLIB.DLL" (ByVal UserName As String, ByVal Service As Integer, ByVal Amount As Long, ByVal CommentType%, ByVal Comment As String) As Integer
Declare Function UsrAccountChargeDelete Lib "NOVLIB.DLL" (ByVal UserName As String, ByVal Service As Integer, ByVal Amount As Long, ByVal CommentType As Integer, ByVal Comment As String) As Integer
Declare Function UsrAccountReserveGet Lib "NOVLIB.DLL" (ByVal UserName As String, ByVal Server As String) As Long
Declare Function UsrAccountReserveSet Lib "NOVLIB.DLL" (ByVal UserName As String, ByVal Amount As Long) As Integer
Declare Function UsrConnList Lib "NOVLIB.DLL" (ByVal UserName As String) As Integer
Declare Function UsrCurConsoleOperatorTest Lib "NOVLIB.DLL" () As Integer
Declare Function UsrDirCountGet Lib "NOVLIB.DLL" (ByVal VolumeNumber As Integer, ByVal UserID As Long) As Long
Declare Function UsrDiskBlockGet Lib "NOVLIB.DLL" (ByVal VolumeNumber As Integer, ByVal UserID As Long) As Long
Declare Function UsrDiskFreeGet Lib "NOVLIB.DLL" (ByVal UserID As Long) As Long
Declare Function UsrFileCountGet Lib "NOVLIB.DLL" (ByVal VolumeNumber As Integer, ByVal UserID As Long) As Long
Declare Function UsrFullNameGet Lib "NOVLIB.DLL" Alias "USRFULLNAMEGET_VB16" (ByVal UserName As String) As String
Declare Function UsrFullNameSet Lib "NOVLIB.DLL" Alias "USRFULLNAMESET_VB16" (ByVal UserName As String, ByVal NewFullNameStr As String) As String
Declare Function UsrVolumeFreeGet Lib "NOVLIB.DLL" (ByVal VolumeNumber As Integer, ByVal UserID As Long) As Long
Declare Function UsrVolumeRestrictGet Lib "NOVLIB.DLL" (ByVal VolumeNumber As Integer, ByVal UserID As Long) As Long
Declare Function UsrVolumeRestrictSet Lib "NOVLIB.DLL" (ByVal VolumeNumber As Integer, ByVal UserID As Long, ByVal Size As Long) As Long
Declare Function VolBlockFreeGet Lib "NOVLIB.DLL" (ByVal VolumeNumber As Integer) As Long
Declare Function VolBlockMaxGet Lib "NOVLIB.DLL" (ByVal VolumeNumber As Integer) As Long
Declare Function VolBlockNotPurgeGet Lib "NOVLIB.DLL" (ByVal VolumeNumber As Integer) As Long
Declare Function VolBlockPurgeGet Lib "NOVLIB.DLL" (ByVal VolumeNumber As Integer) As Long
Declare Function VolBlockSizeGet Lib "NOVLIB.DLL" (ByVal VolumeNumber As Integer) As Integer
Declare Function VolDirFreeGet Lib "NOVLIB.DLL" (ByVal VolumeNumber As Integer) As Long
Declare Function VolDirMaxGet Lib "NOVLIB.DLL" (ByVal VolumeNumber As Integer) As Long
Declare Function VolNameGet Lib "NOVLIB.DLL" Alias "VOLNAMEGET_VB16" (ByVal VolumeNumber As Integer) As String
Declare Function VolNumberGet Lib "NOVLIB.DLL" (ByVal VolumeName As String) As Integer
Declare Function VolRemovableTest Lib "NOVLIB.DLL" (ByVal VolumeNumber As Integer) As Integer
Declare Function WSConnClear Lib "NOVLIB.DLL" (ByVal StationNumber As Integer) As Integer
Declare Function WSConnNumberGet Lib "NOVLIB.DLL" () As Integer
Declare Function WSDriveLocalGet Lib "NOVLIB.DLL" () As Integer
Declare Function WSDriveNetGet Lib "NOVLIB.DLL" Alias "WSDRIVENETGET_VB16" () As String
Declare Function WSEnvFreeGet Lib "NOVLIB.DLL" () As Integer
Declare Function WSEnvSizeGet Lib "NOVLIB.DLL" () As Integer
Declare Function WSEnvVariableGet Lib "NOVLIB.DLL" Alias "WSENVVARIABLEGET_VB16" (ByVal VarName As String) As String
Declare Function WSEnvVariableSet Lib "NOVLIB.DLL" Alias "WSENVVARIABLESET_VB16" (ByVal VarName As String, ByVal NewValue As String) As String
Declare Function WSLoginDateGet Lib "NOVLIB.DLL" Alias "WSLOGINDATEGET_VB16" (ByVal StationNumber As Integer) As String
Declare Function WSLoginIDGet Lib "NOVLIB.DLL" (ByVal StationNumber As Integer) As Long
Declare Function WSLoginNameGet Lib "NOVLIB.DLL" Alias "WSLOGINNAMEGET_VB16" (ByVal StationNumber As Integer) As String
Declare Function WSLoginTimeGet Lib "NOVLIB.DLL" Alias "WSLOGINTIMEGET_VB16" (ByVal StationNumber As Integer) As String
Declare Function WSLoginTypeGet Lib "NOVLIB.DLL" (ByVal StationNumber As Integer) As Integer
Declare Function WSLongNameGet Lib "NOVLIB.DLL" Alias "WSLONGNAMEGET_VB16" () As String
Declare Function WSMessageGet Lib "NOVLIB.DLL" Alias "WSMESSAGEGET_VB16" () As String
Declare Function WSMessageModeGet Lib "NOVLIB.DLL" () As Integer
Declare Function WSMessageModeSet Lib "NOVLIB.DLL" (ByVal NewMode As Integer) As Integer
Declare Function WSMessageSend Lib "NOVLIB.DLL" (ByVal StationNumber As Integer, ByVal Message As String) As Integer
Declare Function WSNetAddressGet Lib "NOVLIB.DLL" Alias "WSNETADDRESSGET_VB16" (ByVal ConnectionNumber As Integer) As String
Declare Function WSNodeAddressGet Lib "NOVLIB.DLL" Alias "WSNODEADDRESSGET_VB16" (ByVal ConnectionNumber As Integer) As String
Declare Function WSOSNameGet Lib "NOVLIB.DLL" Alias "WSOSNAMEGET_VB16" () As String
Declare Function WSOSVersionGet Lib "NOVLIB.DLL" Alias "WSOSVERSIONGET_VB16" () As String
Declare Function WSSemaphoreList Lib "NOVLIB.DLL" Alias "WSSEMAPHORELIST_VB16" (ByVal ConnectionNumber As Integer) As String
Declare Function WSSemaphoreTaskList Lib "NOVLIB.DLL" (ByVal ConnectionNumber As Integer, ByVal StartFlag As Integer) As Integer
Declare Function WSSemaphoreTotalGet Lib "NOVLIB.DLL" (ByVal ConnectionNumber As Integer) As Integer
Declare Function WSShellVersionGet Lib "NOVLIB.DLL" Alias "WSSHELLVERSIONGET_VB16" () As String
Declare Function WSShortNameGet Lib "NOVLIB.DLL" Alias "WSSHORTNAMEGET_VB16" () As String

Function DirGroupAdd (GroupID As Long, Path As String, Rights As Integer) As Integer
    DirGroupAdd = DirObjectAdd(GroupID, Path, Rights)
End Function

Function DirGroupDelete (GroupID As Long, Path As String) As Integer
    DirGroupDelete = DirObjectDelete(GroupID, Path)
End Function

Function DirUserAdd (UserID As Long, Path As String, Rights As Integer) As Integer
    DirUserAdd = DirObjectAdd(UserID, Path, Rights)
End Function

Function DirUserDelete (UserID As Long, Path As String) As Integer
    DirUserDelete = DirObjectDelete(UserID, Path)
End Function

Function FSAccountEnabledTest () As Integer
    FSAccountEnabledTest = (FSAccountingVersionGet() = 1)
End Function

Function FSAccountServerAdd (Server As String, ObjectType As Integer) As Integer
    FSAccountServerAdd = SetPropertyIDAdd(FSNameGet(NOVDEFINT%), OT_FILE_SERVER%, Server, ObjectType, "ACCOUNT_SERVERS")
End Function

Function FSAccountServerDelete (Server As String, ObjectType As Integer) As Integer
    FSAccountServerDelete = SetPropertyIDDelete(FSNameGet(NOVDEFINT%), OT_FILE_SERVER%, Server, ObjectType, "ACCOUNT_SERVERS")
End Function

Function FSBinderyClose () As Integer
    FSBinderyClose = Bindery(1)
End Function

Function FSBinderyOpen () As Integer
    FSBinderyOpen = Bindery(0)
End Function

Function FSConsoleOperatorTest (ServerName As String, Offset As Integer) As String
    FSConsoleOperatorTest = ObjNameGet(SetPropertyValueGet(ServerName, OT_FILE_SERVER%, "OPERATORS", Offset))
End Function

Function FSGroupDelete (GroupName As String)
    FSGroupDelete = FSObjectDelete(GroupName, OT_USER_GROUP%)
End Function

Function FSGroupMgrList (Offset As Integer) As String
    FSGroupMgrList = ObjNameGet(SetPropertyValueGet("SUPERVISOR", OT_USER%, "MANAGERS", Offset))
End Function

Function FSIDGet (ServerName As String) As Integer
    FSIDGet = ObjIDGet(ServerName, OT_FILE_SERVER%)
End Function

Function FSQueueDelete (QueueName As String) As Integer
    FSQueueDelete = FSObjectDelete(QueueName, OT_PRINT_QUEUE%)
End Function

Function FSQueueRename (OldName As String, NewName As String) As Integer
    FSQueueRename = ObjNameChange(OldName, NewName, OT_PRINT_QUEUE%)
End Function

Function FSUserDelete (UserName As String) As Integer
    FSUserDelete = FSObjectDelete(UserName, OT_USER%)
End Function

Function GrpIDGet (GroupName As String) As Long
    GrpIDGet = ObjIDGet(GroupName, OT_USER_GROUP%)
End Function

Function GrpNameChange (OldName As String, NewName As String) As Integer
       GrpNameChange = ObjNameChange(OldName, NewName, OT_USER_GROUP%)
End Function

Function GrpNameGet (GroupID As Long) As String
    GrpNameGet = ObjNameGet(GroupID)
End Function

Function GrpUserList (GroupName As String, Offset As Integer) As String
    GrpUserList = ObjNameGet(SetPropertyValueGet(GroupName, OT_USER_GROUP%, "GROUP_MEMBERS", Offset))
End Function

Function GrpUserTest (UserName As String, GroupName As String) As Integer
    GrpUserTest = SetPropertyIDTest(GroupName, OT_USER_GROUP%, UserName, OT_USER%, "GROUP_MEMBERS")
End Function

Function PSOperatorAdd (UserName As String, PrintServer As String) As Integer
    PSOperatorAdd = SetPropertyIDAdd(PrintServer, OT_PRINT_SERVER%, UserName, OT_USER%, "PS_OPERATORS")
End Function

Function PSOperatorDelete (UserName As String, PrintServer As String) As Integer
    PSOperatorDelete = SetPropertyIDDelete(PrintServer, OT_PRINT_SERVER%, UserName, OT_USER%, "PS_OPERATORS")
End Function

Function PSOperatorList (PrintServer As String, Offset As Integer) As String
       PSOperatorList = ObjNameGet(SetPropertyValueGet(PrintServer, OT_PRINT_SERVER%, "PS_OPERATORS", Offset))
End Function

Function PSUserAdd (UserName As String, PrintServer As String) As Integer
    PSUserAdd = SetPropertyIDAdd(PrintServer, OT_PRINT_SERVER%, UserName, OT_USER%, "PS_USERS")
End Function

Function PSUserDelete (UserName As String, PrintServer As String) As Integer
    PSUserDelete = SetPropertyIDDelete(PrintServer, OT_PRINT_SERVER%, UserName, OT_USER%, "PS_USERS")
End Function

Function PSUserList (PrintServer As String, Offset As Integer) As String
       PSUserList = ObjNameGet(SetPropertyValueGet(PrintServer, OT_PRINT_SERVER%, "PS_USERS", Offset))
End Function

Function QueGroupAdd (GroupName As String, QueueName As String) As Integer
    QueGroupAdd = SetPropertyIDAdd(QueueName, OT_PRINT_QUEUE%, GroupName, OT_USER_GROUP%, "Q_USERS")
End Function

Function QueGroupDelete (GroupName As String, QueueName As String) As Integer
    QueGroupDelete = SetPropertyIDDelete(QueueName, OT_PRINT_QUEUE%, GroupName, OT_USER_GROUP%, "Q_USERS")
End Function

Function QUEIDGet (QueueName As String) As Long
    QUEIDGet = ObjIDGet(QueueName, OT_PRINT_QUEUE%)
End Function

Function QueNameGet (QueueID As Long) As String
    QueNameGet = ObjNameGet(QueueID)
End Function

Function QueOperatorAdd (UserName As String, QueueName As String) As Integer
    QueAddOpr = SetPropertyIDAdd(QueueName, OT_PRINT_QUEUE%, UserName, OT_USER%, "Q_OPERATORS")
End Function

Function QueOperatorDelete (UserName As String, QueueName As String) As Integer
    QueOperatorDelete = SetPropertyIDDelete(QueueName, OT_PRINT_QUEUE%, UserName, OT_USER%, "Q_OPERATORS")
End Function

Function QueOperatorList (QueueName As String, Offset As Integer) As String
    QueListOpr = ObjNameGet(SetPropertyValueGet(QueueName, OT_PRINT_QUEUE%, "Q_OPERATORS", Offset))
End Function

Function QueOperatorTest (UserName As String, QueueName As String) As Integer
    QueOperatorTest = SetPropertyIDTest(QueueName, OT_PRINT_QUEUE%, UserName, OT_USER%, "Q_OPERATORS")
End Function

Function QueUserAdd (UserName As String, QueueName As String) As Integer
    QueUserAdd = SetPropertyIDAdd(QueueName, OT_PRINT_QUEUE%, UserName, OT_USER%, "Q_USERS")
End Function

Function QueUserDelete (UserName As String, QueueName As String) As Integer
    QueUserDelete = SetPropertyIDDelete(QueueName, OT_PRINT_QUEUE%, UserName, OT_USER%, "Q_USERS")
End Function

Function QueUserList (QueueName As String, Offset As Integer) As String
    QueUserList = ObjNameGet(SetPropertyValueGet(QueueName, OT_PRINT_QUEUE%, "Q_USERS", Offset))
End Function

Function QueUserTest (UserName As String, QueueName As String) As Integer
    QueUserTest = SetPropertyIDTest(QueueName, OT_PRINT_QUEUE%, UserName, OT_USER%, "Q_USERS")
End Function

Function UsrAccountBalanceGet (UserName As String) As Long
    UsrAccountBalanceGet = SetPropertyValueGet(UserName, OT_USER%, "ACCOUNT_BALANCE", 1)
End Function

Function UsrAccountBalanceSet (UserName As String, Balance As Long) As Long
    UsrAccountBalanceSet = SetPropertyValueSet(UserName, OT_USER%, "ACCOUNT_BALANCE", 1, Balance)
End Function

Function UsrAccountLimitGet (UserName As String) As Long
    UsrAccountLimitGet = SetPropertyValueGet(UserName, OT_USER%, "ACCOUNT_BALANCE", 2)
End Function

Function UsrAccountLimitSet (UserName As String, CreditLimit As Long) As Long
    UsrAccountLimitSet = SetPropertyValueSet(UserName, OT_USER%, "ACCOUNT_BALANCE", 2, CreditLimit)
End Function

Function UsrConsoleOperatorDelete (UserName As String) As Integer
    UsrConsoleOperatorDelete = SetPropertyIDDelete(FSNameGet(NOVDEFINT%), OT_FILE_SERVER%, UserName, OT_USER%, "OPERATORS")
End Function

Function UsrConsoleOperatorSet (UserName As String) As Integer
    UsrConsoleOperatorSet = SetPropertyIDAdd(FSNameGet(NOVDEFINT%), OT_FILE_SERVER%, UserName, OT_USER%, "OPERATORS")
End Function

Function UsrConsoleOperatorTest (UserName As String) As Integer
    UsrConsoleOperatorTest = SetPropertyIDTest(FSNameGet(NOVDEFINT%), OT_FILE_SERVER%, UserName, OT_USER%, "OPERATORS")
End Function

Function UsrGroupList (UserName As String, Offset As Integer) As String
    UsrGroupList = ObjNameGet(SetPropertyValueGet(UserName, OT_USER%, "GROUPS_I'M_IN", Offset))
End Function

Function UsrGroupManagerSet (UserName As String) As Integer
    UsrGroupManagerSet = SetPropertyIDAdd("SUPERVISOR", OT_USER%, UserName, OT_USER%, "MANAGERS")
End Function

Function UsrGroupMgrDelete (UserName As String) As Integer
    UsrGroupMgrDelete = SetPropertyIDDelete("SUPERVISOR", OT_USER%, UserName, OT_USER%, "MANAGERS")
End Function

Function UsrGroupMgrTest (UserName As String) As Integer
    UsrGroupManagerTest = SetPropertyIDTest("SUPERVISOR", OT_USER%, UserName, OT_USER%, "MANAGERS")
End Function

Function UsrIDGet (UserName As String) As Long
    UsrIDGet = ObjIDGet(UserName, OT_USER%)
End Function

Function UsrNameChange (CurrentName As String, NewName As String) As Integer
    UsrNameChange = ObjNameChange(CurrentName, NewName, OT_USER%)
End Function

Function UsrNameGet (UserID As Long) As String
    UsrNameGet = ObjNameGet(UserID)
End Function

Function UsrPasswordChange (UserName As String, NewPassword As String, OldPassword As String) As Integer
    UsrPasswordChange = ObjPasswordChange(UserName, NewPassword, OldPassword, OT_USER%)
End Function

Function UsrPasswordCheck (UserName As String, Password As String) As Integer
    UsrPasswordCheck = ObjPasswordCheck(UserName, Password, OT_USER%)
End Function

Function UsrSupervisorDelete (UserName As String) As Integer
    UsrSupervisorDelete = SetPropertyIDDelete(UserName, OT_USER%, "SUPERVISOR", OT_USER%, "SECURITY_EQUALS")
End Function

Function UsrSupervisorSet (UserName As String) As Integer
    UsrSupervisorSet = SetPropertyIDAdd(UserName, OT_USER%, "SUPERVISOR", OT_USER%, "SECURITY_EQUALS")
End Function

Function UsrSupervisorTest (UserName As String) As Integer
    UsrSupervisorTest = SetPropertyIDTest(UserName, OT_USER%, "SUPERVISOR", OT_USER%, "SECURITY_EQUALS")
End Function

