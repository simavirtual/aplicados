
 Background on what the demo is about:

 I've noticed more and more Clipper programmers are using special libraries
 like "Remote Gilmore", "SilverClip" or "Telepathy" to send files to remote
 locations, and i came up with a idea that may help out these programmers!

 The following situation would most likely represent how a typical session
 would take place when sending file(s) to a remote site;

 1. Prepare files to send in a zipfile
 2. Place zipfile in holding area
 3. Auto send zipfile with a Clipper application
 4. Remote site receives zipfile
 5. Some poor soul on the remote site has the dreaded task of sorting
    through the zipfile and then sending the files to who they belong to.

 * I'd hate to be the poor soul in step five, if thier location is a large
   corporation and the files need to be processed and delivered to many
   employees. Imagine the remote site has 50 persons that files need to be
   sent to, this would eat up alot of someones time, and would be hard to
   devise some scheme to name the files for delivering to the right person.

 My idea would go as follows:

 1. Prepare files to send in a zipfile
        Insert id information and comments into the local directory of the 
        zipfile. The "id" might represent an entry in the bindery, a 
        internetwork node id, or the users name who should get the file.
 2. Place zipfile in holding area
 3. Auto send zipfile with a Clipper application
 4. Remote site receives zipfile
 5. A Clipper program parses the DnLoad directory for files and
        - Extracts comments and local sending information, that was inserted
          in step one above.
        - Uses the extracted information to deliver file(s) to each user
        - Broadcast message over the network to the node "You have mail" and
          also any special messages that may have been stored in the zipfile.
          (message was stored in the zipfile local directory)
 6. Once the files are copied to said users home directory on the system,
    the Clipper program would remove the zipfile, and also log a entry into
    some sort of mail logfile.


 To do the above, i use some tricks to make PKware's Pkzip and PkUnzip do 
 some slight of hand for you! A little history is in order, pkzip.exe allows
 you to place a file-wide comment into the top of a zipfile that may be up 
 to 4096 characters in length, and is mostly used by BBS sysops for placing
 advertisments for thier boards into it. Upon unzipping the file it is 
 displayed to standard out, which is usually the console. You could store 
 your information here if you only have a few files. but wait pkzip also 
 allows you to place comments at a deeper area in the zipfile which is 
 known as the "local directory". This is were i have developed code to do
 this for you, within your Clipper utility/program.


 Example:
 The comment section is broken down to include sections to store
 notes for displaying to whomever is getting the file (which may be sent
 via an network function from a Clipper library such as SEGUE). The
 rest of the local comment would be sectioned into where to send the file,
 (a specific office), and finally the node or user to send the file to at
 the location/office. There is even more room available for other uses.
 You could place several characters into the remaining section and then
 by checking to see if a bit is set or not, do something etc.

 Comment: Expenses for November 1993 from Carol Jones
 - The above comment is 43 characters long, so pad it to say 48
 - Next the user enters a code for the sub-location thru a picklist

 The string then may be inserted as follows:
    Expenses for November 1993 from Carol Jones    102937
             |                                       |
             |                                       |
    Comment -+                                       |
                                  Sub-location ------+

 The remote sites Clipper application would then extract the sub-location

 cLocation := alltrim( right(cString,10) )
 cMessage  := substr( ltrim(cString),1,48)

 //ÄÄÄÄÄ copy file to sub-location
 NETCOPY( cFile,cLocation )
 //ÄÄÄÄÄ broadcast message to sub-location
 NSENDMSG( cLocation, cMessage )


 Message is stored in some sort of holding area if the user i not currently
 logged into the netowork, and once they login the message is delivered!

 The user then will get the delivered file(s)

 Done!


 In a real life situation the sender would traverse through a Tbrowse that
 would allow them to tag files, and then enter comments and sub-locations,
 and date to send. Next the information would be entered into a masterfile
 and each night the Clipper program would search the masterfile, for any
 files slated to be sent for the current day. It would create the listfile
 and check to make sure the files still existed. Then the file is sent and
 the remote site's Clipper program would extract and send files to proper
 sub-locations or if a there are invalid sub-locations, or any problems -
 write them to a error data table.

 I have developed the disk routines to allow a user to traverse local and
 network drives and directories that also logs files into a mastefile. It
 also checks for duplication entries going to the same desination and will
 alert the operator. My routine looks and operates just like the file
 manager called Norton Commander.

 Remember that the demo is focusing on just packing files, and comments -
 and then mimicing the extraction of comments at a remote site..

 BTW Once the demo has completed there are two files i erase. By calling
 on UNERASE from Norton Utils version 6 or 7, you can view them and see
 some of the stuff i have done.


 I have done various operations for PKware/LHA,FlexFile II, FUNCKy II,
 SixCdx and ProVision:Backup with thier abilities to do compression in a
 Clipper application. These tip/tricks and ideas are for sell at low 
 prices. If you would like more information on how to incorporate them
 into your Clipper applications or utilities (install programs also) -
 contact me.

 CIS: 70034,2313
 Voice (215)947-3504
 Grumpfish BBS, under Kevin Gallagher (not Kevin S. Gallagher)

 I'am also looking for a full-time position for either programming in
 Clipper, or teaching programming techniques of Clipper to any level
 of programmer envolved in Clipper, or just starting out with Clipper.


 Happy programming
 Kevin S. Gallagher


