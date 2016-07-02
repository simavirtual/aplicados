*****
* Handle special print options
*****
superbox(09,10,13,70,.f.,"",.t.)
setcursor(.f.)
setwrap(.t.)
setmessage(23,"center")
mvprint=0
prompt(10,11,"               Print ALL commands/functions               ","            ALL documentation           ")
prompt(11,11,"                Print one command/function                ","     Print selected command/function    ")
prompt(12,11,"               Print from a command/function              "," ALL docs from selected command/function")
menuto("mvprint")
    if mvprint=1
        mvkey=message("The documentation will print to LPT1: on standard 8.5 x 11 paper.","   ESC to cancel   Any key to continue")
        if mvkey=27
            return
        endif
        message("ESC to cancel {Effective between documents}...","OFF")
        *****
        * Open userhelp and begin loading and printing
        *****
        if .not. is_open("userhelp")
            open("userhelp","userhelp",.t.,"userhelp")
        else
            select("userhelp")
        endif
        jumpto("top")
        setconsole(.f.)
        setoutput("lpt1")
        setprint(.t.)
        setmargin("7")
        mvcount=1        
        setexit(.t.)
        do while .not. userhelp->(eof())
            mvcount=1
            do while mvcount <= mlcount(userhelp->text,65)
                mvtext=memoline(userhelp->text,65,mvcount)
                output("mvtext")
                mvcount=mvcount+1
            enddo
            eject
            if inkey(5)=27
                message("Printing cancelled...","OFF")
                cleartype()
                return
            endif
            skipto(1,"userhelp")
        enddo
        setexit(.f.)
        setprint(.f.)
        setconsole(.t.)
    endif
    if mvprint=2
        *****
        * Open userhelp and begin loading and printing
        *****
        if .not. is_open("userhelp")
            open("userhelp","userhelp",.t.,"userhelp")
        else
            select("userhelp")
        endif
        superbox(12,12,20,60,.f.,"",.t.)
        say(20,22,"ENTER - Select   ESC - Exit")
        dbedit(13,13,19,59)
        if lastkey()=13
            *****
            * Print this record
            *****
            setconsole(.f.)
            setoutput("lpt1")
            setprint(.t.)
            setmargin("7")
            mvcount=1        
            setexit(.t.)
            mvcount=1
            do while mvcount <= mlcount(userhelp->text,65)
                mvtext=memoline(userhelp->text,65,mvcount)
                output("mvtext")
                mvcount=mvcount+1
            enddo
            eject
            setexit(.f.)
            setprint(.f.)
            setconsole(.t.)
        endif
    endif
    if mvprint=3
        *****
        * Open userhelp and begin loading and printing
        *****
        if .not. is_open("userhelp")
            open("userhelp","userhelp",.t.,"userhelp")
        else
            select("userhelp")
        endif
        superbox(12,12,20,60,.f.,"",.t.)
        say(20,22,"ENTER - Select   ESC - Exit")
        dbedit(13,13,19,59)
        if lastkey()=13
            *****
            * Print from this record
            *****
            mvkey=message("The documentation will print to LPT1: on standard 8.5 x 11 paper.","   ESC to cancel   Any key to continue")
            if mvkey=27
                return
            endif
            message("ESC to cancel {Effective between documents}...","OFF")
            setconsole(.f.)
            setoutput("lpt1")
            setprint(.t.)
            setmargin("7")
            mvcount=1        
            setexit(.t.)
            do while .not. userhelp->(eof())
                mvcount=1
                do while mvcount <= mlcount(userhelp->text,65)
                    mvtext=memoline(userhelp->text,65,mvcount)
                    output("mvtext")
                    mvcount=mvcount+1
                enddo
                eject
                if inkey(5)=27
                    message("Printing cancelled...","OFF")
                    cleartype()
                    return
                endif
                skipto(1,"userhelp")
            enddo
            eject
            setexit(.f.)
            setprint(.f.)
            setconsole(.t.)
        endif
    endif
    return
