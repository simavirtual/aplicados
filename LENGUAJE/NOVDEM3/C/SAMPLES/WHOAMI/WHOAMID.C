/*
 * WHOAMI emulator for Microsoft C 6.0 and NOVLIB 3.x
 * By Steve Busey 03/01/95
 *
 * Build:
 * 		cl /c /AL whoami_c.c
 * 		link whoami_c,,,novlib;
 *
 * Run with "WHOAMI_C /?" to see available options.
 *
 */

#include "novlibc.h"
#include <ctype.h>
#include <conio.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

#define FALSE	0
#define TRUE	1

#define lSYNTAX			0
#define lSERVER			1
#define lSECURITY 	2
#define lGROUPS			3
#define lCONTINUOUS 4
#define lWORKGROUPS 5

// global values
int     aFlags[7];
char    cpFSName[48];

// function prototypes
int  		empty( char *cStr );
void 		CheckArgs( char *cp );
void 		GetInfo( DWORD n );
void 		ShowSecurity( char *cUserID );
void 		ShowGroups( char *cUserID );
void 		newline( void );


void main( int argc, char *argv[] )
{
	BYTE i;

	// init all flags to FALSE
	for (i=0; i<6; i++ )
		aFlags[i] = FALSE;

	// parse command line
	if (argc > 1)
		for (i=1; i<argc; i++ )
			CheckArgs( (char*)argv[i] );

	// if SYNTAX flag set, show syntax
	if ( aFlags[lSYNTAX] ) {
		printf( "Usage:");
		newline();
    printf( "WHOAMI_C [Server] [/Security] [/Groups] [/WorkGroups] [/All] [/Continuous] [/?]");
		newline();
		newline();
		return ;
	}

	// if SERVER flag set, show info for declared server name only
	if ( aFlags[lSERVER] ) {
        i = FSConnIDGet( cpFSName );
		if ( ConnUsed( i ) )
			GetInfo( (DWORD)i );
		else
			printf( "You are not attached to server %s.", cpFSName);
	}
	// else show info for all servers connected to
	else {
		for ( i = 1; i < 9; i++ )
			if (ConnUsed(i)) {
				GetInfo( (DWORD)i );
			}
	}
}

// function to check command line arguments and set global flags
void CheckArgs( char *cp )
{

	strupr( cp );
	if (      (strcmp( cp, "/S")==0) || ( strcmp( cp, "/SECURITY")==0))
		aFlags[lSECURITY]   = TRUE;

	else if ( (strcmp( cp, "/C")==0) || ( strcmp( cp, "/CONTINUOUS")==0))
		aFlags[lCONTINUOUS] = TRUE;

	else if ( (strcmp( cp, "/G")==0) || ( strcmp( cp, "/GROUPS")==0))
		aFlags[lGROUPS]     = TRUE;

  else if ( (strcmp( cp, "/W")==0) || (strcmp( cp, "/WG")==0) || 
            (strcmp( cp, "/WORKGROUPS")==0))
    aFlags[lWORKGROUPS] = TRUE;

  else if ( (strcmp( cp, "/A")==0) || ( strcmp( cp, "/ALL")==0)) {
    aFlags[lSECURITY]   = TRUE;
    aFlags[lGROUPS]     = TRUE;
    aFlags[lWORKGROUPS] = TRUE;
  }
	else if ( isalpha(cp[0]) ) {
		strcpy( cpFSName, cp );
		aFlags[lSERVER]     = TRUE;
	}
	else
		aFlags[lSYNTAX]     = TRUE;

}

// function to get server info based on server ID number parameter
void GetInfo( DWORD nConnNum )
{
	int 				nHour;
    char                *cp;
	char	 			sDTFmt[] = "%A  %B  %d, %Y ";
	char 	 			cpUser[16], cTimeDate[64], cVersion[6];
	struct tm		t;
	RETCODE	  	nWSConn;

	// set preferred server ID number and get server name
    FSPreferredConnSet( (WORD) nConnNum );
    FSNameGet( (WORD)nConnNum, cpFSName );

	// if name is not null string, get info
	if ( !empty( cpFSName ) ) {

		// get workstation connection and name
        nWSConn  = WSConnNumberGet();
        WSLoginNameGet( nWSConn, cpUser );

		// display server/workstation info
		if ( !empty( cpUser ) )
			printf( "You are user %s attached to server %s, connection %d.",
						cpUser, cpFSName, nWSConn);
		else
			printf( "You are attached to server %s, connection %d, but not logged in.",
					 cpFSName, nWSConn );

		// get netware version info, strip of leading spaces, and display
        NWVersionNumberGet(cVersion);
		newline();
		printf( "Server %s is running NetWare v%s (%d user).",
                        cpFSName, cVersion, FSConnMaxGet());

    // print workgroup manager status, if requested
    if ( aFlags[lWORKGROUPS] ) {
      if ( UsrGroupManagerTest( cpUser ) ) {
        newline();
        printf( "You are a workgroup manager." );
      }  
    }

    // if logged in, get login date/time
		if ( !empty( cpUser ) ) {

            cp = malloc(10);                 // Allocate buffer
			//populate time (TM) struct
            WSLoginDateGet( nWSConn, cp );   // get login date
			t.tm_mday = atoi( cp+6 );        // Day of month (1--31)
			cp[6] = '\0';                    // truncate date string
			t.tm_mon  = atoi( cp+4 ) - 1;    // Month (0--11)
			cp[4] = '\0';                    // truncate date string
			t.tm_year = atoi( cp ) - 1900;   // Year (calendar year minus 1900)

            WSLoginTimeGet( nWSConn, cp );
			t.tm_sec  = atoi( cp+6 );        // Seconds
			cp[5] = '\0';                    // truncate time string
			t.tm_min  = atoi( cp+3 );        // Minutes
			cp[2] = '\0';                    // truncate time string
			t.tm_hour = atoi( cp );          // Hour (0--23)

			mktime( &t );                    // fill in the blanks...
            free(cp);                        // Free the buffer
			// format date info
			strftime( cTimeDate, 64, sDTFmt, &t );
			nHour = (t.tm_hour==0 ||t.tm_hour==12) ? 12 : (t.tm_hour%12);

			// display date/time line
			newline();
			printf( "Login time: %s %d:%2.2d %s",
						cTimeDate, nHour, t.tm_min, ((t.tm_hour<12) ? "am":"pm"));
			newline();

      // show security equivalence, if requested
      if ( aFlags[lSECURITY] )
				ShowSecurity( cpUser );

			// show groups belonged to, if requested
      if ( aFlags[lGROUPS] )
				ShowGroups( cpUser );

		}
		newline();
	}
}

// display security equivalences for given user ID
void ShowSecurity( char *cUserID )
{
    char    cPropValue[48];
	WORD	nOffset;
	DWORD	rc, nObjID, nObjTyp;

	// ensure user object has security properties
    if ( PrpValueTest( cUserID, OT_USER, "SECURITY_EQUALS" ) ) {
		printf( "You are security equivalent to the following:");
		nOffset = 1;
		while (TRUE) {
			// get each security property (incrementing nOffset)
            rc = SetPropertyValueGet( cUserID, OT_USER, "SECURITY_EQUALS", nOffset++ );
            ObjNameGet( rc, cPropValue );
			newline();

			// if empty, no more security, so we're finished here
			if ( empty( cPropValue ) )
				break;

			// else display security property and whether user or group
			else {
				printf( "    %s", cPropValue);

                nObjID   = ObjIDGet( cPropValue, OT_USER_GROUP );
				if ( nObjID == -1)
                    nObjID = ObjIDGet( cPropValue, OT_USER );
				if ( nObjID == -1)
                    nObjID = ObjIDGet( cPropValue, (WORD)OT_WILD );

                nObjTyp = ObjTypeGet( nObjID );
				if (nObjTyp == OT_USER)
					printf( " (User)");
				else if (nObjTyp == OT_USER_GROUP)
					printf( " (Group)");
				else
					printf( " (Unknown)");
			}
		}
	}
}

// function to show groups a given user belongs to
void ShowGroups( char *cUserID )
{
	WORD 	nOffset = 1;
	DWORD rc;
    char    cGroups[47];

	printf( "You are a member of the following groups:" );

	// get first group user belongs to (nOffset == 1)
    rc = SetPropertyValueGet( cUserID, OT_USER, "GROUPS_I'M_IN", nOffset++);
    ObjNameGet( rc, cGroups );

	// display results until group name is NULL string
	if (!empty( cGroups ))
		newline();

	while (!empty( cGroups )) {
		printf("    %s", cGroups);
		newline();

		// get next group info
        rc = SetPropertyValueGet( cUserID, OT_USER, "GROUPS_I'M_IN", nOffset++);
        ObjNameGet( rc, cGroups );
	}
}

// function to keep track of lines sent to screen,
// and display the carriage return/line feed
// works with CONTINUOUS flag
void newline( void )
{
	static int 	nLinesShown = 0;
	int 				nVidLines = 22, nKey;

	// if CONTINUOUS flag is set, we can skip this part
	if ( (!aFlags[lCONTINUOUS]) && ( nLinesShown >= nVidLines )) {
		nLinesShown = 0;

		// display prompt and wait for keypress
		printf("\r\nPress any key to continue ... ('C' for continuous)");
		nKey = getch();
		nKey = toupper( nKey );

		// if 'C' key pressed, set CONTINUOUS flag TRUE
		if (nKey== 'C')
			aFlags[lCONTINUOUS] = TRUE;

		// clear prompt from screen
 		printf("\r                                                  \r");
	}
	else {
		nLinesShown++;
		printf( "\r\n" );
	}
}

// function to return TRUE if a string is NULL, else FALSE
int empty( char * cStr )
{
	return( (cStr[0] == '\0') );
}
