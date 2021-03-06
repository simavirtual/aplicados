//	BLIC4W4.PRG - Blinker 4 DLL Stubs (Part 4)
//
//	Written by:	John M. Skelton,  1-Mar-96.
//
//	Copyright (C) 1996 Skelton Software, Kendal Cottage, Hillam, Leeds LS25 5HP, UK.
//	All Rights Reserved.
//
//	Part of Clip-4-Win.
//
//	This is split into several files because of a Clipper limit on the
//	number of procedures in a single file.


#xcommand MODULE <name>	=>

#xcommand EXE <name> <*more*>						;
       => EXE <name> ; EXE <more>

#xcommand EXE <name>							;
       => PROCEDURE <name>						;
        ; missing()							;
        ; RETURN


static procedure missing()
MessageBox( , "You need to link " + PROCNAME(1), "Function not in EXE")
return


MODULE getsys
  EXE	DGETMODELE	DRANGECHEC	DREADCANCE	DREADMODEL
  EXE	DREADSETFO	DREADSETIN	GETACTIVE	GETAPPLYKE
  EXE	GETDOSETKE	GETMODELES	GETPOSTVAL	GETPREVALI
  EXE	GETREADER	ISDREADOK	POSINGETLI	RANGECHECK
  EXE	READEXIT	READFORMAT	READINSERT	READKILL
  EXE	READMODAL	READMODELE	READUPDATE	UPDATED
  EXE	__KILLREAD	__SETFORMA

MODULE ntxpos
  EXE	NTXPOS

MODULE ntxrec
  EXE	NTXREC

MODULE achoice
  EXE	ACHOICE

MODULE memoedit
  EXE	MEMOEDIT

MODULE toolb
  EXE	TOOLBAR

MODULE appmain
  EXE	BWCC		C4W_APPINI	C4W_APPMAI	C4W_HNDLMS
  EXE	CTL3D

MODULE menuf2
  EXE	_MENU_APPE	_MENU_BEGI	_MENU_END	_POPUP_BEG
  EXE	_POPUP_END

MODULE dialogf2
  EXE	_ADD_DIALO	_CREATE_DI	_SHOW_DIAL

MODULE bin2ptr
  EXE	BIN2PTR		FREEPTR		STR2PTR

MODULE wbrowdef
  EXE	WBROWSEDEF	WBWINDOW

MODULE dbg
  EXE	DBGPADMSG	DBGSHOW		DBGTRACE

MODULE bwcc
  EXE	BWCCDEFDLG	BWCCDEFMDI	BWCCDEFWIN	BWCCGETPAT
  EXE	BWCCGETVER	BWCCMESSAG

MODULE c4w53p
  EXE	_C4W_530

MODULE wbcolt
  EXE	WBCOLUMN

MODULE wbc
  EXE	WB_CSETFLD	WB_CWINBOX	WB_DRAWFIE	WB_GETDBLC
  EXE	WB_HIGHLIT	WB_INVERTR	WB_MAXLINE	WB_MCAPTUR
  EXE	WB_MRELEAS	WB_NBRLINE	WB_NEXTCOL	WB_NOPAINT
  EXE	WB_PEEKMSG	WB_PREVCOL	WB_SHOWBIT	WB_SHOWDAT

MODULE wbrowset
  EXE	WBROWSE

MODULE decl
  EXE	TC_ALLMESS	TC_CLASSNA	TC_CLASSTR	TC_CLSCBNA
  EXE	TC_ISIVAR	TC_ISKINDO	TC_ISMETHO	TC_IVARS
  EXE	TC_IVARTYP	TC_MESSAGE	TC_METHODN	TC_METHODT
  EXE	TC_MIINFO	TC_MSGNAME	TC_OCLONE	TC_SUBCLAS
  EXE	TC_SUBTREE	TC_SUPERCB	TC_SUPERCL	TC_SUPERNA
  EXE	TC_SUPERNU	TC_SUPERTR	_TC_AR__	_TC_DFRMSG
  EXE	_TC_DONE	_TC_DOOBJE	_TC_IVNAME	_TC_IVTYPE
  EXE	_TC_METHOD	_TC_MSGTYP	_TC_SELFO	_TC_SUPERA
  EXE	_TC_SUPERC	_TC_SUPERM	_TC_SUPERN	_TC_SUPERO
  EXE	_T_NEWCLAS

MODULE def
  EXE	_TC_DEFERE	_TC_PROTER	_T_CLASSDO

MODULE class
  EXE	TC_VERSION

MODULE arrp
  EXE	TC_ASSTRIN	TC_CLONE	TC_EVAL		TC_EVAL2
  EXE	TC_FILL		TC_XPRINT

MODULE object
  EXE	OBJECT

MODULE t_get
  EXE	T_GET		T_GETNEW

MODULE t_tbcol
  EXE	T_TBCNEW	T_TBCOLNEW	T_TBCOLUMN

MODULE t_tbr
  EXE	T_TBROWSE	T_TBROWSED	T_TBROWSEN

MODULE t_error
  EXE	T_ERROR		T_ERRORNEW

MODULE app
  EXE	WAPP

MODULE mdiapp
  EXE	WMDIAPP

MODULE appbase
  EXE	WAPPBASE

MODULE sdiwin
  EXE	WSDIWINDOW

MODULE framewin
  EXE	WFRAMEWIND

MODULE window
  EXE	WWINDOW

MODULE winbase
  EXE	WWINDOWBAS

MODULE mdiframe
  EXE	WMDIFRAME

MODULE mdiclien
  EXE	WMDICLIENT

MODULE mdichild
  EXE	WMDICHILD

MODULE ddeserve
  EXE	WDDESERVER

MODULE ddeclien
  EXE	WDDECLIENT

MODULE help
  EXE	WHELP

MODULE menu
  EXE	LOADMENUN	LOADMENUS	WMENU

MODULE sysmenu
  EXE	WSYSTEMMEN

MODULE popup
  EXE	WPOPUP

MODULE menubase
  EXE	WMENUBASE

MODULE menuitem
  EXE	WMENUITEM

MODULE menufn
  EXE	_MENUAPPEN	_MENUBEGIN	_MENUEND	_POPUPBEGI
  EXE	_POPUPEND

MODULE dialog
  EXE	WDIALOG

MODULE control
  EXE	WCONTROLWI

MODULE bitmap
  EXE	WBITMAP		WBITMAPSTR

MODULE bitmapfi
  EXE	WBITMAPFIL	WBITMAPFST

MODULE button
  EXE	WPUSHBUTTO

MODULE buttnbmp
  EXE	WBUTTONBIT

MODULE radiobtn
  EXE	WRADIOBUTT

MODULE arrowbtn
  EXE	WARROWBUTT

MODULE spinbtn
  EXE	WSPINBUTTO

MODULE checkbox
  EXE	WCHECKBOX

MODULE groupbox
  EXE	WGROUPBOX

MODULE listbox
  EXE	WLISTBOX

MODULE combobox
  EXE	WCOMBOBOX

MODULE edit
  EXE	WEDIT		WMLEDIT

MODULE wget
  EXE	WGET

MODULE scrollba
  EXE	WHORIZSCRO	WSCROLLBAR	WVERTSCROL

MODULE text
  EXE	WCENTERTEX	WLEFTTEXT	WRIGHTTEXT	WSSCONTROL
  EXE	WTEXTCONTR

MODULE browse
  EXE	WDBROWSE

MODULE blistbox
  EXE	WBLISTBOX

MODULE progbar
  EXE	WPROGRESSB	WPROGRESSD

MODULE toolbar
  EXE	WTOOLBAR	WTOOLBARTI

MODULE toolbdlg
  EXE	WTOOLBARDI

MODULE statbar
  EXE	WSTATUSBAR

MODULE table
  EXE	WDBTABLE	WTABLE

MODULE odbc
  EXE	WODBC		WODBC_CHOO

MODULE vbxdlg
  EXE	WVBXDIALOG

MODULE vbxctl
  EXE	WVBXCONTRO

MODULE stack
  EXE	STACK

MODULE otabt
  EXE	OTAB

MODULE otab
  EXE	_CLASSNAME	_CREATEDLG	_DRAWFRAME	_DRAWTABS
  EXE	_SHOWPAGE

