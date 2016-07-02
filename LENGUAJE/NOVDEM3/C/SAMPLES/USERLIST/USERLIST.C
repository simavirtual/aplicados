/*

USERLIST.C

A (sort of) emulation of Novell's USERLIST /A, using NOVLIB function calls

by Goth.

NOTE: Tested MSVC 1.5 (DOS),	Small,	Medium,	Large
             MSVC 1.5 (QWIN),	Small,	Medium,	Large
               TC 2.01,         Small,  Medium, Large
               TC 3.0,          Small,  Medium, Large
              MSC 5.1,			N/A		N/A		Large
              MSC 6.0,			N/A		N/A		Large

*/



#include "stdio.h"
#include "string.h"
#include "stdlib.h"
#include "novlibc.h"

typedef struct	{
					WORD	ConnectionNumber;
					char	UserName[49];
					char	Network[9];
					char	NodeAddress[13];
					char	LoginDate[11];
					char	LoginTime[11];
					int		NotLogged;
				} CONNECTION_INFO;

#define CONN_INFO_SIZE	sizeof( CONNECTION_INFO )
#define	TRUE	1
#define FALSE	0

main()
{

	WORD	MyConnectionNumber;
	WORD 	NumberOfConnections;
	WORD	PeakConnections;
	CONNECTION_INFO *ConBufPtr;
	CONNECTION_INFO *TempBufPtr;
    LPSTR   ServerName;
	WORD	i;

    MyConnectionNumber = WSConnNumberGet();

	if( !(MyConnectionNumber ) )
	{
		printf( "\nError - you are not connected to a Novell network\n\n" );
		return(1);
	}

    NumberOfConnections = FSCurrentConnGet();

    if( NWErrorGet() == -5 )
	{
		printf( "\nError - unable to initialise NOVLIB, not enough memory\n\n" );
		return(1);
	}

    ServerName = malloc(48);

    if( !(ServerName) )
	{
		printf( "\nError - unable to allocate memory\n\n" );
		return(1);
    }


	ConBufPtr = malloc( CONN_INFO_SIZE * NumberOfConnections );

	if( !(ConBufPtr) )
	{
		printf( "\nError - unable to allocate memory\n\n" );
		return(1);
	}

    FSNameGet(NOVDEFINT, ServerName );

	printf( "\nUser Information for Server %s\n", ServerName );
    printf( "Connection  User Name        Network    Node Address   Login Time (Logout)\n" );
    printf( "----------  --------------   --------   ------------   -------------------\n" );

    PeakConnections = FSPeakConnGet();

	TempBufPtr = ConBufPtr;
               
	for( i = 1; i <= PeakConnections; i++ )
	{
               
      WSLoginNameGet(i, (LPSTR) TempBufPtr->UserName) ;

        if( *(TempBufPtr->UserName) != '\0' )
        {
        	                                 
			TempBufPtr->NotLogged = FALSE;        	                                 
        	                                 
        	if( strcmp( TempBufPtr->UserName, "NOT-LOGGED-IN" ) == 0 )
        		TempBufPtr->NotLogged = TRUE;	
        	
        	TempBufPtr->ConnectionNumber = i;

            WSLoginDateGet(i, (LPSTR) TempBufPtr->LoginTime );

        	/* reorganise date from ASCII format (yyyymmdd) to US date format (mm-dd-yyy) */
        	/* apologies to European programmers, Novell do it this way ! */

        	strncpy( TempBufPtr->LoginDate, (TempBufPtr->LoginTime + 4), 2 );
        	TempBufPtr->LoginDate[2] = '-';
        	strncpy( (TempBufPtr->LoginDate + 3), (TempBufPtr->LoginTime + 6), 2 );
        	TempBufPtr->LoginDate[5] = '-';
        	strncpy( (TempBufPtr->LoginDate + 6), TempBufPtr->LoginTime, 4 );
        	TempBufPtr->LoginDate[10] = '\0';

            WSLoginTimeGet(i, (LPSTR) TempBufPtr->LoginTime );
            WSNetAddressGet(i, (LPSTR) TempBufPtr->Network );
            WSNodeAddressGet(i, (LPSTR) TempBufPtr->NodeAddress) ;

			TempBufPtr++;

         }

	}

	TempBufPtr = ConBufPtr;

	for( i = 0; i <= ( NumberOfConnections - 1 ); i++ )
	{
		printf( "   %3u    %s %-14.14s  [%s] [%s] %c%s %s%c\n", TempBufPtr->ConnectionNumber,
				( TempBufPtr->ConnectionNumber == MyConnectionNumber ? "*" : " " ), TempBufPtr->UserName,
				TempBufPtr->Network, TempBufPtr->NodeAddress, ( TempBufPtr->NotLogged ? '(' : ' ' ),
				TempBufPtr->LoginDate, TempBufPtr->LoginTime, ( TempBufPtr->NotLogged ? ')' : ' ' ) );

		TempBufPtr++;

	}

	printf( "\n" );

	return(0);

}
