*****
* helplist
* Function to control the help list box
*****
if mvparm1=1
    imgsay(01,54,14,15,-1,"","HELP EXAMPLE")
    *****
    * start up of imglistbox()
    * first screen of feature list file
    *****
    mvfeatures=memoread("helplist.txt")
    mvcount=mlcount(mvfeatures,31)
    mvscreen=iif(mvcount<=33,mvcount,33)
    mvline=0
    mvtoprow=2
    mvcol=42
    do while mvline<=mvscreen
        mvline=mvline+1
        mvtext=memoline(mvfeatures,31,mvline)
        imgsay(mvtoprow+mvline,mvcol,14,15,-1,"",mvtext)
    enddo
    return 1
endif
if mvparm1=2
    *****
    * Up arrow press. 
    *****
endif
if mvparm1=3
    *****
    * Down arrow pressed
    *****
endif
if mvparm1=4
    *****
    * Exit pressed
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