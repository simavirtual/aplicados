*****
* Intlist
* Function to control the intro list box
* You may note the similarity to the FTRLIST function. It was quickly
* copied and adapted.
*****
if mvparm1=1
    imgsay(04,34,14,15,-1,"","INTRODUCTION")
    *****
    * start up of imglistbox()
    * first screen of intro list file
    *****
    mvfeatures=memoread("intro.txt")
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
    return 1
endif
if mvparm1=3
    *****
    * Down arrow pressed
    *****
    return 1
endif
if mvparm1=4
    *****
    * Exit
    *****
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