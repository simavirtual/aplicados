/*                       SIMA - CARTERA ACADEMICA
		     DECLARACION DE ARCHIVOS DEL SISTEMA

**************************************************************************
* NOMBRE DEL PROGRAMA......: ARC-CART.PRG                                *
* TITULO DEL PROGRAMA......: DECLARACION DE ARCHIVOS DEL SISTEMAS        *
* PROGRAMAS QUE LO INVOCAN.: La mayoria de funciones del sistema         *
* PROGRAMAS QUE INVOCA.....: Ninguno                                     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 15/96 JUE A
       Colombia, Bucaramanga        INICIO: 03:00 PM   FEB 15/96 JUE

REQUERIMIENTOS:

1- Para que el programa funcione se debe invocar utilizando la clausula
   #INCLUDE dentro de la funcion que lo va a utilizar.

OBJETIVOS:

1- Declara todas las variables que contiene la declaraci¢n de todos los
   archivos que conforma el sistema.

2- El objetivo principal de esta declaraci¢n es estandarizar el modo
   de acceso a los archivos.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

*>>>>DECLARACION DE ARCHIVOS GENERALES
       LOCAL PathWeb := '..\simaweb'        // Path del Sitio

       LOCAL PathSys := 'SIMACART'          // Path del Sistema
       LOCAL PathSis := 'BASES'             // Path General del sistema
       LOCAL ExtFile := '.DAT'              // Extension para las bases
       LOCAL cExtNtx := '.NEL'              // Extension para indices
       LOCAL aUseDbf := {}                  // Vector para Apertura de Varias Dbfs
       LOCAL lSiRed  := .T.                 // .T. Apertura de Archivos MultiUsuario
       LOCAL lNoRed  := .F.                 // .F. Apertura de Archivo MonoUsuario


       LOCAL PathPrn := 'PRINTER'           // Path para impresiones
       LOCAL PathDoc := 'c:\misdoc'         // Path de Documentos del sima
       LOCAL FileTem := 'TEMPO'             // Archivo datos temporal
       LOCAL fNtxTem := 'TEMPO'             // Archivo Indice temporal
       LOCAL cExtTem := '.TEM'              // Extension indice temporal

       LOCAL nHanXml := -1                  // Manejador del Archivo
       LOCAL FileXml := ''                  // Archivo Xml
     *ÀArchivos espec¡ficos

       LOCAL FileAaa := 'TEMP'+ExtFile
     *ÀArchivo de Usuarios

       LOCAL fErrSys := 'ERRORSYS'+ExtFile
     *ÀArchivo de Errores

       LOCAL FileClr := 'CFGCOLOR'+ExtFile
     *ÀArchivo de Configuraci¢n del Color

       LOCAL FilePrn := 'DRIVERS'+ExtFile
     *ÀArchivo de Configuraci¢n de Impresoras

       LOCAL FileDat := 'DATO0104'+ExtFile
     *ÀArchivo de Datos del Sistema

       LOCAL FileInf := 'INFORSYS'+ExtFile
     *ÀArchivo de informes del sistema

       LOCAL FileIso := 'FILESISO'+ExtFile
     *ÀArchivo de documentos de Iso

       LOCAL FileXsl := 'infprn'+ExtFile
     *ÀArchivo Xsl para los informes.

       LOCAL FileJpg := 'fondo.jpg'
     *ÀArchivo jpg fondo de los informes
*>>>>FIN DECLARACION DE ARCHIVOS GENERALES

*>>>>DECLARACION DE ARCHIVOS DEL SISTEMA
       LOCAL FileEmp := 'EMPRESA'+ExtFile
     *ÀArchivo de Empresa

       LOCAL fSimCar := 'SIMACART'+ExtFile
     *ÀArchivo de Configuraci¢n del sistema

       LOCAL fCarAno := 'CART'     // Ej: CART1996.DAT
     *ÀArchivo de Configuraci¢n del a¤o

       LOCAL fCarTbl := 'CART'     // Ej: CARTBTO.DAT
     *ÀArchivo de Configuraci¢n del nivel

       LOCAL FileCli := ''                            // Ej: CLI1101.094
     *ÀArchivo de Clientes

       LOCAL FilePag := 'PAGOS'+ExtFile               // Ej: PAG1101.094
       LOCAL fNtxPag := 'PAGOS'+cExtNtx               // En Matriculas
     *ÀArchivo de Pagos

       LOCAL FileCoE := 'CONCEEST'+ExtFile            // Ej: CONCEPEST.DAT
     *ÀArchivo de Conceptos de los Estudiantes

       LOCAL FilePaC := 'PAGOSCON'+ExtFile            // Ej: PAGOSCON.DAT
     *ÀArchivo de Pagos de Conceptos

       LOCAL FileBan := 'BANCOS'+ExtFile
     *ÀArchivo de Bancos

       LOCAL FileCon := 'CONCEPTO'+ExtFile
     *ÀArchivo de Concepto

       LOCAL FileTar := 'TARIFAS'+ExtFile
     *ÀArchivo de Tarifas

       LOCAL FileDes := 'DESCUENT'+ExtFile
       LOCAL fNtxDes := 'DESCUENT'+cExtNtx
     *ÀArchivo de Descuentos

       LOCAL FileTra := ''                       // PA199905.DAT  Para el Mensual
       LOCAL fNtxTra := ''                       // 19990506.DAT  Para el Diario
     *ÀArchivo de Trasaciones

       LOCAL FileMoB := ''                       // Ej: 01199902.DAT
       LOCAL fNtxMoB := ''
     *ÀArchivo de Movimientos del Banco

       LOCAL FileTmv := 'TIPMOV'                      // Ej: TIPMOV01.DAT
     *ÀArchivo de tipos de movimiento.

       LOCAL FileCmv := 'CONCEMOV'+ExtFile
*       LOCAL fNtxCmv := 'CONCEMOV'+cExtNtx
     *ÀArchivo de Conceptos de Movimiento

       LOCAL FileCob := 'COBROS'                      // Ej: COBROS02.DAT
     *ÀArchivo de Cobros

       LOCAL FileMor := 'MOROSO'                      // Ej: MOROSO02.DAT
*       LOCAL fNtxMor := 'MOROSO'
     *ÀArchivo de Morosos

       LOCAL FileCoP := 'COBPAG'                      // Ej: COBPAG02.DAT
     *ÀArchivo de Cobros pagados

       LOCAL FileFpg := 'FORMAPAG'+ExtFile           // Ej: FORMAPAG.DAT
     *ÀArchivo de Forma de pago

       LOCAL FileRec := 'RECIBOS'+ExtFile             // Ej: RECIBOS.DAT
       LOCAL fNtxRec := 'RECIBOS'+cExtNtx
     *ÀArchivo de Control de Recibos

       LOCAL FilePuc := 'PUC'+ExtFile                 // Ej: PUC.DAT
*       LOCAL fNtxPuc := 'PUC'+cExtNtx
     *ÀArchivo de Plan de Cuentas

       LOCAL FileRut := 'RUTAS'+ExtFile               // Ej: RUTAS.DAT
       LOCAL fNtxRut := 'RUTAS'+cExtNtx
     *ÀArchivo de Rutas

       LOCAL FileURu := 'USRRUTAS'+ExtFile               // Ej: USRRUTAS.DAT
       LOCAL fNtxURu := 'USRRUTAS'+cExtNtx
     *ÀArchivo de Usuarios de Rutas

       LOCAL FileFia := 'FIADORES'+ExtFile               // Ej: FIADORES.DAT
       LOCAL fNtxFia := 'FIADORES'+cExtNtx
     *ÀArchivo de Fiadores

       LOCAL FileCvn := 'CONVENIO'+ExtFile               // Ej: CONVENIO.DAT
       LOCAL fNtxCvn := 'CONVENIO'+cExtNtx
     *ÀArchivo de Convenios

       LOCAL FileMvt := 'MOVIMI'                         // Ej: MOVIME01.DAT
     *ÀMovimientos Contables

       LOCAL FileCtt := 'CUENTAT'+ExtFile
     *ÀCuenta T

       LOCAL FileCnc := 'CONCILIA'+ExtFile
     *ÀConciliaciones
*>>>>DECLARACION DE ARCHIVOS DEL SISTEMA

*>>>>DECLARACION DE ARCHIVOS COMPARTIDOS
       LOCAL fSimaCo := 'SIMACONT'+ExtFile
     *ÀArchivo de Configuraci¢n del sistema

       LOCAL FilePer := 'PERSONAS'+ExtFile
       LOCAL fNtxPer := 'PERSONAS'+cExtNtx
       LOCAL Ntx1Per := 'PERSONIT'+cExtNtx
     *ÀArchivo de Personas

       LOCAL FilePro := 'PROFES'           // Ej: PROFES95.DAT
     *ÀArchivo de Profesores

       LOCAL FileAlu := 'MAE'
       LOCAL fNtxAlu := 'MAE'
     *ÀArchivo de Alumnos

       LOCAL fPazEst := 'PAZEST'	           // Ej: PAZEST01.DAT
     *ÀArchivo de Paz y Salvos

       LOCAL fDpzEst := 'DEUPAZ'	           // Ej: DEUPAZ01.DAT
     *ÀArchivo de Deudas del Paz y Salvo

       LOCAL FMaeBto := 'MAEBTO'            // Ej: MAEBTO95.DAT
       LOCAL fNtxBto := 'MAEBTO'
       LOCAL Ntx1Bto := 'APEBTO'            // Ej: APEBTO95.NEL
       LOCAL Ntx2Bto := 'NOMBTO'            // Ej: NOMBTO95.NEL
     *ÀArchivo de Alumnos de Bachillerato

       LOCAL FMaePri := 'MAEPRI'            // Ej: MAEPRI94.DAT
       LOCAL fNtxPri := 'MAEPRI'
       LOCAL Ntx1Pri := 'APEPRI'            // Ej: APEPRI95.NEL
       LOCAL Ntx2Pri := 'NOMPRI'            // Ej: NOMPRI95.NEL
     *ÀArchivo de Alumnos de Primaria

       LOCAL FMaeJar := 'MAEJAR'            // Ej: MAEJAR94.DAT
       LOCAL fNtxJar := 'MAEJAR'
       LOCAL Ntx1Jar := 'APEJAR'            // Ej: APEJAR95.NEL
       LOCAL Ntx2Jar := 'NOMJAR'            // Ej: NOMJAR95.NEL
     *ÀArchivo de Alumnos de Jard¡n

       LOCAL FMaeGua := 'MAEGUA'            // Ej: MAEGUA94.DAT
       LOCAL fNtxGua := 'MAEGUA'
       LOCAL Ntx1Gua := 'APEGUA'            // Ej: APEGUA95.NEL
       LOCAL Ntx2Gua := 'NOMGUA'            // Ej: NOMGUA95.NEL
     *ÀArchivo de Alumnos de Guarderia

       LOCAL FileGru := 'GRU'
     *ÀArchivo de Grupos

       LOCAL FGruGua := 'GRUGUA'            // Ej: GRUGUA94.DAT
       LOCAL NGruGua := ''
     *ÀArchivo de Grupos de Guarder¡a

       LOCAL FGruJar := 'GRUJAR'            // Ej: GRUJAR94.DAT
       LOCAL NGruJar := ''
     *ÀArchivo de Grupos de Jard¡n

       LOCAL FGruPri := 'GRUPRI'            // Ej: GRUPRI94.DAT
       LOCAL NGruPri := ''
     *ÀArchivo de Grupos de Primaria

       LOCAL FGruBto := 'GRUBTO'            // Ej: GRUBTO94.DAT
       LOCAL NGruBto := ''
     *ÀArchivo de Grupos de Bachillerato

       LOCAL FileNiv := 'NIVELS'
     *ÀArchivo de Niveles

       LOCAL FileAdm := 'ADMI'               // Ej: ADMISI95.DAT
       LOCAL fMtrAno := 'MATR'               // Ej: MATR1996.DAT
     *ÀArchivo de Admisiones

       LOCAL FCaFAno := 'CAFE'              // Ej: CAFE2002.DAT
     *ÀArchivo de Configuraci¢n del a¤o

       LOCAL FPerCaF := 'PERSONAL'+ExtFile  // Ej: PERSONAL.DAT
     *ÀPersonal de cafeteria.

       LOCAL FileFam := 'FAMILIA'+ExtFile   // Ej: FAMILIA.DAT
       LOCAL fNtxFam := 'FAMILIA'+cExtNtx
     *ÀArchivo de Familias
*>>>>FIN DECLARACION DE ARCHIVOS COMPARTIDOS