*****
* ftrlist
* Function to control the feature list box
*****
if mvparm1=1
    imgsay(04,31,14,15,-1,"","FEATURE DESCRIPTION")
    *****
    * start up of imglistbox()
    * first screen of feature list file
    *****
    mvfeatures=memoread("features.txt")
    mvcount=mlcount(mvfeatures,50)
    mvscreen=iif(mvcount<=23,mvcount,23)
    mvline=0
    mvtoprow=5
    mvlastline=29
    mvcol=14
    do while mvline<=mvscreen
        mvline=mvline+1
        mvtext=memoline(mvfeatures,50,mvline)
        imgsay(mvtoprow+mvline,mvcol,14,15,-1,"",mvtext)
    enddo
    return 1
endif
if mvparm1=2
    *****
    * Up arrow press
    *****
    if mvline>=mvscreen
        mvtext=memoline(mvfeatures,50,mvline-mvscreen-1)
        imgscroll("down",14,6,14,29,63,1)
        imgsay(mvtoprow+1,mvcol,14,15,-1,"",mvtext)
        mvline=mvline-1
    endif
    return 1
endif
if mvparm1=3
    *****
    * Down arrow pressed
    *****
    if mvline<=mvcount
        mvline=mvline+1
        mvtext=memoline(mvfeatures,50,mvline)
        imgscroll("up",14,6,14,29,63,1)
        imgsay(mvlastline,mvcol,14,15,-1,"",mvtext)
    endif
    return 1
endif
if mvparm1=4
    return 0
endif
if mvparm1=5
    *****
    * button press inside-ignore
    *****
    return 1
endif
return 1
