@Echo Off
cls
echo 様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様
echo  This batch file will produce a demo of Clipper manipulating Pkzip asper the
echo  information in readme documentation file. You need to have Blinker to link,
echo  and nanfor.lib for the link process. 
echo.
echo  PKZIP.EXE and PKUNZIP.EXE version 2.4g are required during the demo.
echo  The file PKZIP.CFG must reside in the same directory as the above files.
echo  I have provide a copy of pkzip.cfg configured to work with the demo. If it
echo  is not configured correctly the demo will NOT function.
echo.
echo WHEN READY
echo Press [N]o do not abort/link
echo Press [Y]es abort the link process
echo 様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様
echo 
echo.
echo  | pause >nul
blinker @linkfile
pknotes 1
echo.
