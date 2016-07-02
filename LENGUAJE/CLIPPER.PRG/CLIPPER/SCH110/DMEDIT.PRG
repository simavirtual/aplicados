*****
* Custom Schooner function for editing a DBEDIT routine.
*****
function dmedit
*****
* It is always a good idea to select your database whenever you
* enter a DBEDIT() CUSTOM() UDF. 
*****
fselect("dmdemo")

*****
* The Schooner CUSTOM function defines two variables for DBEDIT()
*       MVPARM1=The mode of status of DBEDIT()
*       MVPARM2=The current field name
* It also returns one of three codes
*       0 = Quit DBEDIT
*       1 = Continue
*       2 = Repaint screen with any changes
* See DBEDIT() for more info. See also ACHOICE() and MEMOEDIT()
* Use this info to design your own custom functions for DBEDIT()
*****
***** Idle - no keystrokes to process *****
if mvparm1=0
    return 1
endif
***** An empty database *****
if mvparm1=3
    message("Selected database is empty.","           Press ESC to exit")
    return 0
endif
***** Check for keystroke *****
mvkeyval=lastkey()
    ***** ESC key *****
    if mvkeyval=27
        return 0
    endif
    ***** ENTER key. Allow editing *****
    if mvkeyval=13
        mvtemp=fieldname(mvparm2)
        setcursor(.t.)
        if type("&mvtemp")="M"
            mvscreen=savescreen(0,0,24,79)
            superbox(05,10,19,70,.t.,"",.t.)
            say(05,35,"EDIT NOTES")
            say(19,26,"CTRL-W to Save    ESC to Exit")
            mvtempmemo=memoedit(&mvtemp,06,11,18,69,.t.)
            insert("&mvtemp", "mvtempmemo")
            force()
            restscreen(0,0,24,79,mvscreen)
        else
            get(row(), col(), "&mvtemp")
            read
        endif
        setcursor(.f.)
        return 1
    endif
    ***** DELETE key *****
    * Note that file is opened exclusive. If it were opened shared, you 
    * would need to lock the file/record in order to delete a record. 
    * To FPACK() the file be sure to open the file exclusive. See OPEN().
    *****
    if mvkeyval=7
        *if rlock()
            delrec()
            fpack()
        *else
        *    message("Unable to lock file for your exclusive use.")
        *endif
        return 2
    endif
***** If an invalid key... just continue *****
return 1
