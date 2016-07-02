// GetPrinter()
//
// This function returns the Print Queue Name of the printer
// that has the least number of jobs and the least amount to print
// it simply gets a list of queues, then a list of each queues jobs
// and then calculates the total size of all the jobs, sorts them, and then
// returns the name of the queue that has the least amount total job size.
// It also tests to make sure the queue hasn't been halted, or is not
// accepting any more jobs.
//
// Written by Goth
//

#include "novlib.ch"

Function GetPrinter()

LOCAL aQueueList, cQueueName, cLoginName, aQJobList, nQueueID, nArrayCounter
LOCAL nJobCounter, nJobCopies, nSizeCounter

aQueueList := {}
cLoginName := WSLOGNMEGET()                        // get user name

cQueueName := FSOBJLST( "*", OT_PRINT_QUEUE, .T. )  // get first print queue

do while !( empty( cQueueName ) )                // do while more queues
  nQueueID := QUEIDGET( cQueueName )                  // get queues object ID
  if !(QUEHALTGET( nQueueID )) .AND. QUEADDGET( nQueueID ) // doe's queue work !
    aadd( aQueueList, { cQueueName, 0 } )            // add it to list
  endif
  cQueueName := FSOBJLST("*",OT_PRINT_QUEUE, .F.)                         // get next queue
enddo

for nArrayCounter = 1 to len( aQueueList )       // scan queue list

  nQueueID := QUEIDGET( aQueueList[ nArrayCounter ][1] ) // get queue ID
  aQJobList := array( QUEQJBLST( nQueueID, .T. ) )               // get No. of jobs

  for nJobCounter = 1 to len( aQJobList )        // get job numbers
    aQJobList[ nJobCounter ] := QUEQJBLST(nQueueID, .F.)          // put them in list
  next

  nSizeCounter := 0                              // initialise total size
                                                 // add up size of each job
  for nJobCounter = 1 to len( aQJobList )        // * number of copies
    if !( QJBUSRHLDGET( nQueueID, aQJobList[ nJobCounter ] ) ) .AND.;
       !( QJBOPRHLDGET( nQueueID, aQJobList[ nJobCounter ] ) )
      nSizeCounter += QJBSIZEGET( nQueueID, aQJobList[ nJobCounter ] ) *;
                      QJBCPYGET( nQueueID, aQJobList[ nJobCounter ] )
    endif
  next

  aQueueList[ nArrayCounter ][2] := nSizeCounter  // put total size in list

next
                                                  // get smallest total 
cQueueName := asort( aQueueList,,,{ |x,y| x[2] < y[2] } )[1][1]

return( cQueueName )                              // return queue name

