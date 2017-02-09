/*                       SIMA - MATRICULA ACADEMICA
		     DECLARACION DE ARCHIVOS DEL SISTEMA

**************************************************************************
* NOMBRE DEL PROGRAMA......: ARC-CONT.PRG                                *
* TITULO DEL PROGRAMA......: DECLARACION DE ARCHIVOS DEL SISTEMAS        *
* PROGRAMAS QUE LO INVOCAN.: La mayoria de funciones del sistema         *
* PROGRAMAS QUE INVOCA.....: Ninguno                                     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC 28/95 JUE A
       Colombia, Bucaramanga        INICIO: 10:00 AM   DIC 28/95 JUE

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

       LOCAL PathSis := 'BASES'             // Path General del sistema
       LOCAL ExtFile := '.DAT'              // Extension para las bases
       LOCAL cExtNtx := '.NEL'              // Extension para indices
       LOCAL aUseDbf := {}                  // Vector para Apertura de Varias Dbfs
       LOCAL lSiRed  := .T.                 // .T. Apertura de Archivos MultiUsuario
       LOCAL lNoRed  := .F.                 // .F. Apertura de Archivo MonoUsuario

       LOCAL PathXls := 'c:\misdoc'         // Path de Documentos del sima
       LOCAL PathPrn := 'PRINTER'           // Path para impresiones
       LOCAL PathDoc := 'c:\misdoc'         // Path de Documentos del sima
       LOCAL FileTem := 'TEMPO'             // Archivo datos temporal
       LOCAL fNtxTem := 'TEMPO'             // Archivo Indice temporal
       LOCAL cExtTem := '.TEM'              // Extension Archivo temporal
       LOCAL cNtxTem := '.NEL'              // Extension Indice temporal
     *ÀArchivo Temporal

       LOCAL nHanXml := -1                  // Manejador del Archivo
       LOCAL FileXml := ''                  // Archivo Xml
     *ÀArchivo Xml

       LOCAL PathAaa := ''
       LOCAL FileAaa := PathAaa+'TEMP'+ExtFile
       LOCAL fNtxAaa := ''
     *ÀArchivo de Usuarios

       LOCAL PathErr := ''
       LOCAL fErrSys := PathErr+'ERRORSYS'+ExtFile
       LOCAL fNtxErr := ''

       LOCAL FileClr := 'CFGCOLOR'+ExtFile
     *ÀArchivo de Configuraci¢n del Color

       LOCAL FilePrn := 'DRIVERS'+ExtFile
     *ÀArchivo de Configuraci¢n de Impresoras

       LOCAL FileMzp := 'CONFIREC'+ExtFile
     *ÀArchivo de Configuraci¢n MZP KIOSERA MITA

       LOCAL FileDat := 'DATO0101'+ExtFile
     *ÀArchivo de Datos del Sistema
*>>>>FIN DECLARACION DE ARCHIVOS GENERALES

*>>>>DECLARACION DE ARCHIVOS DEL SISTEMA
       LOCAL PathMtr := ''
       LOCAL fSimMtr := PathMtr+'SIMAMATR'+ExtFile
       LOCAL fNtxMtr := ''
     *ÀArchivo de Configuraci¢n del sistema

       LOCAL PathMtA := ''
       LOCAL fMtrAno := PathMtA+'MATR'     // Ej: MATR1996.DAT
       LOCAL fNtxMtA := ''
     *ÀArchivo de Configuraci¢n del a¤o

       LOCAL PathCaA := ''
       LOCAL fCarAno := PathCaA+'CART'     // Ej: CART1996.DAT
       LOCAL fNtxCaA := ''
     *ÀArchivo de Configuraci¢n del a¤o. Cartera

       LOCAL PathTbl := ''
       LOCAL fMtrTbl := PathTbl+'MATR'     // Ej: MATRBTO.DAT
       LOCAL fNtxTbl := ''
     *ÀArchivo de Configuraci¢n del nivel

       LOCAL PathAdm := ''
       LOCAL FileAdm := PathAdm+'ADMI'          // Ej: ADMISI95.DAT
       LOCAL fNtxAdm := 'INSCRADM'+cExtNtx	// Ej: INSCRADM.NEL
       LOCAL Ntx1Adm := 'APELLADM'+cExtNtx	// Ej: APELLADM.NEL
       LOCAL Ntx2Adm := 'NOMBRADM'+cExtNtx	// Ej: NOMBRADM.NEL
     *ÀArchivo de Admisiones

       LOCAL FileDoc := 'DOCE'    // Ej: DOCE1996.DAT
       LOCAL fNtxDoc := ''
     *ÀArchivo de Docentes del Colegio todos los a¤os

       LOCAL FileIso := 'FILESISO'+ExtFile
     *ÀArchivo de documentos de Iso

       LOCAL FileInf := 'INFORSYS'+ExtFile
     *ÀArchivo de informes del sistema

       LOCAL PathCon := ''
       LOCAL FileCon := PathCon+'CONCEPTO'+ExtFile
       LOCAL fNtxCon := ''
     *ÀArchivo de Concepto

       LOCAL PathTar := ''
       LOCAL FileTar := PathTar+'TARIFAS'+ExtFile
       LOCAL fNtxTar := ''
     *ÀArchivo de Tarifas

       LOCAL PathBan := ''
       LOCAL FileBan := PathBan+'BANCOS'+ExtFile
       LOCAL fNtxBan := ''
     *ÀArchivo de Bancos

       LOCAL PathPag := ''
       LOCAL FilePag := PathPag+'PAGOS'+ExtFile
       LOCAL fNtxPag := PathPag+'PAGOS'+cExtNtx
     *ÀArchivo de pagos

       LOCAL FileNiv := 'NIVELS'
     *ÀArchivo de Niveles

       LOCAL FileCnt := 'CONTRATA'+ExtFile
      *Archivo de Contratantes

       LOCAL FileTrc := 'TIPORECI'+ExtFile
      *Archivo de Tipos de Recibos

       LOCAL FileTob := 'TABLAOBS'+ExtFile
     *ÀArchivo de Tabla de observaciones

       LOCAL FileObs := 'OBSEREST'+ExtFile
     *ÀArchivo de observaciones de los estudiantes

       LOCAL FileObG := 'OBSERGEN'+ExtFile
       LOCAL fNtxObG := 'OBSERGEN'+cExtNtx
     *ÀArchivo de Observaciones Generales

       LOCAL FileToG := 'TIPOBSGE'+ExtFile
     *ÀArchivo de Tipo Observaciones Generales

       LOCAL FileSoG := 'SUBOBSGE'+ExtFile
     *ÀArchivo de Subdivisi¢n Observaciones Generales

       LOCAL FileSib := 'SISBEN'+ExtFile
     *ÀArchivo de Sisben

       LOCAL FileDes := 'DESCUENT'+ExtFile
       LOCAL fNtxDes := 'DESCUENT'+cExtNtx
     *ÀArchivo de Descuentos
*>>>>FIN DECLARACION DE ARCHIVOS DEL SISTEMA

*>>>>DECLARACION DE ARCHIVOS COMPARTIDOS
       LOCAL fSimaCo := 'SIMACONT'+ExtFile
     *ÀArchivo de Configuraci¢n del sistema

       LOCAL FilePer := 'PERSONAS'+ExtFile
       LOCAL fNtxPer := 'PERSONAS'+cExtNtx
       LOCAL Ntx1Per := 'PERSONIT'+cExtNtx
     *ÀArchivo de Personas

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

       LOCAL PathGua := ''
       LOCAL FMaeGua := 'MAEGUA'            // Ej: MAEGUA94.DAT
       LOCAL fNtxGua := 'MAEGUA'
       LOCAL Ntx1Gua := 'APEGUA'            // Ej: APEGUA95.NEL
       LOCAL Ntx2Gua := 'NOMGUA'            // Ej: NOMGUA95.NEL
     *ÀArchivo de Alumnos de Guarderia

       LOCAL FileGru := 'GRU'
     *ÀArchivo de Grupos

       LOCAL PGruGua := ''
       LOCAL FGruGua := 'GRUGUA'            // Ej: GRUGUA94.DAT
       LOCAL NGruGua := ''
     *ÀArchivo de Grupos de Guarder¡a

       LOCAL PGruJar := ''
       LOCAL FGruJar := 'GRUJAR'            // Ej: GRUJAR94.DAT
       LOCAL NGruJar := ''
     *ÀArchivo de Grupos de Jard¡n

       LOCAL PGruPri := ''
       LOCAL FGruPri := 'GRUPRI'            // Ej: GRUPRI94.DAT
       LOCAL NGruPri := ''
     *ÀArchivo de Grupos de Primaria

       LOCAL PGruBto := ''
       LOCAL FGruBto := 'GRUBTO'            // Ej: GRUBTO94.DAT
       LOCAL NGruBto := ''
     *ÀArchivo de Grupos de Bachillerato

       LOCAL PathNot := ''
       LOCAL FileNot := PathNot+'NT'        // Ej: NT060195.DAT
       LOCAL fNtxNot := ''
     *ÀArchivo de Notas

       LOCAL PathCli := ''
       LOCAL FileCli := ''                  // Ej: CL110196.DAT
       LOCAL fNtxCli := ''
     *ÀArchivo de Clientes

       LOCAL FileRec := 'RECIBOS'+ExtFile             // Ej: RECIBOS.DAT
       LOCAL fNtxRec := 'RECIBOS'+cExtNtx
     *ÀArchivo de Control de Recibos

       LOCAL fPazEst := 'PAZEST'	           // Ej: PAZEST01.DAT
     *ÀArchivo de Paz y Salvos

       LOCAL fDpzEst := 'DEUPAZ'	           // Ej: DEUPAZ01.DAT
     *ÀArchivo de Deudas del Paz y Salvo

       LOCAL fColPrc := 'COLEPROC'+ExtFile         // Ej: COLEPROC.DAT
     *ÀArchivo de Colegios de Procedencia.
*>>>>FIN DECLARACION DE ARCHIVOS COMPARTIDOS

*>>>>DECLARACION DE ARCHIVOS COMPARTIDOS.SIMACART
       LOCAL FileTmv := 'TIPMOV'                      // Ej: TIPMOV01.DAT
     *ÀArchivo de tipos de movimiento.

       LOCAL FileCmv := 'CONCEMOV'+ExtFile
     *ÀArchivo de Conceptos de Movimiento

       LOCAL FileTra := ''                       // PA199905.DAT  Para el Mensual
       LOCAL fNtxTra := ''                       // 19990506.DAT  Para el Diario
     *ÀArchivo de Trasaciones

       LOCAL FileMoB := ''                       // Ej: 01199902.DAT
       LOCAL fNtxMoB := ''
     *ÀArchivo de Movimientos del Banco

       LOCAL PathOnl := ''
       LOCAL FileOnl := 'ONL'                            // Pagos en l¡nea
     *ÀPagos en l¡nea
*>>>>DECLARACION DE ARCHIVOS COMPARTIDOS.SIMACART