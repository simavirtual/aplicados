*****
* Readme.prg/run file to display the introductory docs & general docs
* for Schooner
*****
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
superbox(00,00,24,79,.t.,"²",.f.)
superbox(05,10,19,70,.f.,"",.t.)
superbox(07,11,07,69,.f.,"",.f.)
superbox(17,11,17,69,.f.,"",.f.)
mvkey=0
say(06,29,"Schooner Documentation")
say(18,16,"Highlight selection and press ENTER. ESC to exit.")
do while .t.
    setcursor(.f.)
    setwrap(.t.)
    setmessage(23,"center")
    mvchoice=0
    prompt(10,11,"              Schooner README Documentation                ","        Introduction to Schooner        ")
    prompt(11,11,"             Schooner General  Documentation               ","       General Schooner  Concepts       ")
    prompt(12,11,"           Print README & General Documentation            ","                                        ") 
    prompt(13,11,"       Print Complete Command/Function Documentation       ","    Entire help system documentation    ")
    menuto("mvchoice")
    mvmainscrn=savescreen(0,0,24,79)
    if mvchoice=0
        exit
    endif
    if mvchoice=1
        superbox(00,00,24,79,.t.,"²",.f.)
        superbox(03,03,21,76,.f.,"",.t.)
        say(03,35,"README.DOC")
        say(21,23,"Cursor keys to scroll. ESC to exit.")
        setcursor(.t.)
        memoedit(memoread("readme.doc"),04,04,20,75,.f.)
        setcursor(.f.)
    endif
    if mvchoice=2
        superbox(00,00,24,79,.t.,"²",.f.)
        superbox(03,03,21,76,.f.,"",.t.)
        say(03,35,"GENERAL.DOC")
        say(21,23,"Cursor keys to scroll. ESC to exit.")
        setcursor(.t.)
        memoedit(memoread("general.doc"),04,04,20,75,.f.)
        setcursor(.f.)
    endif
    if mvchoice=3
        superbox(00,00,24,79,.t.,"²",.f.)
        mvkey=message("The documentation will print to LPT1: on standard 8.5 x 11 paper.","   ESC to cancel   Any key to continue")
        if mvkey=27
            mvmainscrn=restscreen(0,0,24,79,mvmainscrn)
            loop
        endif
        setconsole(.f.)
        setoutput("lpt1")
        setprint(.t.)
        mvtext=memoread("readme.doc")
        output("mvtext")
        eject
        mvtext=memoread("general.doc")
        output("mvtext")
        eject
        setprint(.f.)
        setconsole(.t.)        
    endif
    if mvchoice=4
        do readprn
    endif
    mvmainscrn=restscreen(0,0,24,79,mvmainscrn)
enddo
message("Thank you for reading the SCHOONER documentation.")
setcursor(.t.)
quit
