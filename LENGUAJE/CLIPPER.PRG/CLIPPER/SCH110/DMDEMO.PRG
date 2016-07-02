*****
* DMDEMO.prg
* 
* A sample SCHOONER program to demonstrate the ease and 
* power of SCHOONER.
*
* This program is a simple but useful database system that demonstrates
* most of the concepts found in SCHOONER and virtually all other power
* databases.
*****
*****
* Public variables
*****
public mvschooner
public mvchoice
public mvmainscrn
public mvparm1
public mvparm2
public mvparm3
public mvkeyval
public mvtemp
public mvscreen
public mvtempmemo
public mvstate
public mvudfscrn
public mvselect
public mvstroke
public mvudf_val

*****
* Set defaults
*****
clearscrn()
setscorebd(.f.)
setcolor("w+/b,w+/bg,gr+,b,gr+/b")
setcursor(.t.)
setbell(.t.)
setconfirm(.t.)
setdeleted(.f.)
*****
* It is always a good idea to select your database whenever you
* think it might possibly be unselected. In addition, make sure it
* is open...
*****
if .not. is_open("dmdemo")
    open("dmdemo","",.T.,"dmdemo")
else
    fselect("dmdemo")
endif
superbox(00,00,24,79,.t.,"²",.f.)
superbox(05,10,19,70,.f.,"",.t.)
superbox(07,11,07,69,.f.,"",.f.)
superbox(17,11,17,69,.f.,"",.f.)
say(06,28,"Schooner Sample Database")
say(18,23,"Highlight selection and press ENTER")
do while .t.
    *****
    * It is always a good idea to select your database whenever you
    * think it might possibly be unselected. In addition, make sure it
    * is open...
    *****
    if .not. is_open("dmdemo")
        open("dmdemo","",.T.,"dmdemo")
    else
        fselect("dmdemo")
    endif
    setcursor(.f.)
    setwrap(.t.)
    setmessage(23,"center")
    mvchoice=0
    prompt(09,11,"                     Add New Address                       ","   Add a new address to the database    ")
    prompt(10,11,"              Edit/Delete  Existing Address                ","Edit an existing address in the database")
    prompt(11,11,"                      Run a Report                         ","          Print a sample report         ")
    prompt(12,11,"                      Print Labels                         ","           Print sample labels          ")
    prompt(13,11,"                     Graphics  Demo                        ","    Display a sample graphics screen    ")
    prompt(14,11,"                 Programmable Text Editor                  ","    Try the programmable text editor    ")
    menuto("mvchoice")
    mvmainscrn=savescreen(0,0,24,79)
    if mvchoice=0
        exit
    endif
    if mvchoice=1
        do dmaddnew
    endif
    if mvchoice=2
        do dmbrow
    endif
    if mvchoice=3
        clearscrn()
        message("Printing report. Please wait...","off")
        setconsole(.f.)
        reportform("dmreport","ALL","dmreport.rpt")
        setconsole(.t.)
    endif
    if mvchoice=4
        clearscrn()
        message("Printing labels. Please wait...","off")
        setconsole(.f.)
        labelform("dmlabel","ALL","dmlabel.Lab")
        setconsole(.t.)
    endif
    if mvchoice=5
        do dmgraph
    endif
    if mvchoice=6
        do dmmemo
    endif
    if mvchoice>6
        message("That option is not available at this time.")
    endif
    mvmainscrn=restscreen(0,0,24,79,mvmainscrn)
enddo
message("Thank you for trying the SCHOONER sample database")
setcursor(.t.)
closefile()
quit




 



