*****
* dbflist
* Function to control the home list box
*****
if mvparm1=1
    imgsay(04,31,14,15,-1,"","FEATURED HOME LIST")
    imgsay(06,14,14,15,-1,"","NAME         LOTSIZE TOWNSHIP")
    imgsay(07,14,14,15,-1,"","----         ------- -------------------------")
    *****
    * start up of imglistbox()
    * first screen of feature list file
    *****
    if .not. is_open("property")
        open("property","",.t.,"property")
    else
        fselect("property")
    endif
    jumpto("top")
    mvcount=reccount()
    mvscreen=iif(mvcount<=10,mvcount,10)
    mvline=0
    mvtoprow=7
    mvlastline=16
    mvcol=14
    do while mvline<=mvscreen
        mvline=mvline+1
        mvtext=property->name+" "+property->lotsize+"  "+property->township
        imgsay(mvtoprow+mvline,mvcol,14,15,-1,"",mvtext)
        mvhomelist[mvline]=recno()
        skipto(1)
    enddo
    mvline=mvline-1
    return 1
endif
if mvparm1=2
    *****
    * Up arrow press
    *****
    fselect("property")
    mvline=1
    skipto(-20)
    do while mvline<=11 .and. (.not. property->(eof()))
        mvtext=property->name+" "+property->lotsize+"  "+property->township
        imgsay(mvtoprow+mvline,mvcol,14,15,1,"",space(50))        
        imgsay(mvtoprow+mvline,mvcol,14,15,-1,"",mvtext)
        mvhomelist[mvline]=recno()
        skipto(1)
        mvline=mvline+1
    enddo
    return 1
endif
if mvparm1=3
    *****
    * Down arrow pressed
    *****
    fselect("property")
    mvline=1
    do while mvline<=11
        if .not. property->(eof())
            mvtext=property->name+" "+property->lotsize+"  "+property->township
            mvhomelist[mvline]=recno()
            skipto(1)
        else
            mvtext=""
            if mvline<=len(mvhomelist)
                mvhomelist[mvline]=""
            endif
        endif
        imgsay(mvtoprow+mvline,mvcol,14,15,1,"",space(50))        
        imgsay(mvtoprow+mvline,mvcol,14,15,-1,"",mvtext)
        mvline=mvline+1
    enddo
    return 1
endif
if mvparm1=4
    return 0
endif
if mvparm1=5
    *****
    * Select Item
    *****
    fselect("property")
    mvdataline=(int((msrow+14-1)/14)-1)*14
    mvitem=(int((msrow+14-1)/14)-1)-mvtoprow
    if mvitem<1 .or. mvitem>len(mvhomelist)
        return 1
    endif
    mvrecno=mvhomelist[mvitem]
    if empty(mvrecno)
        return 1
    endif
    jumpto(mvrecno)
    mvtext=property->name+" "+property->lotsize+"  "+property->township    
    if empty(mvtext)
        return 1
    endif
    graphcolor(7)
    graphbox("solid",102,mvdataline,517,mvdataline+14)
    imgsay(mvtoprow+mvitem,mvcol,14,15,-1,"",mvtext)
    return 0
endif
return 1
