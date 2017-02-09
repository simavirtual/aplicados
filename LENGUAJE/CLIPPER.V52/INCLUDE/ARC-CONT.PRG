/* SISTEMA DE CONTABILIDAD ACADEMICA

MODULO      : DECLARACION DE ARCHIVOS DEL SISTEMA
SUBMODULO...: DECLARACION DE ARCHIVOS DEL SISTEMA

**************************************************************************
* NOMBRE DEL PROGRAMA......: ARC-CONT.PRG                                *
* TITULO DEL PROGRAMA......: DECLARACION DE ARCHIVOS DEL SISTEMAS        *
* PROGRAMAS QUE LO INVOCAN.: La mayoria de funciones del sistema         *
* PROGRAMAS QUE INVOCA.....: Ninguno                                     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 02/95 MAR A
       Colombia, Bucaramanga        INICIO: 10:00 AM   MAY 02/95 MAR

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

       LOCAL PathSys := ''                  // Path del Sistema
       LOCAL PathSis := 'BASES'             // Path General del sistema
       LOCAL ExtFile := '.DAT'              // Extension para las bases
       LOCAL cExtNtx := '.NEL'              // Extension para indices
       LOCAL aUseDbf := {}                  // Vector para Apertura de Varias Dbfs
       LOCAL lSiRed  := .T.                 // .T. Apertura de Archivos MultiUsuario
       LOCAL lNoRed  := .F.                 // .F. Apertura de Archivo MonoUsuario

       LOCAL PathTem := 'TEMP'              // Path Temporal
       LOCAL PathPrn := 'PRINTER'           // Path para impresiones
       LOCAL PathXls := 'c:\misdoc'         // Path de Documentos del sima
       LOCAL PathDoc := 'c:\misdoc'         // Path de Documentos del sima

       LOCAL FileTem := 'TEMPO'             // Archivo datos temporal
       LOCAL fNtxTem := 'TEMPO'             // Archivo Indice temporal
       LOCAL cExtTem := '.TEM'              // Extension indice temporal

       LOCAL nHanXml := -1                  // Manejador del Archivo
       LOCAL FileXml := ''                  // Archivo Xml
     *ÀArchivo Temporal

       LOCAL FileAaa := 'TEMP'+ExtFile
     *ÀArchivo de Usuarios

       LOCAL fTipUsr := 'TIPOUSR'+ExtFile
     *ÀArchivo de Tipos de Usuarios

       LOCAL FilePrn := 'DRIVERS'+ExtFile
     *ÀArchivo de Configuraci¢n de Impresoras

       LOCAL FileDat := 'DATO0102'+ExtFile
     *ÀArchivo de Datos del Sistema

       LOCAL fErrSys := 'ERRORSYS'+ExtFile
       LOCAL fNtxErr := ''
     *ÀArchivo de Errores del Sistema

       LOCAL FileClr := 'CFGCOLOR'+ExtFile
     *ÀArchivo de Configuraci¢n del Color

       LOCAL PathOtr := '1FileTem'
       LOCAL PathLog := 'AFileLog'
       LOCAL FileLog := ''
     *ÀArchivo de Errores

       LOCAL FileXsl := 'inforprn.www'
     *ÀArchivo Xsl para los informes.

       LOCAL FileJpg := 'fondoprn.jpg'
     *ÀArchivo jpg fondo de los informes

       LOCAL FileIso := 'FILESISO'+ExtFile
     *ÀArchivo de documentos de Iso

       LOCAL FileInf := 'INFORSYS'+ExtFile
     *ÀArchivo de informes del sistema
*>>>>FIN DECLARACION DE ARCHIVOS GENERALES

*>>>>DECLARACION DE ARCHIVOS DEL SISTEMA
       LOCAL fSimaCo := 'SIMACONT'+ExtFile
       LOCAL fNtxCon := ''
     *ÀArchivo de Configuraci¢n del sistema

       LOCAL fConAno := 'CONT'     // Ej: CONT1996.DAT
       LOCAL fNtxCoA := ''
     *ÀArchivo Configuraci¢n del a¤o

       LOCAL fConTbl := 'CONT'     // Ej: CONTBTO.DAT
       LOCAL fNtxTbl := ''
     *ÀArchivo Configuraci¢n del nivel

       LOCAL FileEmp := 'EMPRESAS'+ExtFile
       LOCAL fNtxEmp := ''
     *ÀArchivo de Empresa

       LOCAL FilePer := 'PERSONAS'+ExtFile
       LOCAL fNtxPer := 'PERSONAS'+cExtNtx
       LOCAL Ntx1Per := 'PERSONIT'+cExtNtx
     *ÀArchivo de Personas

       LOCAL fPerImp := 'PER'
     *ÀArchivo de Personas Importar

       LOCAL FileDoc := 'DOCENTES'+ExtFile
       LOCAL fNtxDoc := ''
     *ÀArchivo de Docentes del Colegio todos los a¤os

       LOCAL FilePro := 'PROFES'    // Ej: PROFES95.DAT
       LOCAL fNtxPro := 'PROFES'    // Ej: PROFES95.NEL
     *ÀArchivo de Profesores del a¤o

       LOCAL FileOrg := 'ORGANIZA'+ExtFile
       LOCAL fNtxOrg := 'ORGANIZA'+ExtFile
     *ÀArchivo de Organizaciones

       LOCAL FileCla := 'CLASEIND'+ExtFile
       LOCAL fNtxCla := 'CLASEIND'+ExtFile
     *ÀArchivo de Clase de Indicadores

       LOCAL FNroInd := 'NRO'      // Ej: NROBTO96.DAT
       LOCAL fNtxNro := 'NRO'      // Ej: NROBTO96.NEL
     *ÀArchivo de Control de los n£mero de Indicadores

       LOCAL FileEva := 'TABLAEVA'+ExtFile
       LOCAL fNtxEva := 'TABLAEVA'+ExtFile
     *ÀArchivo Tabla de Evaluaci¢n

       LOCAL FileApr := 'TABLAAPR'+ExtFile
       LOCAL fNtxApr := 'TABLAAPR'+ExtFile
     *ÀArchivo Tabla de Aprobaci¢n

       LOCAL FileCar := 'CARGA'     // Ej: CARGABTO.DAT
       LOCAL fNtxCar := 'CARGA'     //     CARGABTO.NEL
     *ÀArchivo de Cargas

       LOCAL FileAlu := 'MAE'
       LOCAL fNtxAlu := 'MAE'
     *ÀArchivo de Alumnos

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

       LOCAL FileGru := 'GRU'
       LOCAL fNtxGru := ''
     *ÀArchivo de Grupos

       LOCAL FGruBto := 'GRUBTO'            // Ej: GRUBTO94.DAT
       LOCAL NGruBto := ''
     *ÀArchivo de Grupos de Bachillerato

       LOCAL FGruPri := 'GRUPRI'            // Ej: GRUPRI94.DAT
       LOCAL NGruPri := ''
     *ÀArchivo de Grupos de Primaria

       LOCAL FGruJar := 'GRUJAR'            // Ej: GRUJAR94.DAT
       LOCAL NGruJar := ''
     *ÀArchivo de Grupos de Jard¡n

       LOCAL FileNiv := 'NIVELS'            // Ej: NIVELS95.DAT
       LOCAL fNtxNiv := 'NIVELS'            // Ej: NIVELS95.NEL
     *ÀArchivo de Niveles

       LOCAL FileJui := 'IND'               // Ej: JUIBTO95.DAT
       LOCAL fNtxJui := 'IND'               // Ej: JUIBTO95.NEL
     *ÀArchivo de Juicios

       LOCAL FileInd := 'IND'               // Ej: INDBTO.DAT
       LOCAL fNtxInd := 'IND'               // Ej: INDBTO.NEL

       LOCAL FileSin := 'SUB'               // Ej: SUBBTO08.DAT
     *ÀArchivo Clasificaci¢n de Indicadores

       LOCAL FJuiJar := 'INDJAR'            // Ej: JUIJAR95.DAT
       LOCAL NJuiJar := 'INDJAR'
     *ÀArchivo de Juicios de Jard¡n

       LOCAL FJuiPri := 'INDPRI'            // Ej: JUIPRI95.DAT
       LOCAL NJuiPri := 'INDPRI'
     *ÀArchivo de Juicios de Primaria

       LOCAL FJuiBto := 'INDBTO'            // Ej: JUIBTO95.DAT
       LOCAL NJuiBto := 'INDBTO'
     *ÀArchivo de Juicios de Bachillerato

       LOCAL FileMat := 'MATERIAS'+ExtFile
       LOCAL fNtxMat := ''
     *ÀArchivo de Materias

       LOCAL FileSel := 'SELE'     // Ej: SELEBTO.DAT
       LOCAL fNtxSel := 'SELE'     // Ej: SELEBTO.NEL
     *ÀArchivo de Selecci¢n de Materias

       LOCAL FilePla := 'PL'       // Ej: PLAN0695.DAT  Por Nivel
       LOCAL fNtxPla := ''                 //     PL060195.DAT  Por Grupo
     *ÀArchivo de Plan de materias a dictar por nivel

       LOCAL FileSuN := 'SUBNIVEL'+ExtFile   // Ej: SUBNIVEL.DAT
       LOCAL fNtxSuN := ''
     *ÀArchivo de Sub Plan de materias a dictar por nivel

       LOCAL FileSuG := 'SUBGRUPO'+ExtFile   // Ej: SUBGRUPO.DAT
       LOCAL fNtxSuG := ''
     *ÀArchivo de Sub Plan de materias a dictar por nivel

       LOCAL FileNot := 'NT'               // Ej: NT060195.DAT
       LOCAL fNtxNot := ''
     *ÀArchivo de Notas

       LOCAL FileHab := 'HABILITA'+ExtFile // Ej: HABILITA.DAT
       LOCAL fNtxHab := ''
     *ÀArchivo de Habilitaciones o recuperaciones.

       LOCAL FileHra := 'HORAS'+ExtFile	   // Ej: HABILI97.DAT
       LOCAL fNtxHra := ''
     *ÀArchivo de Horas

       LOCAL FileHor := 'HORARIO'+ExtFile  // Ej: HORARIO.DAT
       LOCAL fNtxHor := ''
     *ÀArchivo de Horario de Clase

       LOCAL FileFun := 'FUNCION'+ExtFile  // Ej: HABILI97.DAT
       LOCAL fNtxFun := ''
     *ÀArchivo de Horas

       LOCAL fCorBol := 'CORREBOL'+ExtFile	   // Ej: CORREBOL.DAT
     *ÀArchivo de Correci¢n de Boletines

       LOCAL fPazEst := 'PAZEST'	           // Ej: PAZEST01.DAT
     *ÀArchivo de Paz y Salvos

       LOCAL fDpzEst := 'DEUPAZ'	           // Ej: DEUPAZ01.DAT
     *ÀArchivo de Deudas del Paz y Salvo

       LOCAL FileFam := 'FAMILIA'+ExtFile	  // Ej: PAZEST01.DAT
       LOCAL fNtxFam := 'FAMILIA'+cExtNtx
     *ÀArchivo de Familias

       LOCAL FileJvf := 'Juiciosv'+ExtFile
     *ÀArchivo de Juicios Valorativos

       LOCAL FileStd := 'Estadist'+ExtFile
     *ÀArchivo de Estadisticas

       LOCAL FileSti := 'EstaIndi'+ExtFile
     *ÀArchivo de Estadisticas de indicadores

       LOCAL fColPrc := 'COLEPROC'+ExtFile         // Ej: COLEPROC.DAT
     *ÀArchivo de Colegios de Procedencia.
*>>>>FIN DECLARACION DE ARCHIVOS DEL SISTEMA

*>>>>DECLARACION DE ARCHIVOS COMPARTIDOS
	LOCAL fProTbl := 'PROF'     // Ej: PROFBTO.DAT
*       LOCAL fNtxTbl := ''
     *ÀArchivo Tabla del nivel

       LOCAL FCarPro := 'CARPRO'    // Ej: CARPRO95.DAT
       LOCAL fNtxCap := ''
     *ÀArchivo de carga academica del profesor

       LOCAL FMatPro := 'MATPRO'            // Ej: MATPRO95.DAT

       LOCAL FNotPro := ''          //  Ej: 06011601.DAT
       LOCAL fNtxNop := ''
     *ÀArchivo de notas de un curso

       LOCAL FileCli := ''
     *ÀArchivo de Clientes
*>>>>FIN DECLARACION DE ARCHIVOS COMPARTIDOS