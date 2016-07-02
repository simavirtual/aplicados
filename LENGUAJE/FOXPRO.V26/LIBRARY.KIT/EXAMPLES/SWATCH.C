/*
**
*
* SWATCH.C - Sample API routine.
*
* Copyright (c) 1989-1993 Microsoft Corporation as an unpublished
* licensed proprietary work.  All rights reserved.
*
* Description:
*		This library puts a creates a window with a
*		stopwatch running in it.  You can Start, Stop
*		and Split the time.  It uses the API Event
*		processing along with Menu and Windowing API
*		functions.
*
**
 */

#include <pro_ext.h>
#include <dos.h>

WHandle wh=0;			// My window handle

Ticks elapsed = 0;		// Number of ticks in the display

Ticks lastwhen = 0;		// Last time we updated the display

unsigned running = 0;           // Is the watch started?

Rect left = { 4,1,5,11 };	// The left button's rectangle

Rect center = { 4,12,5,22 };	// The center

Rect right = { 4,23,5,33 };	// The right

unsigned handlerid=0;		// The handler id given to us for SWHandler

MenuId sysmenuid;		// Menu id of FoxPro's "system" menu.
ItemId sysitemid;		// Item id of the item we add to it
MenuId mymenuid;		// The Stop Watch menu's id.
ItemId myitemid;		// The Stop Watch menu's pad in the system
				// menu bar.

#define TicksPerSecond 18.2064819336
#define TickCount()    (*(long far *)MK_FP(0x0000, 0x46c))

//
// Update either the left or right display with the time given
//
void FAR SWDisplay(char FAR *time, int dispnum)
{
    Point pt;
    _WSetAttr(wh, WA_PENCOLOR, _WAttr(wh, WA_ENHANCED));
    pt.v = 1;
    pt.h = dispnum == 1 ? 7 : 16;
    _WPosCursor(wh, pt);
    _WPutStr(wh, time);
    _WSetAttr(wh, WA_PENCOLOR, _WAttr(wh, WA_NORMAL));
}

//
// Is the Point given inside the rectangle given?
//
int FAR PtInRect(p, r)
Point p;
Rect r;
{
    return ((p.v>=r.top && p.v<r.bottom) && (p.h>=r.left && p.h<r.right));
}

//
// Draw the hotkey character of the given string in the hotkey color
//
void FAR SWHotKey(char FAR *t, Point pt, int hotkey)
{
    _WSetAttr(wh, WA_PENCOLOR, _WAttr(wh, WA_HOTKEY));
    pt.h += hotkey;
    _WPosCursor(wh, pt);
    _WPutChr(wh, t[hotkey]);
}

//
// Draw the given text as a button in the given rectangle
//
void FAR SWButton(char FAR *t, Rect FAR *r, int hotkey)
{
    Point pt;

    _WSetAttr(wh, WA_PENCOLOR, _WAttr(wh, WA_ENABLED));
    pt.v = r->top;
    pt.h = r->left;
    _WPosCursor(wh, pt);
    _WPutStr(wh, t);
    SWHotKey(t, pt, hotkey);
}

//
// Redraw all of the buttons using the worker routines above.
//
void FAR SWButtons()
{
    SWButton("< Reset >", &left, 2);
    SWButton("< Split >", &center, 3);
    if (!running)
    {
	_SetItemText(mymenuid, 2, "\\<Start");
	SWButton("< Start >", &right, 2);
    }
    else
    {
	_SetItemText(mymenuid, 2, "\\<Stop");
	SWButton("< Stop  >", &right, 2);
    }
    _WSetAttr(wh, WA_PENCOLOR, _WAttr(wh, WA_NORMAL));
}

//
// Convert a number < 100 to ascii
//
void FAR SWToAscii(int num, char FAR *t)
{
    *t = '0' + (num / 10);
    *(t+1) = '0' + (num % 10);
}

//
// Update either the left or right display with the elapsed time.
//
void FAR SWUpdate(int dispnum)
{
    char time[10];
    int minutes, seconds, hundredths;
    double total;
    Ticks tseconds;

    total = elapsed / TicksPerSecond;
    tseconds = (Ticks)total;

	hundredths = (int) ((total - tseconds) * 100.00);

    minutes = tseconds / 60;

    seconds = tseconds % 60;

    SWToAscii(minutes, time);
    time[2] = ':';
    SWToAscii(seconds, time+3);
    time[5] = '.';
    SWToAscii(hundredths, time+6);
    time[8] = '\0';

    SWDisplay(time, dispnum);
}

//
// Handle NullEvents
//
int FAR SWNull(EventRec FAR *ev)
{
    if (!running)
	return NO;

    if (ev->when == lastwhen)
	return NO;

    if (!lastwhen)
	elapsed = 0;
    else
	elapsed += ev->when - lastwhen;

    if (elapsed >= 100.0 * (TicksPerSecond * 60.0))
	elapsed = 0;

    lastwhen = ev->when;
    SWUpdate(1);
    return YES;
}

//
// Service the Split button.
//
void FAR SWSplit(EventRec FAR *ev)
{
    SWNull(ev);
    SWUpdate(2);
}

//
// Service the Reset button.
//
void FAR SWReset()
{
    elapsed = lastwhen = 0;
    SWDisplay("00:00.00",1);
    SWDisplay("00:00.00",2);
}

//
// Service the start button.
//
void FAR SWStart(EventRec FAR *ev)
{
    running = YES;
    lastwhen = ev->when;
}

//
// Service the stop button.
//
void FAR SWStop()
{
    running = NO;
}

//
// Remove the stop watch from the screen.
//
int FAR SWClose()
{
    _WHide(wh);
    return YES;
}

//
// Handle mouseDownEvents
//
int FAR SWMouse(EventRec FAR *ev)
{
    WHandle theWindow;			// Where was the click?
    int where = _FindWindow(&theWindow, ev->where);
    Point pt;

					// If not in our window, we don't care.
    if (wh != theWindow)
	return NO;

    switch(where)
    {					// Within our borders.
	case inContent:
	    pt = ev->where;
	    _GlobalToLocal(&pt, wh);
					// In one of our buttons?
	    if (PtInRect(pt, right))
	    {
		if (running)
		    SWStop();
		else
		    SWStart(ev);
	    }
	    else if (PtInRect(pt, center))
		SWSplit(ev);
	    else if (PtInRect(pt, left))
		SWReset();
	    else			// If not, we don't care.
		return NO;

	    SWButtons();
	    return YES;
					// In close box? Just hide ourselves
	case inGoAway:			// so we can run in the background.
	    _WHide(wh);
	    return YES;

	default:
	    return NO;
    }
}

//
// Handle keyDownEvents
//
int FAR SWKey(EventRec FAR *ev)
{
    switch(ev->modifiers + ev->message)
    {
	case 'R' + shiftKey:
	case 'r':
	    SWReset();
	    return YES;

	case 'P' + shiftKey:
	case 'p':
	    SWSplit(ev);
	    return YES;

	case 'S' + shiftKey:
	case 's':
	    if (running)
		SWStop();
	    else
		SWStart(ev);

	    SWButtons();
	    return YES;

	case 27:			// Escape key.
	    _WHide(wh);
	    return YES;

	default:
	    return NO;
    }
}

//
// This routine is registered as an _OnSelection routine for the item we
// added to the system menu, and for the items on the popup we hung off
// the menu bar.
//
FAR SWMenu(MenuId menuid, ItemId itemid)
{
    EventRec ev;

    ev.when = TickCount();
					// They selected our system menu item
    if (menuid == sysmenuid && itemid == sysitemid)
    {
	_WShow(wh);
	_WSelect(wh);
    }					// They selected from our popup
    else if (menuid == mymenuid)
    {
	switch (itemid)
	{
	    case 0:
		SWReset();
		break;

	    case 1:
		SWSplit(&ev);
		break;

	    case 2:
		if (running)
		    SWStop();
		else
		    SWStart(&ev);
		break;

	    default:
		return NO;
	}
	SWButtons();
    }
    else
	return NO;

    return YES;
}

//
// This routine is registered as an event handler.  It gets passed EVERY
// SINGLE EVENT FoxPro creates. It returns immediately on events
// that belong to other windows, except nullEvents, which tell us to
// update our display, if we're running.
//
FAR SWHandler(WHandle theWindow, EventRec FAR *ev)
{
    switch(ev->what)
    {
	case nullEvent:
	    return SWNull(ev);

	case closeEvent:
	    if (theWindow != wh)
		return NO;

	    return SWClose();


	case mouseDownEvent:
	    if (theWindow != wh)
		return NO;

	    return SWMouse(ev);

	case keyDownEvent:
	    if (theWindow != wh)
		return NO;

	    return SWKey(ev);

	default:
	    return NO;
    }
    return YES;
}

//
// Set up the System menu bar.  This is called when during initialization.
//
FAR SWMenuSetup()
{
    int menubarid;

					// Get the System menu's id
    sysmenuid = _MenuId(_SYSTEM);
					// Get a new item id for it.
    sysitemid = _GetNewItemId(sysmenuid);
					// Put a new item in it.
    _NewItem(sysmenuid, sysitemid, _LASTITEM, "Stop \\<Watch");
					// Establish SWMenu() as the item's
					// service routine.
    _OnSelection(sysmenuid, sysitemid, SWMenu);

					// Get the Menu Bar's id.
    menubarid = _MenuId(_SYSMENU);
					// Get a new item id for it.
    myitemid = _GetNewItemId(menubarid);
					// Put a new pad on the end.
    _NewItem(menubarid, myitemid, _LASTITEM, "S\\<top Watch");


    mymenuid = _GetNewMenuId();		// Get an id for a new popup.
    _NewMenu(MPOPUP, mymenuid);         // Create the popup.
    _SetItemCmdKey(menubarid, myitemid, 0x4114, "Alt+T");
					// Make the popup a submenu of the
					// new pad.
    _SetItemSubMenu(menubarid, myitemid, mymenuid);

					// Add its items and their hotkeys.
    _NewItem(mymenuid, 0, _LASTITEM, "\\<Reset");
    _SetItemCmdKey(mymenuid, 0, 0x4178, "Alt+1");
    _NewItem(mymenuid, 1, _LASTITEM, "S\\<plit");
    _SetItemCmdKey(mymenuid, 1, 0x4179, "Alt+2");
    _NewItem(mymenuid, 2, _LASTITEM, "\\<Start");
    _SetItemCmdKey(mymenuid, 2, 0x417a, "Alt+3");

					// Establish its service routine.
    _OnSelection(mymenuid, -1, SWMenu);
}

//
//  Tear down the stop watch's menuing environment.
//
FAR SWMenuTerm()
{
    _DisposeItem(sysmenuid, sysitemid);
    _DisposeItem(_MenuId(_SYSMENU), myitemid);
    _DisposeMenu(mymenuid);
}

//
//  This is called on unload to deinstall the stop watch.
//
void FAR SWTerm()
{
    if (!wh)			// If we're not active, forget it.
	return;
				// Stop the music.
    _DeActivateHandler(handlerid);
				// Throw our window away.
    _WClose(wh);
				// Clean up the menu bar.
    SWMenuTerm();
				// Reset our globals.
    wh = elapsed = lastwhen = running = 0;
}

//
// This is Called on Load to initialize the stop watch.
//
FAR SWInit()
{
    char border[maxBorderLen+1];

				// If we're already loaded, unload first.
    if (wh)
        SWTerm();

    _StrCpy(border, WO_SYSTEMBORDER);
				// We have no zoom or grow boxes.
    border[topRightCorner] =
	border[deselectBorder+topRightCorner] =
	border[bottomRightCorner] =
	border[deselectBorder+bottomRightCorner] = ' ';

				// Create our window.
    wh = _WOpen(10,10,16,44,WMINIMIZE+MOVE+SHADOW+WEVENT+CLOSE,
		WINDOW_SCHEME, 0, border);

				// What's in a name?
    _WSetTitle(wh, "Stop Watch");

    SWReset();
    SWMenuSetup();
    SWButtons();
				// Start the music.
    handlerid = _ActivateHandler(SWHandler);
}

//
// This is the command line interface the stop watch.
//
FAR StopWatch(ParamBlk FAR *parm)
{
    Value FAR *v;
    EventRec ev;

    v = &parm->p[0].val;

    ev.when = lastwhen;

    switch (*(char FAR *)_HandToPtr(v->ev_handle))
    {
	case 'S':
	case 's':
	    if (running)
		SWStop();
	    else
		SWStart(&ev);
	    SWButtons();
	    break;

	case 'P':
	case 'p':
	    SWSplit(&ev);
	    break;

	case 'R':
	case 'r':
	    SWReset();
	    break;
    }
    _RetInt(elapsed, 10);
}


FoxInfo myFoxInfo[] = {
	{"STOPWATCH", (FPFI) StopWatch, 1, "C"},
	{"SWATCHI", (FPFI) SWInit, CALLONLOAD, ""},
	{"SWATCHT", (FPFI) SWTerm, CALLONUNLOAD, ""},
};

FoxTable _FoxTable = {
    (FoxTable FAR *)0, sizeof(myFoxInfo) / sizeof(FoxInfo), myFoxInfo
};
