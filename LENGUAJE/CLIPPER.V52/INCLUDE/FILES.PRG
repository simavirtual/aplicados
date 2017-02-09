/*                              SIMA
		     DECLARACION DE ARCHIVOS GENERALES

**************************************************************************
* TITULO..: DECLARACION DE ARCHIVOS DEL SISTEMAS                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 15/2004 MIE A
       Colombia, Bucaramanga        INICIO: 10:00 AM   MAY 15/2004 MIE

REQUERIMIENTOS:

1- Para que el programa funcione se debe invocar utilizando la clausula
   #INCLUDE dentro de la funcion que lo va a utilizar.

OBJETIVOS:

1- Declara todas las variables que contiene la declaraci¢n de todos los
   archivos generales que conforman el sistema.

2- El objetivo principal de esta declaraci¢n es estandarizar el modo
   de acceso a los archivos.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

*>>>>DECLARACION DE ARCHIVOS GENERALES
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
       LOCAL cExtTem := '.TEM'              // Extension Archivo temporal
       LOCAL cNtxTem := '.NEL'              // Extension Indice temporal
     *ÀArchivo Temporal

       LOCAL nHanXml := 0                   // Manejador del Archivo
       LOCAL FileXml := ''                  // Archivo Xml

       LOCAL FileAaa := 'TEMP'+ExtFile
     *ÀArchivo de Usuarios

       LOCAL fTipUsr := 'TIPOUSR'+ExtFile
     *ÀArchivo de Usuarios

       LOCAL fErrSys := 'ERRORSYS'+ExtFile

       LOCAL FilePrn := 'DRIVERS'+ExtFile
     *ÀArchivo de Configuraci¢n de Impresoras
*>>>>FIN DECLARACION DE ARCHIVOS GENERALES

*>>>>ARCHIVOS COMPARTIDOS DE SIMAPAGO
       LOCAL fSimCxP := 'SIMAPAGO'+ExtFile
     *ÀArchivo de Configuraci¢n del sistema

       LOCAL FilePuc := 'FILEPUC'+ExtFile
     *ÀArchivo de Plan Unico de Cuentas

       LOCAL FileFac := 'FACTURA'+ExtFile
       LOCAL fNtxFac := 'FACTURA'+cExtNtx
     *ÀArchivo de Facturas

       LOCAL FilePrv := 'PROVEDOR'+ExtFile
       LOCAL fNtxPrv := 'PROVEDOR'+cExtNtx
     *ÀArchivo de Proveedores

       LOCAL FileRtf := 'TABLARTF'+ExtFile
     *ÀTabla de Retenci¢n en la fuente
*>>>>FIN ARCHIVOS COMPARTIDOS DE SIMAPAGO

*>>>>ARCHIVOS COMPARTIDOS DE SIMACART
       LOCAL fCarAno := 'CART'                        // Ej: CART1996.DAT
     *ÀArchivo Configuraci¢n del A¤o

       LOCAL FileMoB := ''                       // Ej: 01199902.DAT
     *ÀArchivo de Movimientos del Banco
*>>>>ARCHIVOS COMPARTIDOS DE SIMACART

*>>>>ARCHIVOS COMPARTIDOS DE SIMAMATR
       LOCAL fSimMtr := 'SIMAMATR'+ExtFile
      *Archivo de Configuraci¢n del Sistema

       LOCAL FileCnt := 'CONTRATA'+ExtFile
      *Archivo de Contratantes
*>>>>FIN ARCHIVOS COMPARTIDOS DE SIMAMATR

*>>>>ARCHIVOS COMPARTIDOS DE SIMACONT
       LOCAL fSimaCo := 'SIMACONT'+ExtFile
     *ÀArchivo de Configuraci¢n del sistema

       LOCAL fConTbl := 'CONT'     // Ej: CONTBTO.DAT
     *ÀArchivo Configuraci¢n del nivel

       LOCAL FilePer := 'PERSONAS'+ExtFile
     *ÀArchivo de Personas

       LOCAL FileEmp := 'EMPRESAS'+ExtFile
       LOCAL fNtxEmp := 'EMPRESAS'+cExtNtx
     *ÀArchivo de Empresas

       LOCAL FileGru := 'GRU'
     *ÀArchivo de Grupos

       LOCAL FileHra := 'HORAS'+ExtFile	   // Ej: HABILI97.DAT
     *ÀArchivo de Horas

       LOCAL PathAlu := ''
       LOCAL FileAlu := 'MAE'
       LOCAL fNtxAlu := 'MAE'
     *ÀArchivo de Alumnos

       LOCAL PathBto := ''
       LOCAL FMaeBto := 'MAEBTO'            // Ej: MAEBTO95.DAT
       LOCAL fNtxBto := 'MAEBTO'
       LOCAL Ntx1Bto := 'APEBTO'            // Ej: APEBTO95.NEL
       LOCAL Ntx2Bto := 'NOMBTO'            // Ej: NOMBTO95.NEL
     *ÀArchivo de Alumnos de Bachillerato

       LOCAL PathPri := ''
       LOCAL FMaePri := 'MAEPRI'            // Ej: MAEPRI94.DAT
       LOCAL fNtxPri := 'MAEPRI'
       LOCAL Ntx1Pri := 'APEPRI'            // Ej: APEPRI95.NEL
       LOCAL Ntx2Pri := 'NOMPRI'            // Ej: NOMPRI95.NEL
     *ÀArchivo de Alumnos de Primaria

       LOCAL PathJar := ''
       LOCAL FMaeJar := 'MAEJAR'            // Ej: MAEJAR94.DAT
       LOCAL fNtxJar := 'MAEJAR'
       LOCAL Ntx1Jar := 'APEJAR'            // Ej: APEJAR95.NEL
       LOCAL Ntx2Jar := 'NOMJAR'            // Ej: NOMJAR95.NEL
     *ÀArchivo de Alumnos de Jard¡n

       LOCAL FileFam := 'FAMILIA'+ExtFile   // Ej: FAMILIA.DAT
       LOCAL fNtxFam := 'FAMILIA'+cExtNtx
     *ÀArchivo de Familias

       LOCAL FilePla := 'PL'                // Ej: PLAN0695.DAT  Por Nivel

       LOCAL FileNot := 'NT'               // Ej: NT060195.DAT
     *ÀArchivo de Notas
*>>>>FIN ARCHIVOS COMPARTIDOS DE SIMACONT

*>>>>ARCHIVOS COMPARTIDOS DE SIMACART
       LOCAL FileCli := ''                            // Ej: CLI1101.094
     *ÀArchivo de Clientes

       LOCAL FilePag := 'PAGOS'+ExtFile               // Ej: PAG1101.094
     *ÀArchivo de Pagos

       LOCAL FileTar := 'TARIFAS'+ExtFile
     *ÀArchivo de Tarifas

       LOCAL FileDes := 'DESCUENT'+ExtFile
       LOCAL fNtxDes := 'DESCUENT'+cExtNtx
     *ÀArchivo de Descuentos
*>>>>FIN ARCHIVOS COMPARTIDOS DE SIMACART

*>>>>OTROS ARCHIVOS
       LOCAL FilePrg := 'FILEPRG'+ExtFile              // Ej: FILEPRG.DAT
     *ÀArchivo para Generar SoftWare
*>>>>FIN OTROS ARCHIVOS