*****
* Demo version 2.00 of Schooner
*****
clearscrn()
superbox(0,0,24,79,.t.,"²",.f.)
mvcontinue=32
if empty(alltrim(iconpath))
    mvicomsg="This demo should have the ICONPATH DOS environment variable set. To do this select (E)xit below and at the DOS prompt type:"
    mvicomsg=mvicomsg+chr(13)+chr(10)+chr(13)+chr(10)+"    SET ICONPATH=path to schooner demo"+chr(13)+chr(10)+chr(13)+chr(10) 
    mvicomsg=mvicomsg+"Where the path points to the directory that "
    mvicomsg=mvicomsg+"is running the Schooner version 2.00 demo."
    mvcontinue=message(mvicomsg,"           (E)xit/(C)ontinue")
    if upper(chr(mvcontinue))="E"
        quit
    endif
endif
mvcontinue=32
mvcontinue=message("The Schooner Version 2.00 demo requires a mouse and a VGA graphics system. Do you wish to continue?","              (Y)es/(N)o")
if upper(chr(mvcontinue))="N"
    quit
endif
graphmode(2)
imgpcx("v3title.pcx",0,0,"flash")
imgiconbox(425,215,470,260,7,"",8,"raised")
imgpcx("start1.pcx",428,218,"scroll")
imgiconbox(425,260,470,305,7,"",8,"raised")
imgpcx("feature1.pcx",428,263,"scroll")
imgiconbox(425,305,470,350,7,"",8,"raised")
imgpcx("order1.pcx",428,308,"scroll")
imgiconbox(425,350,470,395,7,"",8,"raised")
imgpcx("exit1.pcx",428,353,"scroll")
msreset()

*****
* Display intro screen
*****
imgsave(100,50,540,430,380,"intro")
mv_udfname="intlist"
imglistbox(100,50,540,430,2,1,15,8,8,0) 
mscrsoroff()
imgrestore(100,50,540,430,380,"intro",0) 
mscrsoron()

do while .t.
    *****
    * Main control loop
    *****
    mscrsoron()
    mswait(100)
    mscrsoroff()
    if msinside(425,215,470,260)  
        imgiconbox(425,215,470,260,7,"",8,"etched")
        imgiconbox(425,215,470,260,7,"",8,"raised")
        imgsave(0,0,639,479,479,"relstart")
        do relstart
        imgrestore(0,0,639,479,479,"relstart",0)
        loop
    endif
    if msinside(425,260,470,305) 
        imgiconbox(425,260,470,305,7,"",8,"etched")
        imgiconbox(425,260,470,305,7,"",8,"raised")
        do feature
        loop
    endif
    if msinside(425,305,470,350) 
        imgiconbox(425,305,470,350,7,"",8,"etched")
        imgiconbox(425,305,470,350,7,"",8,"raised")
        do order
        loop
    endif
    if msinside(425,350,470,395) 
        imgiconbox(425,350,470,395,7,"",8,"etched")
        imgiconbox(425,350,470,395,7,"",8,"raised")
        exit
    endif
enddo
quit
