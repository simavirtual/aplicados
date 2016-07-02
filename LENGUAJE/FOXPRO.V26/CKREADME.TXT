                     CKREADME.TXT
**********************************************************
 Microsoft(R) FoxPro(R) Version 2.6 Professional Edition

     Connectivity Kit for Windows(TM) and MS-DOS(R)

   (C)1994 Microsoft Corporation. All Rights Reserved.
**********************************************************

=========
CONTENTS
=========

Part   Description
----   -----------
 1     Installation
 2     Tips and Tricks
 3     Changes to Connectivity Kit User's Guide Since Printing
 4     Answers to Commonly Asked Questions
----------------------------------------------------------

=====================
Part 1: Installation
=====================

Installing the Professional Edition of FoxPro 2.6
-------------------------------------------------
The Professional Edition of FoxPro 2.6 includes the
following kits:

Distribution Kit
Connectivity Kit
Library Construction Kit
WorkGroup Extensions (FoxPro for Windows only) 

To install the Professional Edition of FoxPro, first install
the main FoxPro product, then follow the installation 
instructions included with each individual kit.  The order 
in which the kits are installed does not matter.
----------------------------------------------------------

Installing the Client-Server Wizard
-----------------------------------
To install the Client-Server Wizard, follow these steps:

1. Replace the following file, located in the subdirectory 
   WIZARDS, with the version shipped with the Professional
   Edition.  

   WIZARD.APP

2. Delete the following files, located in the subdirectory 
   WIZARDS.

   WIZARD.DBF
   WIZARD.FPT

   The first time you run the Client-Server Wizard these
   files are re-created with new default values.

To run the Client-Server Wizard you must have ODBC already 
installed. For information on installing ODBC, see the 
Connectivity Kit User's Guide.
----------------------------------------------------------

Installing ODBC from 720KB disks
--------------------------------
If you are installing the Connectivity Kit from 720KB 
floppy disks, the ODBC files are contained on two floppy
disks, and cannot be installed from the disks. To install 
the ODBC files follow these steps:

1. Create a new directory called ODBC on your hard drive.

2. Copy the contents of the two ODBC disks into this 
   directory.

3. Run the install program.
----------------------------------------------------------


========================
Part 2: Tips and Tricks
========================

FoxPro for Windows to ORACLE(R) Connectivity
--------------------------------------------
While the Connectivity Kit includes the ORACLE ODBC driver, 
FoxPro for Windows to ORACLE Connectivity requires some
SQL*NET drivers for Windows, which is available from ORACLE 
only. Contact your ORACLE representative.

If you're using ORACLE, make sure you read the ORACLE.TXT 
file on the ODBC disk.  This file contains information you
need to make a connection to ORACLE.
----------------------------------------------------------

SQL Server to FoxPro for MS-DOS Field Size Limit
------------------------------------------------
The maximum length of each data field imported from SQL 
Server to a FoxPro for MS-DOS cursor or table is 65530 
bytes.  If your available memory is less than this value, 
or if you are importing data that is longer than 65530 
bytes, you must limit the size of the data exported by 
SQL Server to fit into your available memory. 

You can reduce the length of the data exported from SQL 
Server by using the Transact-SQL command "SET TEXTSIZE n", 
where n is equal to the desired text size in bytes.  For
example, to limit the length of data to 20K, you would
use the command "SET TEXTSIZE 20480".  For an explanation
of the SET TEXTSIZE command, refer to your SQL Server 
documentation.

If the data in an exported field exceeds the available
memory, DB-Library will terminate the connection.

This limit does not apply to FoxPro for Windows.  If you 
want to import a text or binary field that exceeds 65530
bytes, you can import the data into FoxPro for Windows and
then use the data in FoxPro for MS-DOS.
----------------------------------------------------------

Temporary File Space Requirements
---------------------------------
Keep in mind that when you import data into a FoxPro 
cursor or table, your system must have enough temporary 
file space to allow FoxPro to build the cursor or table.  
----------------------------------------------------------

Viewing System Warning Messages
-------------------------------
Set the DBSetOpt( ) DispError option to "ON" if you want 
to be able to view system warning messages.  System 
warning messages are displayed by FPSQL to notify you of 
conditions or problems encountered in processing a request.

For more information about specific messages, refer to 
"*Addition to the Appendix: System Warning Messages*" in
Part 2, "Changes to Connectivity Kit User's Guide Since 
Printing."
----------------------------------------------------------

Other Error Messages
--------------------
In addition to Connectivity Kit errors, FPSQL also displays
error messages sent by ODBC, DB-Library and SQL Server.  
For information about ODBC error messages, refer to the 
ODBC Software Developer's Kit documentation and to the 
driver and data source documentation for the data 
source currently in use.  For a list of DB-Library error 
messages, refer to the Microsoft SQL Server Programmer's 
Reference for C in the Microsoft SQL Server Programmer's 
Toolkit.  

You'll find an explanation of the more common SQL Server
errors in the Microsoft SQL Server Troubleshooting Guide.
If you don't find information about a specific SQL Server
error message in the Troubleshooting Guide, please contact
your SQL Server system administrator or your SQL Server 
primary support provider.
----------------------------------------------------------

Using SQL Server Triggers to Return Error Messages
--------------------------------------------------
If you're relying on SQL Server triggers to return error
messages, be sure you include the Transact-SQL "RAISERROR"
command in your trigger.  FPSQL then recognizes the error
and returns the information.  For more  information about 
the "RAISERROR" command, refer to the Microsoft SQL Server
Language Reference.
----------------------------------------------------------


=================================================
Part 3: Changes to Connectivity Kit User's Guide 
        Since Printing
=================================================
The Connectivity Kit now includes support for the following
features.

NULL Support
------------
You can now define NULL constants for four types of  FoxPro
null values. The default for all cases is a string of empty 
spaces.

Name           Size
----           ----
CharNull        30
IntNull         20
FloatNull       20
DateNull        23
 
The values can be set and returned using the following option 
functions, where <expC> is the name of the Null option.

DBSetOpt(<expN>, <expC>[, <exp>])
DBGetOpt(<expN>, <expC>)

For more information of these functions see the Connectivity
Kit User's Guide.


Mulitiple Error Messages
------------------------
The Connectivity Kit now returns a list of up to five error 
messages per connection. DBError includes a fourth parameter 
that indicates which error message is requested from the 
list of error messages.

Syntax: DBError (<expN1> [, @<memvar1> [, @<memvar2>] [,<expN2>]])

<expN2> returns a value between 1 and 5 corresponding to the
error message in the error message list.  Invalid values for
<expN2> are defaulted to the nearest valid value. If the
parameter is not specified, the latest error message is
returned.

Date Strings
------------
Date type values imported from a data source are now converted
to character strings in FoxPro.
----------------------------------------------------------


The following are corrections to the documentation since printing.

Appendix, page 68, Connectivity Kit Errors by Number
----------------------------------------------------
Delete error numbers 17 "Failed to set connection time-out"
and 18 "Failed to set general time-out".  These situations 
now produce system warning messages.  

Add error number 36 "Cannot set transaction option while in
a transaction" (MS-DOS only).

Appendix, page 69, Connectivity Kit Errors Alphabetically
---------------------------------------------------------
Add:  Cannot set transaction option while in a transaction" 
(36) (MS-DOS only).
  If you are in manual transaction mode and have made the
  first call to DBExec( ), you are in an active 
  transaction.  In this case, you must explicitly end the
  transaction by calling DBTransact( ) with a Commit or 
  Rollback statement before you can either call 
  DBSetOpt( ) to change the transaction mode or call 
  DBDisconnect( ).

Change to error number 33 "Cannot disconnect while in a
transaction" (MS-DOS only).
  
In manual mode, you can end a current transaction only by
calling DBTransact( ), not by changing the transaction mode
with DBSetOpt( ).  The new description for FPSQL error 33
should read:

  Before you can call DBDisconnect( ), you need to end the
  current transaction by calling DBTransact( ).

Addition to the Appendix: System Warning Messages
-------------------------------------------------
FPSQL provides system warning messages which notify you of
conditions or problems encountered during processing.  In 
contrast to error messages, which indicate fatal problems 
that interrupt processing, system warning messages indicate
conditions or problems that are not serious enough to 
interrupt processing.  The following system warning 
messages have been added to the Connectivity Kit:

Msg   System Warning Message              Platform
No.
----  ----------------------------------  ----------------
1     Failed to set connection time-out    (MS-DOS/Windows)
2     Failed to set general time-out       (MS-DOS/Windows)
3     Data precision lost in conversion   (MS-DOS/Windows)
4     Failed to convert memo field        (MS-DOS/Windows)
5     Failed to clear connection          (MS-DOS/Windows)  

6     Failed to set transaction mode      (Windows only)
7     Failed to set connection in
      asynchronous mode                   (Windows only)

10    Failed to set DB-LIB text limit     (MS-DOS only)
11    Failed to set in use the specified
      database                            (MS-DOS only)

Connectivity Kit System Warning Messages Alphabetically
-------------------------------------------------------
Data precision lost in conversion (3)    
  Shows any data conversion error from whatever data source
  type to FoxPro.  This message is displayed once at the 
  end of the result set conversion for one or multiple 
  problems encountered during the conversion process.

Failed to clear connection (5)
  FPSQL was unable to clear the connection.  The error 
  could indicate corruption of FPSQL memory space or a 
  problem either in the connection channel or on the 
  data source. 
  
Failed to convert memo field (4)             
  Indicates any error while converting data to FoxPro
  memo fields (not enough memory, temporary file error, 
  etc.)  This message is displayed once at the end of the
  result set conversion for one or multiple problems 
  encountered during the conversion process.

Failed to set connection in asynchronous mode (7)
  Windows only.  Indicates an error in the ODBC call for
  the current data source.

Failed to set connection timeout (1)
  FPSQL was unable to set the specified connection timeout 
  for an attempted connection to a data source.  The 
  connection attempt will timeout according to the data
  source default connection timeout.        

Failed to set DB-LIB text limit (10)
  MS-DOS only.  Shows an error in setting the maximum 
  DB-Library text size to 65530 bytes. 

Failed to set general timeout (2)             
  FPSQL was unable to set the specified general timeout 
  for a connection to a data source.  The connection
  will use the data source default general timeout. 

Failed to set in use the specified database (11)
  MS-DOS only.  Indicates an error when trying to set in
  use the database specified as the fourth parameter in
  DBConnect().

Failed to set transaction mode (6)
  Windows only.  Indicates an error in the ODBC call for
  the current data source.
----------------------------------------------------------


============================================
Part 4: Answers to Commonly Asked Questions
============================================

Question 1

Our organization includes several FoxPro developers.
Does each developer need an individual copy of the
Connectivity Kit?

Answer 1

Your organization must own one licensed copy of the
Connectivity Kit per developer, for each developer
creating applications that use the Connectivity Kit. If 
five developers in your organization create applications
using one or both of the Connectivity Kit libraries 
(FPSQL.PLB and/or FPSQL.FLL), you must own five licensed 
copies of the Connectivity Kit.
----------------------------------------------------------

Question 2

I own licensed copies of both the FoxPro Distribution Kit
and the FoxPro Connectivity Kit. May I distribute the 
FPSQL libraries with applications I develop using the 
Distribution Kit?

Answer 2

Yes. As a licensed user of both the FoxPro Distribution 
Kit and the Connectivity Kit, you are free to distribute 
the FPSQL.PLB and/or FPSQL.FLL library file(s) with your
distributed application(s).
----------------------------------------------------------

                    ===================
                    END OF CKREADME.TXT
                    ===================
