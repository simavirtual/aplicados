*****
* Real Estate demo system
* Note: The palette may have changed since the last procedure. Be
* aware that some of the color numbers may be different from other 
* procedures. 
*****
*****
* Open real estate file and jump to top
*****
if .not. is_open("property")
    open("property","",.t.,"property")
else
    fselect("property")
endif
jumpto("top")
*****
* Set graphics and build screen
*****
graphmode(2)
imgpcx("wl1vga16.pcx",0,0,"flash")
graphcolor(1)
graphbox("SOLID",5,5,634,35)
imgsay(01,21,14,15,-1,"","SCHOONER Real Estate Brokerage Services")
graphcolor(8)
imgiconbox(05,30,634,66,15,7,8,"etched")

imgiconbox(09,34,73,62,15,7,8,"raised")
imgsay(03,03,14,1,-1,"","FILE")

imgiconbox(75,34,139,62,15,7,8,"raised")
imgsay(03,10,14,1,-1,"","OPTIONS")

imgiconbox(141,34,205,62,15,7,8,"raised")
imgsay(03,19,14,1,-1,"","HELP?")

imgiconbox(250,34,314,62,15,7,8,"raised")
imgsay(03,33,14,1,-1,""," <<  ")

imgiconbox(316,34,380,62,15,7,8,"raised")
imgsay(03,41,14,1,-1,""," >>  ")

imgiconbox(320,70,633,284,15,7,8,"raised")
imgiconbox(05,261,318,475,15,7,8,"raised")

*****
* Define menu arrays
*****
public mvfile[2]
mvfile[1]="Print "
mvfile[2]="End Demo"

public mvoptions[1]
mvoptions[1]="Home List"

public mvhomelist[property->(reccount())+1]

do while .t.
    mvchoice=1
    mvrecno=1
    mvoldrecno=1
    *****
    * Display home exterior & plan
    *****
    imgpcx(alltrim(property->imgview),325,75,"scroll")
    imgpcx(alltrim(property->imgplan),10,266,"scroll")

    *****
    * Display home description
    *****
    imgiconbox(05,70,318,259,15,7,8,"etched")
    imgsay(06,09,14,1,-1,"","Description "+property->name)
    mvdescript=property->descript
    mvcount=mlcount(mvdescript,35)
    mvscreen=iif(mvcount<=15,mvcount,15)
    mvline=0
    mvtoprow=6
    do while mvline<=mvscreen
        mvline=mvline+1
        mvtext=memoline(mvdescript,35,mvline)
        imgsay(mvtoprow+mvline,3,14,1,-1,"",mvtext)
    enddo

    imgiconbox(320,286,633,475,15,7,8,"etched")
    imgsay(21,53,14,1,-1,"","Specifications")
    imgsay(23,43,14,1,-1,"","    Area: "+alltrim(property->area)+" Sq Feet")
    imgsay(25,43,14,1,-1,"","   Rooms: "+alltrim(property->rooms)+" Bedrooms")
    imgsay(27,43,14,1,-1,"","   Baths: "+property->baths)
    imgsay(29,43,14,1,-1,"","Lot Size: "+alltrim(property->lotsize)+" Sq Feet")
    imgsay(31,43,14,1,-1,"","Township: "+property->township)

    do while .t.    
        *****
        * Process mouse event
        *****
        mscrsoron()
        mswait(100)
        mscrsoroff()
        if msinside(09,34,73,62)  
            ***** FILE MENU *****
            imgiconbox(09,34,73,62,15,"",8,"etched")        
            imgiconbox(09,34,73,62,15,"",8,"raised")
            imgsave(09,63,100,116,53,"filemenu")
            mvchoice=imgmenubox(09,63,100,112,"mvfile",14,15,7,0,100)
            mscrsoroff()
            if mvchoice=0
                imgrestore(09,63,100,116,53,"filemenu",0)
                mvchoice=1
                loop
            endif
            if upper(alltrim(mvfile[mvchoice]))="PRINT"
                imgrestore(09,63,100,116,53,"filemenu",0)
                *****
                * Print the screen
                *****
                ***** Confirm box *****
                imgsave(220,140,420,240,10,"relprn")
                imgiconbox(220,140,420,240,7,15,0,"raised")
                imgsay(11,29,14,0,-1,""," Printing  screen  to")
                imgsay(12,29,14,0,-1,""," HP Laserjet on LPT1:")
                imgiconbox(240,205,304,229,7,8,0,"raised")
                imgiconbox(336,205,400,229,7,8,0,"raised")
                imgsay(15,31,14,14,-1,"","  OK  ")
                imgsay(15,43,14,14,-1,"","CANCEL")
                mscrsoron()
                mswait()
                mscrsoroff()
                if msinside(336,205,400,229) 
                    *****
                    * Cancel print
                    *****
                    imgiconbox(336,205,400,229,7,"",0,"etched")
                    imgiconbox(336,205,400,229,7,"",0,"raised")
                    imgrestore(220,140,420,240,10,"relprn",0)
                    loop
                endif
                if msinside(240,205,304,229) 
                    *****
                    * Print
                    *****
                    imgiconbox(240,205,304,229,7,"",0,"etched")
                    imgiconbox(240,205,304,229,7,"",0,"raised")
                    ***** swap to hplaserjet screen print driver ***** 
                    imgrestore(220,140,420,240,10,"relprn",0)
                    mvswap="hpljprn 300 1 1 6 4"
                    swap(mvswap)
                endif
            endif
            if upper(alltrim(mvfile[mvchoice]))="END DEMO"
                imgrestore(09,63,100,116,53,"filemenu",0)
                return
            endif
        endif
        if msinside(75,34,139,62) 
            ***** OPTIONS MENU *****
            imgiconbox(75,34,139,62,15,"",8,"etched")
            imgiconbox(75,34,139,62,15,"",8,"raised")
            imgsave(75,63,167,105,42,"optmenu")
            mvchoice=imgmenubox(75,63,167,91,"mvoptions",14,15,7,0,100)
            mscrsoroff()
            if mvchoice=0
                imgrestore(75,63,167,105,42,"optmenu",0)
                mvchoice=1
                loop
            endif
            if upper(alltrim(mvoptions[mvchoice]))="HOME LIST"
                fselect("property")
                imgrestore(75,63,167,105,42,"optmenu",0)
                imgsave(100,50,540,270,220,"homelist")
                mvoldrecno=recno()
                mv_udfname="dbflist"
                imglistbox(100,50,540,270,2,1,15,8,8,0) 
                mscrsoroff()
                imgrestore(100,50,540,270,220,"homelist",0) 
                if empty(mvrecno) .or. mvrecno=mvoldrecno
                    jumpto(mvoldrecno)
                    mscrsoron()
                else
                    exit
                endif
            endif
        endif
        if msinside(141,34,205,62) 
            ***** HELP MENU *****
            imgiconbox(141,34,205,62,15,"",8,"etched")
            imgiconbox(141,34,205,62,15,"",8,"raised")
            imgsave(320,10,639,470,460,"helpscrn")
            mv_udfname="helplist"
            imglistbox(320,10,639,470,2,1,15,8,8,0) 
            mscrsoroff()
            imgrestore(320,10,639,470,460,"helpscrn",0) 
        endif
        if msinside(250,34,314,62) 
            ***** BACK ARROW *****
            imgiconbox(250,34,314,62,15,"",8,"etched")
            imgiconbox(250,34,314,62,15,"",8,"raised")
            skipto(-1,"property")
            exit
        endif
        if msinside(316,34,380,62) 
            ***** FORWARD ARROW *****
            imgiconbox(316,34,380,62,15,"",8,"etched")
            imgiconbox(316,34,380,62,15,"",8,"raised")
            skipto(1,"property")
            exit
        endif
    enddo
enddo
return
