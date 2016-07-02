/**************************************************************
*
* BLX286.H      95.06.25
*
* ANSI compatible Blinker 3.x extender API header for C/C++
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

#ifdef __cplusplus
extern "C" {
#endif

/* Type definitions */

#define BLXAPI __pascal __far

typedef unsigned char BYTE;
typedef unsigned long ULONG;
typedef unsigned long REALPTR;
typedef unsigned long __far *PULONG;
typedef unsigned short SEL;
typedef unsigned short USHORT;
typedef unsigned short __far *PSEL;
typedef unsigned short __far *PUSHORT;

typedef struct
{
   USHORT es;
   USHORT ds;
   USHORT di;
   USHORT si;
   USHORT bp;
   USHORT sp;
   USHORT bx;
   USHORT dx;
   USHORT cx;
   USHORT ax;
   USHORT ip;
   USHORT cs;
   USHORT flags;

}  REGS16;

/*
   Interrupt and exception handler definitions

   On entry to these types of functions, Borland C pushes registers
   in a different order to Microsoft, so needs a different register
   structure for the stack frame.
*/

#ifndef __BORLANDC__             /* Everyone except Borland */

typedef struct                   /* Exception frame definition */
{
   USHORT es;
   USHORT ds;
   USHORT di;
   USHORT si;
   USHORT bp;
   USHORT sp;
   USHORT bx;
   USHORT dx;
   USHORT cx;
   USHORT ax;

   USHORT exc001;                /* Reserved for internal use */
   USHORT exc002;                /* Reserved for internal use */

   USHORT error_code;
   USHORT ret_ip;
   USHORT ret_cs;
   USHORT ret_flags;

   USHORT exc003;                /* Reserved for internal use */
   USHORT exc004;                /* Reserved for internal use */

}  EXCEP_FRAME;

#else                            /* Borland only */

typedef struct                   /* Interrupt frame definition */
{
   USHORT bp;
   USHORT di;
   USHORT si;
   USHORT ds;
   USHORT es;
   USHORT dx;
   USHORT cx;
   USHORT bx;
   USHORT ax;
   USHORT ip;
   USHORT cs;
   USHORT flags;

}  REGS16BOR;

typedef struct                   /* Exception frame definition */
{
   USHORT bp;
   USHORT di;
   USHORT si;
   USHORT ds;
   USHORT es;
   USHORT dx;
   USHORT cx;
   USHORT bx;
   USHORT ax;

   USHORT exc001;                /* Reserved for internal use */
   USHORT exc002;                /* Reserved for internal use */

   USHORT error_code;
   USHORT ret_ip;
   USHORT ret_cs;
   USHORT ret_flags;

   USHORT exc003;                /* Reserved for internal use */
   USHORT exc004;                /* Reserved for internal use */

}  EXCEP_FRAME;

#endif

typedef REGS16 __far *PREGS;     /* Pointer to interrupt frame */

typedef EXCEP_FRAME __far *PEXCEP_FRAME;  /* Pointer to exception frame */

#ifndef __BORLANDC__
typedef void (__interrupt __far *PINTHAN)(REGS16 regs);
#else
typedef void (__interrupt __far *PINTHAN)(REGS16BOR regs);
#endif

typedef void (__interrupt __far *PEXCHAN)(EXCEP_FRAME regs);

/* Pointer definitions */

#ifndef MK_FP
#define MK_FP(seg, offset) (void __far *)(((unsigned long)(seg) << 16) \
                         + (unsigned long)(unsigned)(offset))
#endif

#ifndef SELECTOROF
#define SELECTOROF(p) ((SEL)(((ULONG)(p)) >> 16))
#define OFFSETOF(p) ((USHORT)(ULONG)(p))
#endif

/* Segment descriptor definitions */

typedef struct
{
   ULONG   segbase;              /* Base address in linear memory */
   ULONG   seglen;               /* Length in bytes */
   USHORT  segattrib;            /* Attributes */

}  DESC;

typedef DESC __far *PDESC;


/* API function definitions */

USHORT BLXAPI DosAllocHuge(USHORT segcount, USHORT lastsize, PSEL selector,
                           USHORT segmax, USHORT flags);
USHORT BLXAPI DosAllocRealSeg(ULONG size, PUSHORT paragraph, PSEL selector);
USHORT BLXAPI DosAllocSeg(USHORT size, PSEL selector, USHORT flags);
USHORT BLXAPI DosCreateCSAlias(SEL datasel, PSEL codesel);
USHORT BLXAPI DosCreateDSAlias(SEL codesel, PSEL datasel);
USHORT BLXAPI DosFreeRealSeg(SEL selector);
USHORT BLXAPI DosFreeSeg(SEL selector);
USHORT BLXAPI DosFreeSelector(SEL selector);
USHORT BLXAPI DosGetBIOSSeg(PSEL biossel);
USHORT BLXAPI DosGetExceptionHandler(USHORT exception, PEXCHAN __far *handler);
USHORT BLXAPI DosGetHostMode(BYTE __far * hostmode);
USHORT BLXAPI DosGetHugeShift(PUSHORT shiftcount);
USHORT BLXAPI DosGetMachineMode(BYTE __far * machinemode);
USHORT BLXAPI DosGetProtVec(int intno, PINTHAN __far *handler);
USHORT BLXAPI DosGetRealVec(int intno, REALPTR __far *handler);
USHORT BLXAPI DosGetSegBase(SEL selector, PULONG baseaddr);
USHORT BLXAPI DosGetSegDesc(SEL selector, PDESC segdesc);
USHORT BLXAPI DosGetSegLimit(SEL selector, PULONG seglimit);
USHORT BLXAPI DosIsBlinkX(void);
USHORT BLXAPI DosLockSeg(SEL selector);
USHORT BLXAPI DosMapRealSeg(USHORT paragraph, ULONG size, PSEL selector);
USHORT BLXAPI DosMemAvail(PULONG bytesavail);
USHORT BLXAPI DosRealAvail(PULONG bytesavail);
USHORT __far __cdecl DosRealFarCall(REALPTR realfn, PREGS inregs,
                           REALPTR reserved, short wordcount,...);
USHORT __far __cdecl DosRealIntr(USHORT intno, PREGS inregs, ULONG reserved,
                           short wordcount,...);
USHORT BLXAPI DosReallocHuge(USHORT segcount, USHORT lastsize, SEL selector);
USHORT BLXAPI DosReallocSeg(USHORT size, SEL selector);
USHORT BLXAPI DosSetExceptionHandler(USHORT excno, PEXCHAN newhandler,
                           PEXCHAN __far *prevhandler);
USHORT BLXAPI DosSetProtVec(USHORT intno, PINTHAN newhandler,
                           PINTHAN __far *prevhandler);
USHORT BLXAPI DosSetRealVec(USHORT intno, REALPTR newhandler,
                           REALPTR __far *prevhandler);
USHORT BLXAPI DosSetSegAttrib(SEL selector, USHORT attr);
USHORT BLXAPI DosUnLockSeg(SEL selector);
USHORT BLXAPI DosVerifyAccess(SEL selector, PUSHORT flags);
USHORT BLXAPI DosVMAvail(PULONG bytes);

/* Host modes for DosGetHostMode and BLIMGRSTS */

#ifndef BliHostNone

#define BliHostNone     0
#define BliHostDPMI     1
#define BliHostVCPI     2
#define BliHostXMS      3

#endif

/* Machine modes for DosGetMachineMode */

#define MODE_REAL       0
#define MODE_PROTECTED  1

/* Attributes for DosSetSegAttrib */

#define CODE16          1        /* Executable code and readable */
#define DATA16          2        /* Data and writeable */
#define CODE16_NOREAD   3        /* Executable code not readable */
#define DATA16_NOWRITE  4        /* Data not writeable */

/* Masks for DosVerifyAccess */

#define SEL_VALID       1        /* Selector is valid */
#define SEL_READABLE    2        /* Segment is readable */
#define SEL_WRITABLE    4        /* Segment is writable */
#define SEL_CODE        8        /* Segment is code */


#ifdef __cplusplus
}
#endif

