*****
* Create order entry screen and print to printer
*****
imgsave(10,10,630,470,46,"order")
imgiconbox(10,10,630,470,7,8,0,"raised")
imgsay(4,24,14,14,-1,"","SCHOONER VERSION 2.00 ORDER FORM")
imgsay(7,4,14,14,-1,"","Schooner Version 2.00 is available directly from Jonathan Cook at the")
imgsay(8,4,14,14,-1,"","following address:")
imgsay(10,24,14,14,-1,"","Jonathan Cook")
imgsay(11,24,14,14,-1,"","7034 N. Cedar Ave. #108")
imgsay(12,24,14,14,-1,"","Fresno, CA 93720")
imgsay(14,4,14,14,-1,"","Please complete the following form and mail it with a check for")
imgsay(15,4,14,14,-1,"","$39.95 in U.S. funds made out to Jonathan Cook.")

mvname=space(45)
mvcompname=space(45)
mvaddr=space(45)
mvctstzip=space(45)
mvprof=space(38)
mvfind=space(34)

imgiconbox(27,233,613,327,7,8,0,"etched")
imgsay(17,8,14,14,-1,"","            Name:")
imgsay(18,8,14,14,-1,"","    Company Name:")
imgsay(19,8,14,14,-1,"","         Address:")
imgsay(20,8,14,14,-1,"","City, State, Zip:")
imgsay(21,8,14,14,-1,"","What is your profession:")
imgsay(22,8,14,14,-1,"","Where did you find Schooner:")

imgsay(17,26,14,14,7,"",mvname)
imgsay(18,26,14,14,7,"",mvcompname)
imgsay(19,26,14,14,7,"",mvaddr)
imgsay(20,26,14,14,7,"",mvctstzip)
imgsay(21,33,14,14,7,"",mvprof)
imgsay(22,37,14,14,7,"",mvfind)

imgiconbox(144,385,208,409,7,8,0,"raised")
imgiconbox(292,385,356,409,7,8,0,"raised")
imgiconbox(430,385,494,409,7,8,0,"raised")

imgsay(28,20,14,14,-1,"","Edit")
imgsay(28,38,14,14,-1,"","Print")
imgsay(28,55,14,14,-1,"","Cancel")

do while .t.
    mscrsoron()
    mswait(100)
    mscrsoroff()
    if msinside(144,385,208,409) 
        *****
        * Edit the form
        *****
        imgiconbox(144,385,208,409,7,"",0,"etched")
        imgiconbox(144,385,208,409,7,"",0,"raised")
        imgget(17,26,14,14,7,"","mvname")
        imgget(18,26,14,14,7,"","mvcompname")
        imgget(19,26,14,14,7,"","mvaddr")
        imgget(20,26,14,14,7,"","mvctstzip")
        imgget(21,33,14,14,7,"","mvprof")
        imgget(22,37,14,14,7,"","mvfind")
    endif
    if msinside(292,385,356,409) 
        *****
        * Print the form
        *****
        imgiconbox(292,385,356,409,7,"",0,"etched")
        imgiconbox(292,385,356,409,7,"",0,"raised")
        ***** Confirm box *****
        imgsave(220,140,420,240,10,"orderprn")
        imgiconbox(220,140,420,240,7,15,0,"raised")
        imgsay(11,29,14,0,-1,"","Printing order form to")
        imgsay(12,29,14,0,-1,"","        LPT1:         ")
        imgiconbox(240,205,304,229,7,8,0,"raised")
        imgiconbox(336,205,400,229,7,8,0,"raised")
        imgsay(15,31,14,14,-1,"","  OK  ")
        imgsay(15,43,14,14,-1,"","CANCEL")
        mscrsoron()
        mswait(100)
        mscrsoroff()
        if msinside(336,205,400,229) 
            *****
            * Cancel print
            *****
            imgiconbox(336,205,400,229,7,"",0,"etched")
            imgiconbox(336,205,400,229,7,"",0,"raised")
            imgrestore(220,140,420,240,10,"orderprn",0)
            loop
        endif
        if msinside(240,205,304,229) 
            *****
            * Print
            *****
            imgiconbox(240,205,304,229,7,"",0,"etched")
            imgiconbox(240,205,304,229,7,"",0,"raised")
            setconsole(.f.)
            setoutput("lpt1")
            setprint(.t.)
            setmargin("10")
            output("'---------------------------------------------------------------'")
            output("' '")
            output("'                     Schooner Version 2.00'")
            output("'                          Order Form      '")
            output("' '")
            output("'---------------------------------------------------------------'")
            output("'Please find enclosed a check made out to Jonathan Cook for the'")
            output("'purchase/registration of Schooner Version 2.00:'") 
            output("' '")
            output("'My order information is as follows:'")
            output("' '")
            setmargin("15")
            output("mvname")
            output("mvcompname")
            output("mvaddr")
            output("mvctstzip")
            output("mvprof")
            output("mvfind")
            output("' '")
            setmargin("10")
            output("'---------------------------------------------------------------'")
            eject
            setprint(.f.)
            setconsole(.t.)
            imgrestore(220,140,420,240,10,"orderprn",0)
        endif
    endif
    if msinside(430,385,494,409) 
        *****
        * cancel
        *****
        imgiconbox(430,385,494,409,7,"",0,"etched")
        imgiconbox(430,385,494,409,7,"",0,"raised")
        exit
    endif
enddo
imgrestore(10,10,630,470,46,"order",0)
return
