
// CapJob()
//
// This function sets up a capture using a predefined job configuration.
// Job configurations are created using the NetWare PRINTCON.EXE command
// line utility. They are stored for each user in a file called PRINTCON.DAT
// in the users mail directory
// This function finds the PRINTCON.DAT file and opens it. It then looks
// the job name passed as the parameter. If no parameter was passed or
// it cant find the specified job, it finds the default job.
// Once there it pulls out all the relevent information, calls the
// appropriate NOVLIB functions and starts the capture.
//
// examples:
//
// to set up capture to the default job configuration:
//
// if CapJob() == 0
//   ? "Capture started for default job configuration."
// endif
//
// to set up capture to job configuration MYJOB:
//
// if CapJob( "MYJOB" )
//   ? "Capture started for job configuration MYJOB."
// endif
//
// Written by Goth
//

#include "novlib.ch"

Function CapJob( cJobName )

LOCAL cFileName,nFileHandle,nFileLen,cText,nIndexOffset,nOffset
LOCAL cDefName,cServerName,cQueueName,nTabSize,nCopies,cFormName
LOCAL lNotifyFlag,nPServerID,cUserName,cBannerName,cDeviceName
LOCAL cModeName,lBannerFlag,lDataType,lFormFeed,nTimeOut,nPrinterNo
LOCAL lAutoEndCap,nOldPrefID

cFileName := WSDRVNETGET() + ":" + "\MAIL\"+;
                   ltrim(NOVSTRHEXGET(WSLOGIDGET()))+"\PRINTCON.DAT"

if file( cFileName )                      // is there a printcon.dat file

  nFileHandle := fopen( cFileName )       // open it

  if ferror() == 0

    nFileLen := fseek(nFileHandle,0,2)    // get length
    fseek(nFileHandle,0)

    cText := space(nFileLen)              // create buffer

    if !( fread(nFileHandle,@cText,nFileLen) == nFileLen )  // read in file
      return( -1 )                                                // oops !
    endif

    // here goes //

    cDefName := substr( cText, 119, 32 )                    // skip header
    cDefName := left( cDefName, at( chr(0), cDefName ) -1 ) // default job

    if ( cJobName == NIL )                // if no job name passed
      cJobName := cDefName                // make it default job
    endif

    cText := substr( cText, 151 )         // start at begining of index

    if( nOffset := at( cJobName, cText ) ) == 0   // find job
      cJobName := cDefName                // if not found make it default job
    endif

    nIndexOffset := bin2l(substr( cText, nOffset + 32, 4 ) )  // find offset

    cText := substr( cText, nIndexOffset - 149, 243 )    // get job

    cServerName := substr( cText, 1,  at( chr(0), cText ) - 1 )  // S=
    cText := substr( cText, 49 )
    cQueueName := substr( cText, 1, at( chr(0), cText ) -1 )     // Q=
    cText := substr( cText, 49 )
    nTabSize := bin2i( substr( cText, 1, 1 ) )                   // TAB=
    nCopies := bin2i( substr( cText, 2, 2 ) )                    // C=
    cText := substr( cText, 4 )
    cFormName := substr( cText, 1, at( chr(0), cText ) -1 )      // form
    cText := substr( cText, 41 )
    lNotifyFlag := if( substr( cText, 1, 1 ) != chr(0) , .T., .F. ) // notify
    nPserverID := bin2l( substr( cText, 2, 4 ) )                 // P server
    cText := substr( cText, 6 )
    cUserName := substr( cText, 1, at( chr(0), cText ) -1 )      // user
    cText := substr( cText, 14 )
    cBannerName := substr( cText, 1, at( chr(0), cText ) -1 )  // banner name
    cText := substr( cText, 14 )
    cDeviceName := substr( cText, 1, at( chr(0), cText ) -1 )    // device
    cText := substr( cText, 34 )
    cModeName := substr( cText, 1, at( chr(0), cText ) -1 )      // mode
    cText := substr( cText, 34 )
    lBannerFlag := if( substr( cText, 1, 1 ) != chr(0) , .T., .F. ) // banner
    lDataType := if( substr( cText, 2, 1 ) != chr(0) , .T., .F. )   // type
    lFormFeed := if( substr( cText, 3, 1 ) != chr(0) , .T., .F. )   // FF
    nTimeOut := bin2i( substr( cText, 4, 2 ) )                      // TI=
    nPrinterNo := val( chr( asc(substr( cText, 6, 1 )) + 48 ) )     // L=
    lAutoEndCap := if( substr( cText, 7, 1 ) != chr(0) , .T., .F. ) // auto

    fclose(nFileHandle)             // close file

    CAPEND( nPrinterNo )            // end existing capture

    nOldPrefID := FSPREFCONGET()        // save old server

    FSPREFCONSET( FSCONIDGET( cServerName ) )  // set new one

    CAPQUESET( nPrinterNo, QUEIDGET( cQueueName ) )  // set queue

    if !( lDataType )
      CAPTABFLGSET( nPrinterNo, .T. )                   // set tabs
      CAPTABSIZSET( nPrinterNo, nTabSize )
    else
      CAPTABFLGSET( nPrinterNo, .F. )
    endif

    CAPCOPIESSET( nPrinterNo, nCopies )               // set copies

    CAPFRMNMESET( nPrinterNo, cFormName )            // set form name

    CAPNFYFLGSET( nPrinterNo, lNotifyFlag )          // set notify

    CAPBANNMESET( nPrinterNo, cUserName )          // set users name on banner

    if ( lBannerFlag )
      CAPBANFLGSET( nPrinterNo, .T. )
      CAPBANTXTSET( nPrinterNo, cBannerName )        // set banner
    else
      CAPBANFLGSET( nPrinterNo, .F. )
    endif

    CAPFMFDSET( nPrinterNo, !(lFormFeed) )       // set form feeds

    CAPTMEOUTSET( nPrinterNo, nTimeout * 18 )           // set time out

    CAPAUTENDSET( nPrinterNo, lAutoEndCap )           // set autoend

    CAPSTART( nPrinterNo )                       // start capture

    FSPREFCONSET( nOldPrefID )                       // put back old server

  endif

else

  return( -2 )

endif

return( 0 )


