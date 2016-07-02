/**************************************************************
*
* BLINKER.H     95.06.25
*
* ANSI compatible Blinker 3.x function header for C/C++
*
* Copyright (C) ASM Inc, 1992 - 1995
*
***************************************************************/

/* Old pre-ANSI compilers do not recognise __cdecl etc */
/* Note: If using MSC 5.1 _MSC_VER must be explicitly set to 510 */

#ifdef _MSC_VER
   #if (_MSC_VER < 700)
      #define __cdecl      _cdecl
      #define __far        _far
      #define __interrupt  _interrupt
      #define __pascal     _pascal
   #endif
#endif

/* Blinker function prototypes */

#ifdef __cplusplus
   // prevent name mangling for C++
   extern "C" {
#endif

unsigned      __far BLICUROVL(void);
unsigned      __far BLICURSIZ(void);
unsigned      __far BLIDBGHAN(unsigned);
unsigned      __far BLIDEMCAL(unsigned);
char __far *  __far BLIDEMDTE(void);
unsigned      __far BLIDEMMIN(unsigned);
void          __far BLIDISTRC(unsigned);
unsigned      __far BLIERRNUM(void);
char __far *  __far BLIERRPRM(void);
unsigned long __far BLIMGRSTS(unsigned);
unsigned long __far BLIOVLOPS(void);
void          __far BLIOVLRES(void);
unsigned long __far BLIOVLSIZ(void);
void          __far BLIOVLSUS(unsigned);
void __far *  __far BLIPTRDEC(void __far *, long);
void __far *  __far BLIPTRINC(void __far *, long);
char __far *  __far BLISERNUM(void);
unsigned      __far BLITOTACT(void);
unsigned      __far BLITOTLOD(void);
unsigned      __far BLITOTSIZ(void);
unsigned      __far BLIVERNUM(void);

unsigned      __far SWPADDENV(unsigned);
unsigned      __far SWPADDSTR(char __far *, char __far *);
unsigned      __far SWPCURDIR(unsigned);
unsigned      __far SWPDISMSG(unsigned);
unsigned      __far SWPEMS320(unsigned);
unsigned      __far SWPERRLEV(void);
unsigned      __far SWPERRMAJ(void);
unsigned      __far SWPERRMIN(void);
unsigned      __far SWPFREEMS(unsigned);
unsigned      __far SWPFREXMS(unsigned);
unsigned      __far SWPGETKEY(unsigned);
unsigned      __far SWPGETPID(char __far *);
char __far *  __far SWPGETSTR(void);
unsigned      __far SWPKEYBRD(char __far *);
unsigned      __far SWPKEYCLR(unsigned);
unsigned      __far SWPNOBOOT(unsigned);
unsigned      __far SWPRUNCMD(char __far *, unsigned, char __far *, char __far *);
unsigned      __far SWPSETENV(char __far *);
unsigned      __far SWPSETPID(char __far *);
unsigned      __far SWPSETSTR(char __far *, char __far *);
unsigned      __far SWPUSEEMS(unsigned);
unsigned      __far SWPUSEUMB(unsigned);
unsigned      __far SWPUSEXMS(unsigned);
unsigned      __far SWPVIDMDE(unsigned);

#ifdef __cplusplus
   }
#endif

/* Function numbers for BLIMGRSTS */

#define BliCacheLoc     1        /* Get overlay cache location */
#define BliCacheSize    2        /* Get overlay cache size */
#define BliExtMemAvail  3        /* Get extended memory available */
#define BliHostMode     4        /* Get host mode */
#define BliMachineMode  5        /* Get machine mode */
#define BliOverlayLoc   6        /* Get overlay area location */
#define BliOverlaySize  7        /* Get overlay area size */
#define BliRealMemAvail 8        /* Get real memory available */
#define BliVirMemAvail  9        /* Get virtual memory available */

/* Cache locations for BLIMGRSTS */

#define BliCacheNone    0        /* No overlay cache */
#define BliCacheEMS     1        /* Overlay cache is in EMS */
#define BliCacheXMS     2        /* Overlay cache is in XMS */

/* Host modes for DosGetHostMode and BLIMGRSTS */

#ifndef BliHostNone

#define BliHostNone     0
#define BliHostDPMI     1
#define BliHostVCPI     2
#define BliHostXMS      3

#endif

/* Processor modes for BLIMGRSTS */

#define BliModeReal     0
#define BliMode286Prot  1

/* SWPMAJERR codes */

#define SWPNONERR 0              /* No error */
#define SWPDSKFUL 1              /* Disk full */
#define SWPDSKOPE 2              /* Disk file open error */
#define SWPDSKERR 3              /* Disk i/o error */
#define SWPDIRERR 4              /* Change directory error */
#define SWPCREERR 5              /* Temp file create error */
#define SWPDRVERR 6              /* Change drive error */
#define SWPEMSERR 7              /* EMS error */
#define SWPXMSERR 8              /* XMS error */
#define SWPCMDERR 9              /* SHELL error */
#define SWPHANERR 10             /* Handle table too large to save */
#define SWPMEMERR 11             /* Top of memory decreased error */
#define SWPMCBERR 12             /* MCB chain corrupt */
#define SWPMCBCNT 13             /* Too many MCBs (128 max) */
#define SWPBLKERR 14             /* DOS memory function call error */
#define SWPMEMRES 15             /* Error reallocating program segment */
#define SWPCSPERR 16             /* COMSPEC variable not found */
#define SWPINTERR 254            /* Internal error */

/* Non fatal SWPERRMIN() codes when SWPERRMAJ() = 0 */

#define SWPKILTSR 1              /* TSR was removed */
#define SWPMEMINC 2              /* Top of DOS memory increased */

/* WATCOM C/C++ defaults to passing parameters in registers */
/* so we need to force Microsoft calling conventions */

#ifdef __WATCOMC__

#pragma aux BLXMSC "_*" parm caller [] modify [ax bx cx dx es];

#pragma aux (BLXMSC) BLICUROVL;
#pragma aux (BLXMSC) BLICURSIZ;
#pragma aux (BLXMSC) BLIDBGHAN;
#pragma aux (BLXMSC) BLIDEMCAL;
#pragma aux (BLXMSC) BLIDEMDTE;
#pragma aux (BLXMSC) BLIDEMMIN;
#pragma aux (BLXMSC) BLIDISTRC;
#pragma aux (BLXMSC) BLIERRNUM;
#pragma aux (BLXMSC) BLIERRPRM;
#pragma aux (BLXMSC) BLIMGRSTS;
#pragma aux (BLXMSC) BLIOVLOPS;
#pragma aux (BLXMSC) BLIOVLRES;
#pragma aux (BLXMSC) BLIOVLSIZ;
#pragma aux (BLXMSC) BLIOVLSUS;
#pragma aux (BLXMSC) BLIPTRDEC;
#pragma aux (BLXMSC) BLIPTRINC;
#pragma aux (BLXMSC) BLISERNUM;
#pragma aux (BLXMSC) BLITOTACT;
#pragma aux (BLXMSC) BLITOTLOD;
#pragma aux (BLXMSC) BLITOTSIZ;
#pragma aux (BLXMSC) BLIVERNUM;

#pragma aux (BLXMSC) SWPADDENV;
#pragma aux (BLXMSC) SWPADDSTR;
#pragma aux (BLXMSC) SWPCURDIR;
#pragma aux (BLXMSC) SWPDISMSG;
#pragma aux (BLXMSC) SWPEMS320;
#pragma aux (BLXMSC) SWPERRLEV;
#pragma aux (BLXMSC) SWPERRMAJ;
#pragma aux (BLXMSC) SWPERRMIN;
#pragma aux (BLXMSC) SWPFREEMS;
#pragma aux (BLXMSC) SWPFREXMS;
#pragma aux (BLXMSC) SWPGETKEY;
#pragma aux (BLXMSC) SWPGETPID;
#pragma aux (BLXMSC) SWPGETSTR;
#pragma aux (BLXMSC) SWPKEYBRD;
#pragma aux (BLXMSC) SWPKEYCLR;
#pragma aux (BLXMSC) SWPNOBOOT;
#pragma aux (BLXMSC) SWPRUNCMD;
#pragma aux (BLXMSC) SWPSETENV;
#pragma aux (BLXMSC) SWPSETPID;
#pragma aux (BLXMSC) SWPSETSTR;
#pragma aux (BLXMSC) SWPUSEEMS;
#pragma aux (BLXMSC) SWPUSEUMB;
#pragma aux (BLXMSC) SWPUSEXMS;
#pragma aux (BLXMSC) SWPVIDMDE;

#endif

