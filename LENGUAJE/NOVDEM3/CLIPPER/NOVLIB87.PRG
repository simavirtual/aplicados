
******************
* FSACCENABTST() *
******************

FUNCTION FSACCENABTST
  return( iif( FSACCVERGET() = 1, .T., .F. )  )


******************
* USRACCBALSET() *
******************

FUNCTION USRACCBALGET
  PARAMETERS cParam1
  nBalance = SETPRPVALGET(cParam1,1,"ACCOUNT_BALANCE",1)
return(nBalance)

FUNCTION USRACCBALSET
  PARAMETERS cParam1,nParam2
  nBalance = SETPRPVALSET(cParam1,1,"ACCOUNT_BALANCE",1,nParam2)
return( nBalance )


******************
* USRSETACCLIM() *
******************

FUNCTION USRACCLIMGET
  PARAMETERS cParam1
  nLimit = SETPRPVALGET(cParam1,1,"ACCOUNT_BALANCE",2)
return( nLimit )

FUNCTION USRACCLIMSET
  PARAMETERS cParam1,nParam2
  nLimit = SETPRPVALSET(cParam1,1,"ACCOUNT_BALANCE",2,nParam2)
return( nLimit )


*****************
* FSACCSRVADD() *
*****************

FUNCTION FSACCSRVADD
  PARAMETERS cParam1
  return( SETPRPIDADD(FSNMEGET(),4,cParam1,1,"ACCOUNT_SERVERS") )


*****************
* FSACCSRVDEL() *
*****************

FUNCTION FSACCSRVDEL
  PARAMETERS cParam1
  return( SETPRPIDDEL(FSNMEGET(),4,cParam1,1,"ACCOUNT_SERVERS") )


**********************
* USRNAMEGET( ExpN ) *
**********************

FUNCTION USRNMEGET
PARAMETERS nParam1
return(OBJNMEGET(nParam1))


FUNCTION USRNAMEGET
  PARAMETERS nParam1
  return( OBJNMEGET( nParam1 ) )


*********************
* GRPNMEGET( ExpN ) *
*********************

FUNCTION GRPNMEGET
  PARAMETERS nParam1
  return( OBJNMEGET( nParam1 ) )


*********************
* QUENMEGET( ExpN ) *
*********************

FUNCTION QUENMEGET
  PARAMETERS cParam1
  return( OBJNMEGET( cParam1 ) )


********************
* USRIDGET( ExpC ) *
********************

FUNCTION USRIDGET
  PARAMETERS cParam1
  return( OBJIDGET( cParam1, 1 ) )


********************
* GRPIDGET( ExpC ) *
********************

FUNCTION GRPIDGET
  PARAMETERS cParam1
  return( OBJIDGET( cParam1, 2 ) )


********************
* QUEIDGET( ExpC ) *
********************

FUNCTION QUEIDGET
  PARAMETERS cParam1
  return( OBJIDGET( cParam1, 3 ) )


*******************
* FSIDGET( ExpC ) *
*******************

FUNCTION FSIDGET
  PARAMETERS cParam1
  return( OBJIDGET( cParam1, 4 ) )


*******************************
* GRPUSRTST( ExpC1, ExpC2 )   *
*******************************

FUNCTION GRPUSRTST
  PARAMETERS cParam1, cParam2
  return( SETPRPIDTST( cParam2, 2, cParam1, 1, "GROUP_MEMBERS" ) )


*********************
* USRSUPTST( ExpC ) *
*********************

FUNCTION USRSUPTST
  PARAMETERS cParam1
  return( SETPRPIDTST( cParam1, 1, "SUPERVISOR", 1, "SECURITY_EQUALS" ) )


********************************
* USRCONOPRTST( ExpC1, ExpC2 ) *
********************************

FUNCTION USRCONOPRTST
  PARAMETERS cParam1
  return( SETPRPIDTST( FSNMEGET(), 4, cParam1, 1, "OPERATORS" ) )


*****************************
* QUEOPRTST( Expc1, Expc2 ) *
*****************************

FUNCTION QUEOPRTST
  PARAMETERS cParam1, cParam2
  return( SETPRPIDTST( cParam2, 3, cParam1, 1, "Q_OPERATORS" ) )


*****************************
* QUEUSRTST( Expc1, Expc2 ) *
*****************************

FUNCTION QUEUSRTST
  PARAMETERS cParam1, cParam2
  return( SETPRPIDTST( cParam2, 3, cParam1, 1, "Q_USERS" ) )


************************
* USRGRPMGRTST( expc ) *
************************

FUNCTION USRGRPMGRTST
  PARAMETERS cParam1
  return( SETPRPIDTST( "SUPERVISOR", 1, cParam1, 1, "MANAGERS" ) )


***************
* FSBINDOPN() *
***************

FUNCTION FSBINDOPN
  return( if(Bindery( .T. ), .T., .F.) )


*************
* FSBINDCLS *
*************

FUNCTION FSBINDCLS
  return( if(Bindery( .F. ), .T., .F.) )


********************
* FSUSRDEL( Expc ) *
********************

FUNCTION FSUSRDEL
  PARAMETERS cParam1
  return( FSOBJDEL( cParam1, 1 ) )


**********************
* FSGRPDEL( Expc )   *
**********************

FUNCTION FSGRPDEL
  PARAMETERS cParam1
  return( FSOBJDEL( cParam1, 2 ) )


*****************************
* USRNMECHG( Expc1, Expc2 ) *
*****************************

FUNCTION USRNMECHG
  PARAMETERS cParam1, cParam2
  return( OBJNMECHG( cParam1, cParam2, 1 ) )


*****************************
* GRPNMECHG( Expc1, Expc2 ) *
*****************************

FUNCTION GRPNMECHG
  PARAMETERS cParam1, cParam2
  return( OBJNMECHG( cParam1, cParam2, 2 ) )


********************************
* USRCONOPRSET( Expc1, Expc2 ) *
********************************

FUNCTION USRCONOPRSET
  PARAMETERS cParam1, cParam2
  return( SETPRPIDADD( cParam2, 4, cParam1, 1, "OPERATORS" ) )


**********************
* USRSUPSET( Expc1 ) *
**********************

FUNCTION USRSUPSET
  PARAMETERS cParam1
  return( SETPRPIDADD( cParam1, 1, "SUPERVISOR", 1, "SECURITY_EQUALS" ) )


*****************************
* QUEOPRADD( Expc1, Expc2 ) *
*****************************

FUNCTION QUEOPRADD
  PARAMETERS cParam1, cParam2
  return( SETPRPIDADD( cParam2, 3, cParam1, 1, "Q_OPERATORS" ) )


*****************************
* QUEUSRADD( Expc1, Expc2 ) *
*****************************

FUNCTION QUEUSRADD
  PARAMETERS cParam1, cParam2
  return( SETPRPIDADD( cParam2, 3, cParam1, 1, "Q_USERS" ) )


*****************************
* QUEGRPADD( Expc1, Expc2 ) *
*****************************

FUNCTION QUEGRPADD
  PARAMETERS cParam1, cParam2
  return( SETPRPIDADD( cParam2, 3, cParam1, 2, "Q_USERS" ) )


*************************
* USRGRPMGRSET( Expc1 ) *
*************************

FUNCTION USRGRPMGRSET
  PARAMETERS cParam1
  return( SETPRPIDADD( "SUPERVISOR", 1, cParam1, 1, "MANAGERS" ) )


********************************
* USRCONOPRDEL( Expc1, Expc2 ) *
********************************

FUNCTION USRCONOPRDEL
  PARAMETERS cParam1, cParam2
  return( SETPRPIDDEL( cParam2, 4, cParam1, 1, "OPERATORS" ) )


**********************
* USRSUPDEL( Expc1 ) *
**********************

FUNCTION USRSUPDEL
  PARAMETERS cParam1
  return( SETPRPIDDEL( cParam1, 1, "SUPERVISOR", 1, "SECURITY_EQUALS" ) )


******************************
* QUEOPRDEL( Expc1, Expc2 ) *
******************************

FUNCTION QUEOPRDEL
  PARAMETERS cParam1, cParam2
  return( SETPRPIDDEL( cParam2, 3, cParam1, 1, "Q_OPERATORS" ) )


******************************
* QUEUSRDEL( Expc1, Expc2 ) *
******************************

FUNCTION QUEUSRDEL
  PARAMETERS cParam1, cParam2
  return( SETPRPIDDEL( cParam2, 3, cParam1, 1, "Q_USERS" ) )


*****************************
* QUEGRPDEL( Expc1, Expc2 ) *
*****************************

FUNCTION QUEGRPDEL
  PARAMETERS cParam1, cParam2
  return( SETPRPIDDEL( cParam2, 3, cParam1, 2, "Q_USERS" ) )


*************************
* USRGRPMGRDEL( Expc1 ) *
*************************

FUNCTION USRGRPMGRDEL
  PARAMETERS cParam1
  return( SETPRPIDDEL( "SUPERVISOR", 1, cParam1, 1, "MANAGERS" ) )


***************************
* GRPUSRLST( Expc, ExpN ) *
***************************

FUNCTION GRPUSRLST
  PARAMETERS cParam1, nParam2
  return( OBJNMEGET(SETPRPVALGET( cParam1, 2, "GROUP_MEMBERS", nParam2 ) ) )


***************************
* USRGRPLST( Expc, ExpN ) *
***************************

FUNCTION USRGRPLST
  PARAMETERS cParam1, nParam2
  return( OBJNMEGET(SETPRPVALGET( cParam1, 1, "GROUPS_I'M_IN", nParam2 ) ) )


*****************************
* FSCONOPRLST( Expc, ExpN ) *
*****************************

FUNCTION FSCONOPRLST
  PARAMETERS cParam1, nParam2
  return( OBJNMEGET(SETPRPVALGET( cParam1, 4, "OPERATORS", nParam2 ) ) )


***************************
* QUEOPRLST( Expc, ExpN ) *
***************************

FUNCTION QUEOPRLST
  PARAMETERS cParam1, nParam2
  return( OBJNMEGET(SETPRPVALGET( cParam1, 3, "Q_OPERATORS", nParam2 ) ) )


***************************
* QUEUSRLST( Expc, ExpN ) *
***************************

FUNCTION QUEUSRLST
  PARAMETERS cParam1, nParam2
  return( OBJNMEGET(SETPRPVALGET( cParam1, 3, "Q_USERS", nParam2 ) ) )

***********************
* FSLSTGRPMGR( ExpN ) *
***********************

FUNCTION FSGRPMGRLST
  PARAMETERS nParam1
  return(OBJNMEGET(SETPRPVALGET("SUPERVISOR",1,"MANAGERS",nParam1)))

*************
* DIRUSRADD *
*************

FUNCTION DIRUSRADD
  PARAMETERS nParam1, cParam2, nParam3
  return( DIROBJADD( nParam1, cParam2, nParam3 ) )


*************
* DIRGRPADD *
*************

FUNCTION DIRGRPADD
  PARAMETERS nParam1, cParam2, nParam3
  return( DIROBJADD( nParam1, cParam2, nParam3 ) )


***************
* FILEADDUSER *
***************

FUNCTION FILEADDUSER
  PARAMETERS nParam1, cParam2, nParam3
  return( DIROBJADD( nParam1, cParam2, nParam3 ) )


**************
* FILEADDGRP *
**************

FUNCTION FILEADDGRP
  PARAMETERS nParam1, cParam2, nParam3
  return( DIROBJADD( nParam1, cParam2, nParam3 ) )


**************
* DIRUSRDEL *
**************

FUNCTION DIRUSRDEL
  PARAMETERS nParam1, cParam2
  return( DIROBJDEL( nParam1, cParam2 ) )


*************
* DIRGRPDEL *
*************

FUNCTION DIRGRPDEL
  PARAMETERS nParam1, cParam2
  return( DIROBJDEL( nParam1, cParam2 ) )


*************
* DRVCURGET *
*************

FUNCTION DRVCURGET
  return( DRVCURSET() )


*************
* DRVCURSET *
*************

FUNCTION DRVCURSET
  PARAMETERS nParam1
  return( DRVCURSET( nParam1 ) )

***************
* FileDelUser *
***************

FUNCTION FileDelUser
  PARAMETERS nParam1, cParam2
  return( DIROBJDEL( nParam1, cParam2 ) )


**************
* FileDelGrp *
**************

FUNCTION FileDelGrp
  PARAMETERS nParam1, cParam2
  return( DIROBJDEL( nParam1, cParam2 ) )


********************
* FSQUEDEL( Expc ) *
********************

FUNCTION FSQUEDEL
  PARAMETERS cParam1
  return( FSOBJDEL( cParam1, 3 ) )


*****************************
* QUENMECHG( Expc1, Expc2 ) *
*****************************

FUNCTION QUENMECHG
  PARAMETERS cParam1, cParam2
  return( OBJNMECHG( cParam1, cParam2, 3 ) )


****************************
* PSOPRADD( Expc1, Expc2 ) *
****************************

FUNCTION PSOPRADD
  PARAMETERS cParam1, cParam2
  return( SETPRPIDADD( cParam2, 7, cParam1, 1, "PS_OPERATORS" ) )


****************************
* PSUSRADD( Expc1, Expc2 ) *
****************************

FUNCTION PSUSRADD
  PARAMETERS cParam1, cParam2
  return( SETPRPIDADD( cParam2, 7, cParam1, 1, "PS_USERS" ) )


****************************
* PSOPRDEL( Expc1, Expc2 ) *
****************************

FUNCTION PSOPRDEL
  PARAMETERS cParam1, cParam2
  return( SETPRPIDDEL( cParam2, 7, cParam1, 1, "PS_OPERATORS" ) )


****************************
* PSUSRDEL( Expc1, Expc2 ) *
****************************

FUNCTION PSUSRDEL
  PARAMETERS cParam1, cParam2
  return( SETPRPIDDEL( cParam2, 7, cParam1, 1, "PS_USERS" ) )


**************************
* PSOPRLST( Expc, ExpN ) *
**************************

FUNCTION PSOPRLST
  PARAMETERS cParam1, nParam2
  return( OBJNMEGET(SETPRPIDTST( cParam1, 4, "PS_OPERATORS", nParam2 ), -1 ) )


****************************
* PSUSRLST( Expc, ExpN )    *
****************************

FUNCTION PSUSRLST
  PARAMETERS cParam1, nParam2
  return( OBJNMEGET(SETPRPIDTST( cParam1, 4, "PS_USERS", nParam2 ), -1 ) )

