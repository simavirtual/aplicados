/*                       SIMA - CARTERA ACADEMICA
		     DETALLES DE INSTALACION DE EMPRESAS

**************************************************************************
* NOMBRE DEL PROGRAMA......: INSTALL.DAT                                 *
* TITULO DEL PROGRAMA......: DETALLES DE INSTALACION                     *
* PROGRAMAS QUE LO INVOCAN.: El programa principal                       *
* PROGRAMAS QUE INVOCA.....: Ninguno                                     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 26/96 LUN A
       Colombia, Bucaramanga        INICIO: 10:20 AM   FEB 26/96 LUN

REQUERIMIENTOS:

1- Para que el programa funcione se debe invocar utilizando la clausula
   #INCLUDE dentro de la funcion que lo va a utilizar.

OBJETIVOS:

1- Declara todas las variables que contiene los detalles de instalaci¢n
   de cada una de las empresas a las cuales se le ha instalado el sistema.

2- El objetivo principal es controlar los detalles de instalaci¢n de
   cada empresa.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

*>>>>DECLARACION DE EMPRESAS INSTALADAS
/*
*      FECHA DE INSTALACION: SEP 28/2000 HORA: 10:00 AM
*      RECIBO Y VISTO BUENO: ALEJO.
*                                                                |         |
       LOCAL cEmpPal := 'COLEGIO DE PRUEBA XYZ'
       LOCAL cNitEmp := '860009985-0'
       LOCAL cNomEmp := 'COLEGIO DE PRUEBA XYZ'
       LOCAL cNomSec := ''                  // Nombre Secundario
       LOCAL cMaeAlu := 'JARPRIBTO'         // Maestros habilitados
       LOCAL cJornad := 'DNMT'              // Jornadas habilitadas
       LOCAL lShared := .T.                 // .T. Sistema Compartido
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Sin Proteci¢n Inicial 2=>Con Proteci¢n Inicial
       LOCAL lNovell := .T.                 // .T. Red Novell .F. Red Win NT
       LOCAL cPasSis := 'ELLAS'             // PassWord Creaci¢n usuarios
       LOCAL lIntUno := .T.                 // Primera Integraci¢n
       LOCAL lIntDos := .T.                 // Segunda Integraci¢n
       LOCAL lIntTre := .F.                 // Tercera Integraci¢n
       LOCAL lIntCua := .F.                 // Cuarta Integraci¢n
       LOCAL lPrueba := .T.                 // Prueba de Paramentros
       LOCAL aKeySis := {{83951702,23},;    // 151146918
			 {cNomEmp,487023780},;
			 {cMaeAlu,151152049},;
			 {'System',419845542}}
*/

/*
*      FECHA DE ENTREGA    : JUL 04/2001 HORA: 04:30 PM
*      RECIBO Y VISTO BUENO: ING NESTOR ALEJANDRO PINZON. SISTEMAS

       LOCAL cEmpPal := 'COLEGIO ABC'
       LOCAL cNitEmp := '999999999-9'
       LOCAL cNomEmp := 'COLEGIO ABC'
       LOCAL cNomSec := ''                  // Nombre Secundario
       LOCAL cCodCol := 'COLSAN0010'        // C¢digo del Colegio
       LOCAL cMaeAlu := 'PRIBTO'            // Maestros habilitados OJO JAR
       LOCAL cJornad := 'D'                 // Jornadas habilitadas
       LOCAL lShared := .F.                 // .T. Sistema Compartido
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Con Proteci¢n Inicial 2=>Sin Proteci¢n Inicial
       LOCAL lNovell := .F.                 // .T. Red Novell .F. Red Win NT
       LOCAL cPasSis := 'ELLAS'             // PassWord Creaci¢n usuarios
       LOCAL lIntUno := .T.                 // Primera Integraci¢n
       LOCAL lIntDos := .T.                 // Segunda Integraci¢n
       LOCAL lIntTre := .F.                 // Tercera Integraci¢n
       LOCAL lIntCua := .F.                 // Cuarta Integraci¢n
       LOCAL lPrueba := .F.                 // Prueba de Paramentros
       LOCAL aKeySis := {{201553870,23},;   // Pendientes las claves
			 {cNomEmp,554226449},;
			 {cMaeAlu,151152049},;
			 {'System',419845542}}
*/


*      FECHA DE INSTALACION: FEB 22/96 HORA: 10:00 AM
*      RECIBO Y VISTO BUENO: ZORAIDA. PAGADORA
*                       '123456789012345678901234567890123456789012'
       LOCAL cEmpPal := 'CONGREGACION DE LOS HNOS DE LAS ESCUELAS CRISTIANAS'
       LOCAL cNitEmp := '860009985-0'
       LOCAL cNomEmp := 'COLEGIO LA SALLE. BUCARAMANGA'
       LOCAL cNomSec := ''                  // Nombre Secundario
       LOCAL cCodCol := 'COLSAN0011'        // C¢digo del Colegio
       LOCAL cMaeAlu := 'PRIBTO'            // Maestros habilitados
       LOCAL cJornad := 'D'                 // Jornadas habilitadas
       LOCAL lShared := .T.                 // .T. Sistema Compartido
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Sin Proteci¢n Inicial 2=>Con Proteci¢n Inicial
       LOCAL lNovell := .T.                 // .T. Red Novell .F. Red Win NT
       LOCAL cPasSis := 'ELLAS'             // PassWord Creaci¢n usuarios
       LOCAL lIntUno := .T.                 // Primera Integraci¢n
       LOCAL lIntDos := .T.                 // Segunda Integraci¢n
       LOCAL lIntTre := .F.                 // Tercera Integraci¢n
       LOCAL lIntCua := .F.                 // Cuarta Integraci¢n
       LOCAL lPrueba := .F.                 // Prueba de Paramentros
       LOCAL aKeySis := {{83951702,23},;    // 151146918
			 {cNomEmp,487023780},;
			 {cMaeAlu,151152049},;
			 {'System',419845542}}


/*
*      FECHA DE INSTALACION: FEB 29/96 HORA: 02:30 PM
*      RECIBO Y VISTO BUENO: DORIS. SISTEMAS
*                       '123456789012345678901234567890123456789012'
       LOCAL cEmpPal := 'COMUNIDAD FRANCISCANA'
       LOCAL cNitEmp := '860020342-1'
       LOCAL cNomEmp := 'COLEGIO VIRREY SOLIS. BUCARAMANGA'
       LOCAL cNomSec := ''                  // Nombre Secundario
       LOCAL cCodCol := 'COLSAN0014'        // C¢digo del Colegio
       LOCAL cMaeAlu := 'JARPRIBTO'         // Maestros habilitados
       LOCAL cJornad := 'D'                 // Jornadas habilitadas
       LOCAL lShared := .T.                 // .T. Sistema Compartido
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Con Proteci¢n Inicial 2=>Sin Proteci¢n Inicial
       LOCAL lNovell := .T.                 // .T. Red Novell .F. Red Win NT
       LOCAL cPasSis := 'ELLAS'             // PassWord Creaci¢n usuarios
       LOCAL lIntUno := .T.                 // Primera Integraci¢n
       LOCAL lIntDos := .T.                 // Segunda Integraci¢n
       LOCAL lIntTre := .F.                 // Tercera Integraci¢n
       LOCAL lIntCua := .F.                 // Cuarta Integraci¢n
       LOCAL lPrueba := .F.                 // Prueba de Paramentros
       LOCAL aKeySis := {{201553870,23},;    // Pendiente Salas 1 y 2
			 {cNomEmp,554226449},;
			 {cMaeAlu,151152049},;
			 {'System',386249990}}
*/


*      FECHA DE INSTALACION: ENE 07/97 HORA: 09:00 AM
*      RECIBO Y VISTO BUENO: ALEJO. SISTEMAS npinzonl@lasalle.edu.co

/*
*                       '123456789012345678901234567890123456789012'
       LOCAL cEmpPal := 'CONGREGACION DE LOS HNOS DE LAS ESCUELAS CRISTIANAS'
       LOCAL cNitEmp := '860009985-0'
       LOCAL cNomEmp := 'LICEO HERMANO MIGUEL LA SALLE'
       LOCAL cNomSec := ''                  // Nombre Secundario
       LOCAL cCodCol := 'COLCUN0013'        // C¢digo del Colegio
       LOCAL cMaeAlu := 'PRIBTO'            // Maestros habilitados
       LOCAL cJornad := 'D'                 // Jornadas habilitadas
       LOCAL lShared := .T.                 // .T. Sistema Compartido
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Con Proteci¢n Inicial 2=>Sin Proteci¢n Inicial
       LOCAL lNovell := .F.                 // .T. Red Novell .F. Red Win NT
       LOCAL cPasSis := 'ELLAS'             // PassWord Creaci¢n usuarios
       LOCAL lIntUno := .T.                 // Primera Integraci¢n
       LOCAL lIntDos := .T.                 // Segunda Integraci¢n
       LOCAL lIntTre := .F.                 // Tercera Integraci¢n
       LOCAL lIntCua := .F.                 // Cuarta Integraci¢n
       LOCAL lPrueba := .F.                 // Prueba de Paramentros
       LOCAL aKeySis := {{201553870,23},;   // Pendientes las claves
			 {cNomEmp,554226449},;
			 {cMaeAlu,151152049},;
			 {'System',419845542}}
*/


*      ADMINISTRADOR: DAVID VARGAS BEEPER TEL:3472900 COD:996
*		      CELULAR: 3096691
*		      CRA 7 # 116 - 53 USAQUEN TEL CASA: 2153691
*                     SAN BERNARDO TEL: 2335143
/*
*                       '123456789012345678901234567890123456789012'
       LOCAL cEmpPal := 'CONGREGACION DE LOS HNOS DE LAS ESCUELAS CRISTIANAS'
       LOCAL cNitEmp := '860009985-0'
       LOCAL cNomEmp := 'INSTITUTO SAN BERNARDO LA SALLE'
       LOCAL cNomSec := ''                  // Nombre Secundario
       LOCAL cCodCol := 'COLCUN0012'        // C¢digo del Colegio
       LOCAL cMaeAlu := 'PRIBTO'            // Maestros habilitados
       LOCAL cJornad := 'DN'                // Jornadas habilitadas
       LOCAL lShared := .T.                 // .T. Sistema Compartido
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Con Proteci¢n Inicial 2=>Sin Proteci¢n Inicial
       LOCAL lNovell := .F.                 // .T. Red Novell .F. Red Win NT
       LOCAL cPasSis := 'ELLAS'             // PassWord Creaci¢n usuarios
       LOCAL lIntUno := .T.                 // Primera Integraci¢n
       LOCAL lIntDos := .T.                 // Segunda Integraci¢n
       LOCAL lIntTre := .F.                 // Tercera Integraci¢n
       LOCAL lIntCua := .F.                 // Cuarta Integraci¢n
       LOCAL lPrueba := .F.                 // Prueba de Paramentros
       LOCAL aKeySis := {{201553870,23},;   // Pendientes las claves
			 {cNomEmp,554226449},;
			 {cMaeAlu,151152049},;
			 {'System',419845542}}
*/

/*
*      ENTREGADO: NOV 20/2001
*                       '123456789012345678901234567890123456789012'
       LOCAL cEmpPal := 'ASOPAF-INSTITUTO SAN BERNANDO DE LA SALLE'
       LOCAL cNitEmp := '800056408-4'
       LOCAL cNomEmp := 'ASOPAF-INSTITUTO SAN BERNANDO DE LA SALLE'
       LOCAL cNomSec := ''                  // Nombre Secundario
       LOCAL cCodCol := 'COLCUN0016'        // C¢digo del Colegio
       LOCAL cMaeAlu := 'PRIBTO'            // Maestros habilitados
       LOCAL cJornad := 'DN'                // Jornadas habilitadas
       LOCAL lShared := .T.                 // .T. Sistema Compartido
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Con Proteci¢n Inicial 2=>Sin Proteci¢n Inicial
       LOCAL lNovell := .T.                 // .T. Red Novell .F. Red Win NT
       LOCAL cPasSis := 'ELLAS'             // PassWord Creaci¢n usuarios
       LOCAL lIntUno := .T.                 // Primera Integraci¢n
       LOCAL lIntDos := .T.                 // Segunda Integraci¢n
       LOCAL lIntTre := .F.                 // Tercera Integraci¢n
       LOCAL lIntCua := .F.                 // Cuarta Integraci¢n
       LOCAL lPrueba := .F.                 // Prueba de Paramentros
       LOCAL aKeySis := {{201553870,23},;   // Pendientes las claves
			 {cNomEmp,554226449},;
			 {cMaeAlu,151152049},;
			 {'System',419845542}}
*/

/*
*                       '123456789012345678901234567890123456789012'
       LOCAL cEmpPal := 'CONGREGACION DE LOS HNOS DE LAS ESCUELAS CRISTIANAS'
       LOCAL cNitEmp := '860009985-0'
       LOCAL cNomEmp := 'LICEO LA SALLE - ZIPAQUIRA'
       LOCAL cNomSec := ''                  // Nombre Secundario
       LOCAL cCodCol := 'COLCUN0051'        // C¢digo del Colegio
       LOCAL cMaeAlu := 'PRI'               // Maestros habilitados
       LOCAL cJornad := 'D'                 // Jornadas habilitadas
       LOCAL lShared := .F.                 // .T. Sistema Compartido
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Con Proteci¢n Inicial 2=>Sin Proteci¢n Inicial
       LOCAL lNovell := .T.                 // .T. Red Novell .F. Red Win NT
       LOCAL cPasSis := 'ELLAS'             // PassWord Creaci¢n usuarios
       LOCAL lIntUno := .T.                 // Primera Integraci¢n
       LOCAL lIntDos := .T.                 // Segunda Integraci¢n
       LOCAL lIntTre := .F.                 // Tercera Integraci¢n
       LOCAL lIntCua := .F.                 // Cuarta Integraci¢n
       LOCAL lPrueba := .F.                 // Prueba de Paramentros
       LOCAL aKeySis := {{201553870,23},;   // Pendientes las claves
			 {cNomEmp,554226449},;
			 {cMaeAlu,151152049},;
			 {'System',419845542}}
*/

/*
*                       '123456789012345678901234567890123456789012'
       LOCAL cEmpPal := 'CONGREGACION DE LOS HNOS DE LAS ESCUELAS CRISTIANAS'
       LOCAL cNitEmp := '860009985-0'
       LOCAL cNomEmp := 'COLEGIO LA SALLE. VILLAVICENCIO'
       LOCAL cNomSec := ''                  // Nombre Secundario
       LOCAL cCodCol := 'COLMET0011'        // C¢digo del Colegio
       LOCAL cMaeAlu := 'JARPRIBTO'         // Maestros habilitados
       LOCAL cJornad := 'DN'                // Jornadas habilitadas
       LOCAL lShared := .F.                 // .T. Sistema Compartido
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Con Proteci¢n Inicial 2=>Sin Proteci¢n Inicial
       LOCAL lNovell := .T.                 // .T. Red Novell .F. Red Win NT
       LOCAL cPasSis := 'ELLAS'             // PassWord Creaci¢n usuarios
       LOCAL lIntUno := .T.                 // Primera Integraci¢n
       LOCAL lIntDos := .T.                 // Segunda Integraci¢n
       LOCAL lIntTre := .F.                 // Tercera Integraci¢n
       LOCAL lIntCua := .F.                 // Cuarta Integraci¢n
       LOCAL lPrueba := .F.                 // Prueba de Paramentros
       LOCAL aKeySis := {{201553870,23},;   // Pendientes las claves
			 {cNomEmp,554226449},;
			 {cMaeAlu,151152049},;
			 {'System',419845542}}
*/

/*
*      FELIPE TELS: (0975)-752220-755490
*                       '123456789012345678901234567890123456789012'
       LOCAL cEmpPal := 'CONGREGACION DE LOS HNOS DE LAS ESCUELAS CRISTIANAS'
       LOCAL cNitEmp := '860009985-0'
       LOCAL cNomEmp := 'COLEGIO LA SALLE. CUCUTA'
       LOCAL cNomSec := ''                  // Nombre Secundario
       LOCAL cCodCol := 'COLNSA0011'        // C¢digo del Colegio
       LOCAL cMaeAlu := 'PRIBTO'            // Maestros habilitados
       LOCAL cJornad := 'D'                 // Jornadas habilitadas
       LOCAL lShared := .T.                 // .T. Sistema Compartido
       LOCAL nModCry := 1                   // 0=>No Protecci¢n 1=>Con Proteci¢n Inicial 2=>Sin Proteci¢n Inicial
       LOCAL lNovell := .T.                 // .T. Red Novell .F. Red Win NT
       LOCAL cPasSis := 'ELLAS'             // PassWord Creaci¢n usuarios
       LOCAL lIntUno := .T.                 // Primera Integraci¢n
       LOCAL lIntDos := .T.                 // Segunda Integraci¢n
       LOCAL lIntTre := .F.                 // Tercera Integraci¢n
       LOCAL lIntCua := .F.                 // Cuarta Integraci¢n
       LOCAL lPrueba := .F.                 // Prueba de Paramentros
       LOCAL aKeySis := {{201553870,23},;   // Pendientes las claves
			 {cNomEmp,554226449},;
			 {cMaeAlu,151152049},;
			 {'System',419845542}}
*/


*      FECHA DE INSTALACION: FEB 14/2002
*      RECIBO Y VISTO BUENO: HNO MIGUEL Y HNO HENRY. SISTEMAS
/*
*                       '123456789012345678901234567890123456789012'
       LOCAL cEmpPal := 'CONGREGACION DE LOS HNOS DE LAS ESCUELAS CRISTIANAS'
       LOCAL cNitEmp := '999999999-9'
       LOCAL cNomEmp := 'COLEGIO DE LA SALLE - CARTAGENA'
       LOCAL cNomSec := ''                  // Nombre Secundario
       LOCAL cCodCol := 'COLBOL0011'        // C¢digo del Colegio
       LOCAL cMaeAlu := 'JARPRIBTO'         // Maestros habilitados
       LOCAL cJornad := 'D'                 // Jornadas habilitadas
       LOCAL lShared := .T.                 // .T. Sistema Compartido
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Con Proteci¢n Inicial 2=>Sin Proteci¢n Inicial
       LOCAL lNovell := .F.                 // .T. Red Novell .F. Red Win NT
       LOCAL cPasSis := 'ELLAS'             // PassWord Creaci¢n usuarios
       LOCAL lIntUno := .T.                 // Primera Integraci¢n
       LOCAL lIntDos := .T.                 // Segunda Integraci¢n
       LOCAL lIntTre := .F.                 // Tercera Integraci¢n
       LOCAL lIntCua := .F.                 // Cuarta Integraci¢n
       LOCAL lPrueba := .F.                 // Prueba de Paramentros
       LOCAL aKeySis := {{201553870,23},;   // Pendientes las claves
			 {cNomEmp,554226449},;
			 {cMaeAlu,151152049},;
			 {'System',419845542}}
*/
*      FECHA DE INSTALACION: FEB 14/2002
*      RECIBO Y VISTO BUENO: HNO MIGUEL Y HNO HENRY. SISTEMAS
/*
*                       '123456789012345678901234567890123456789012'
       LOCAL cEmpPal := 'CONGREGACION DE LOS HNOS DE LAS ESCUELAS CRISTIANAS'
       LOCAL cNitEmp := '999999999-9'
       LOCAL cNomEmp := 'COLEGIO DE LA SALLE - CARTAGENA'
       LOCAL cNomSec := ''                  // Nombre Secundario
       LOCAL cCodCol := 'COLBOL0012'        // C¢digo del Colegio
       LOCAL cMaeAlu := 'JARPRIBTO'         // Maestros habilitados
       LOCAL cJornad := 'A'                 // Jornadas habilitadas
       LOCAL lShared := .T.                 // .T. Sistema Compartido
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Con Proteci¢n Inicial 2=>Sin Proteci¢n Inicial
       LOCAL lNovell := .F.                 // .T. Red Novell .F. Red Win NT
       LOCAL cPasSis := 'ELLAS'             // PassWord Creaci¢n usuarios
       LOCAL lIntUno := .T.                 // Primera Integraci¢n
       LOCAL lIntDos := .T.                 // Segunda Integraci¢n
       LOCAL lIntTre := .F.                 // Tercera Integraci¢n
       LOCAL lIntCua := .F.                 // Cuarta Integraci¢n
       LOCAL lPrueba := .F.                 // Prueba de Paramentros
       LOCAL aKeySis := {{201553870,23},;   // Pendientes las claves
			 {cNomEmp,554226449},;
			 {cMaeAlu,151152049},;
			 {'System',419845542}}
*/

/*
*      FECHA DE INSTALACION: FEB 24/2000 HORA: 08:00 AM
*      RECIBO Y VISTO BUENO: VLADIMIR. SISTEMAS
*                       '123456789012345678901234567890123456789012'
       LOCAL cEmpPal := 'CONGREGACION DE LOS HNOS DE LAS ESCUELAS CRISTIANAS'
       LOCAL cNitEmp := '860009985-0'
       LOCAL cNomEmp := 'COLEGIO DE LA SALLE BOGOTA'
       LOCAL cCodCol := 'COLCUN0011'        // C¢digo del Colegio
       LOCAL cNomSec := ''                  // Nombre Secundario
       LOCAL cMaeAlu := 'PRIBTO'            // Maestros habilitados
       LOCAL cJornad := 'D'                 // Jornadas habilitadas
       LOCAL lShared := .T.                 // .T. Sistema Compartido
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Con Proteci¢n Inicial 2=>Sin Proteci¢n Inicial
       LOCAL lNovell := .F.                 // .T. Red Novell .F. Red Win NT
       LOCAL cPasSis := 'ELLAS'             // PassWord Creaci¢n usuarios
       LOCAL lIntUno := .T.                 // Primera Integraci¢n
       LOCAL lIntDos := .T.                 // Segunda Integraci¢n
       LOCAL lIntTre := .F.                 // Tercera Integraci¢n
       LOCAL lIntCua := .F.                 // Cuarta Integraci¢n
       LOCAL lPrueba := .F.                 // Prueba de Paramentros
       LOCAL aKeySis := {{201553870,23},;   // Pendientes las claves
			 {cNomEmp,554226449},;
			 {cMaeAlu,151152049},;
			 {'System',419845542}}
*/


*      FECHA DE INSTALACION: ENE 27/98 HORA: 05:00 PM
*      RECIBO Y VISTO BUENO: MARIA EUGENIA. SECRETARIA
/*
*                       '123456789012345678901234567890123456789012'
       LOCAL cEmpPal := 'HERMANAS BETHLEMITAS - BUCARAMANGA'
       LOCAL cNitEmp := '800020449-0'
       LOCAL cNomEmp := 'COLEGIO DEL SAGRADO CORAZON DE JESUS'
       LOCAL cNomSec := 'HERMANAS BETHLEMITAS - BUCARAMANGA'
       LOCAL cCodCol := 'COLSAN0013'        // C¢digo del Colegio
       LOCAL cMaeAlu := 'JARPRIBTO'         // Maestros habilitados
       LOCAL cJornad := 'D'                 // Jornadas habilitadas
       LOCAL lShared := .T.                 // .T. Sistema Compartido
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Con Proteci¢n Inicial 2=>Sin Proteci¢n Inicial
       LOCAL lNovell := .T.                 // .T. Red Novell .F. Red Win NT
       LOCAL cPasSis := 'ELLAS'             // PassWord Creaci¢n usuarios
       LOCAL lIntUno := .T.                 // Primera Integraci¢n
       LOCAL lIntDos := .T.                 // Segunda Integraci¢n
       LOCAL lIntTre := .F.                 // Tercera Integraci¢n
       LOCAL lIntCua := .F.                 // Cuarta Integraci¢n
       LOCAL lPrueba := .F.                 // Prueba de Paramentros
       LOCAL aKeySis := {{201553870,23},;   // Pendientes las claves
			 {cNomEmp,554226449},;
			 {cMaeAlu,151152049},;
			 {'System',419845542}}
*/

*     MOLINO DE TINTA. PEDRO PABLO PINZON CLLE 66 No. 28-75 TEL: 6472708
*      FECHA DE INSTALACION: ENE 27/98 HORA: 05:00 PM
*      RECIBO Y VISTO BUENO: MARIA EUGENIA. SECRETARIA
/*
*                       '123456789012345678901234567890123456789012'
       LOCAL cEmpPal := 'HERMANAS BETHLEMITAS - BARRANCABERMEJA'
       LOCAL cNitEmp := '800020449-0'
       LOCAL cNomEmp := 'COLEGIO DEL SAGRADO CORAZON DE JESUS'
       LOCAL cNomSec := 'HERMANAS BETHLEMITAS - BARRANCABERMEJA'
       LOCAL cCodCol := 'COLSAN0021'        // C¢digo del Colegio
       LOCAL cMaeAlu := 'JARPRIBTO'         // Maestros habilitados
       LOCAL cJornad := 'D'                 // Jornadas habilitadas
       LOCAL lShared := .T.                 // .T. Sistema Compartido
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Con Proteci¢n Inicial 2=>Sin Proteci¢n Inicial
       LOCAL lNovell := .T.                 // .T. Red Novell .F. Red Win NT
       LOCAL cPasSis := 'ELLAS'             // PassWord Creaci¢n usuarios
       LOCAL lIntUno := .T.                 // Primera Integraci¢n
       LOCAL lIntDos := .T.                 // Segunda Integraci¢n
       LOCAL lIntTre := .F.                 // Tercera Integraci¢n
       LOCAL lIntCua := .F.                 // Cuarta Integraci¢n
       LOCAL lPrueba := .F.                 // Prueba de Paramentros
       LOCAL aKeySis := {{201553870,23},;   // Pendientes las claves
			 {cNomEmp,554226449},;
			 {cMaeAlu,151152049},;
			 {'System',419845542}}
*/


*      FECHA DE ENTREGA    : JUN 15/2001 HORA: 12:00 AM
*      RECIBO Y VISTO BUENO: ING NESTOR ALEJANDRO PINZON. SISTEMAS
/*
*                       '123456789012345678901234567890123456789012'
       LOCAL cEmpPal := 'NUESTRA SE¥ORA DE LA PRESENTACION. CENTRO'
       LOCAL cNitEmp := '999999999-9'
       LOCAL cNomEmp := 'NUESTRA SE¥ORA DE LA PRESENTACION. CENTRO'
       LOCAL cNomSec := ''                  // Nombre Secundario
       LOCAL cCodCol := 'COLCUN0014'        // C¢digo del Colegio
       LOCAL cMaeAlu := 'JARPRIBTO'         // Maestros habilitados
       LOCAL cJornad := 'D'                 // Jornadas habilitadas
       LOCAL lShared := .F.                 // .T. Sistema Compartido
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Con Proteci¢n Inicial 2=>Sin Proteci¢n Inicial
       LOCAL lNovell := .F.                 // .T. Red Novell .F. Red Win NT
       LOCAL cPasSis := 'ELLAS'             // PassWord Creaci¢n usuarios
       LOCAL lIntUno := .T.                 // Primera Integraci¢n
       LOCAL lIntDos := .T.                 // Segunda Integraci¢n
       LOCAL lIntTre := .F.                 // Tercera Integraci¢n
       LOCAL lIntCua := .F.                 // Cuarta Integraci¢n
       LOCAL lPrueba := .F.                 // Prueba de Paramentros
       LOCAL aKeySis := {{201553870,23},;   // Pendientes las claves
			 {cNomEmp,554226449},;
			 {cMaeAlu,151152049},;
			 {'System',419845542}}
*/

/*
*      FECHA DE ENTREGA    : AGO 28/2002 HORA: 08:00 AM
*      RECIBO Y VISTO BUENO: ING NESTOR ALEJANDRO PINZON. SISTEMAS

*                       '123456789012345678901234567890123456789012'
       LOCAL cEmpPal := 'NUESTRA SE¥ORA DE LA PRESENTACION. ZIPAQUIRA'
       LOCAL cNitEmp := '999999999-9'
       LOCAL cNomEmp := 'NUESTRA SE¥ORA DE LA PRESENTACION. ZIPAQUIRA'
       LOCAL cNomSec := ''                  // Nombre Secundario
       LOCAL cCodCol := 'COLCUN0052'        // C¢digo del Colegio
       LOCAL cMaeAlu := 'JARPRIBTO'         // Maestros habilitados
       LOCAL cJornad := 'D'                 // Jornadas habilitadas
       LOCAL lShared := .F.                 // .T. Sistema Compartido
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Con Proteci¢n Inicial 2=>Sin Proteci¢n Inicial
       LOCAL lNovell := .F.                 // .T. Red Novell .F. Red Win NT
       LOCAL cPasSis := 'ELLAS'             // PassWord Creaci¢n usuarios
       LOCAL lIntUno := .T.                 // Primera Integraci¢n
       LOCAL lIntDos := .T.                 // Segunda Integraci¢n
       LOCAL lIntTre := .F.                 // Tercera Integraci¢n
       LOCAL lIntCua := .F.                 // Cuarta Integraci¢n
       LOCAL lPrueba := .F.                 // Prueba de Paramentros
       LOCAL aKeySis := {{201553870,23},;   // Pendientes las claves
			 {cNomEmp,554226449},;
			 {cMaeAlu,151152049},;
			 {'System',419845542}}
*/


*      FECHA DE ENTREGA    : ENE 08/2002 HORA: 08:00 AM
*      RECIBO Y VISTO BUENO: ING NESTOR ALEJANDRO PINZON. SISTEMAS
/*
*                       '123456789012345678901234567890123456789012'
       LOCAL cEmpPal := 'COLEGIO PARROQUIAL SAN CARLOS. BOGOTA'
       LOCAL cNitEmp := '999999999-9'
       LOCAL cNomEmp := 'COLEGIO PARROQUIAL SAN CARLOS. BOGOTA'
       LOCAL cNomSec := ''                  // Nombre Secundario
       LOCAL cCodCol := 'COLCUN0015'        // C¢digo del Colegio
       LOCAL cMaeAlu := 'JARPRIBTO'         // Maestros habilitados
       LOCAL cJornad := 'D'                 // Jornadas habilitadas
       LOCAL lShared := .T.                 // .T. Sistema Compartido
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Con Proteci¢n Inicial 2=>Sin Proteci¢n Inicial
       LOCAL lNovell := .F.                 // .T. Red Novell .F. Red Win NT
       LOCAL cPasSis := 'ELLAS'             // PassWord Creaci¢n usuarios
       LOCAL lIntUno := .T.                 // Primera Integraci¢n
       LOCAL lIntDos := .T.                 // Segunda Integraci¢n
       LOCAL lIntTre := .F.                 // Tercera Integraci¢n
       LOCAL lIntCua := .F.                 // Cuarta Integraci¢n
       LOCAL lPrueba := .F.                 // Prueba de Paramentros
       LOCAL aKeySis := {{201553870,23},;   // Pendientes las claves
			 {cNomEmp,554226449},;
			 {cMaeAlu,151152049},;
			 {'System',419845542}}
*/
*>>>>FIN DECLARACION DE EMPRESAS INSTALADAS


*>>>>USUARIOS EN INTERNET PARA ACTUALIZAR ARCHIVOS
/*     Clave: CIMA  www.ColSalle.edu.co IP: 63.97.53.228
       CSAN0011 -> La Salle Bga
       CSAN0012 -> Instituto San Jose
       CSAN0013 -> Bethelemitas
       CSAN0014 -> Virrey

       CCUN0011 -> La Salle
       CCUN0012 -> Isb
       CCUN0013 -> Liceo
       CCUN0014 -> Presentaci¢n
       CCUN0015 -> San Carlos
       CCUN0016 -> Asopaf - Isb

       CCUN0051 -> Zipaquira
       CMET0011 -> Villavicencio
       CNSA0011 -> Cucuta
       CBOL0011 -> Cartagena

*/
*>>>>FIN USUARIOS EN INTERNET PARA ACTUALIZAR ARCHIVOS

*>>>>DIRECTORIO DE COORPORACIONES
/*     COLMENA. BOGOTA
       Ing Jaime Hernando Gonzalez
       Cel: 3405405
       Tel: 3473477 Ext 4312
       Clle 59 # 10-60 Ofi: 401 Edificio Banco Social.

       COLMENA. BUCARAMANGA
       Ing. Alvaro Quijano Rueda.
       Tel: 6339000
       Calle 35 # 17 - 03

       Ing. Nancy Guzman.
       Tel: 6306600
       Calle 35 19-41 of: 301 La Triada.

       OLGA MILENA ARIZA ARIZA
       Cel: 033-3222975
       Sector 16 Torre 3 Apto 101
       Barrio altos de Bellavista. Tel: 6752142

       Colegio La Salle. Tel: 6437535

       Flagship

       GUILLERMO ARDILA DIAZ "Impresora"
       Cra 17 No. 98-40 Casa 44 Conjunto Nueva Fontana II
       Tel: 6375752 Casa Horario: 1 PM y 7PM
       Beeper Tel: 6432200 Cod: 13890

       WILLIAM BERNAL
       Contador Hermanas Belemethas
       Tel: 091-2702886. Va los Martes
       Tel 2853270 No se que telefono es este.

       ING ALEJANDRO PINZON
       Tel: 2631751 Apartamento

       PHILIPS
       6578600 Ext 8203
       Alicia Ortiz

       PAXAR LTDA
       Tel: 4100393 Bogot   Tel: 3612299 Medellin
*>>>>FIN DIRECTORIO DE COORPORACIONES */

* NUESTRA SE¥ORA DE LA PRESENTACION. CENTRO. JARPRIBTO

/*
*>>>>MODIFICACIONES PENDIENTES DEL SIMA
     BARRANCABERMEJA
     - Encabezado del libro
     - Cartas para Paz y Salvo
     - Arreglo de la Raz¢n Social
     - Resumen de logros en el Enfasis
     - Verificar el Modulo de Colmena
*>>>>FIN MODIFICACIONES PENDIENTES DEL SIMA */