/*

    96.03.15    Blinker extender API demonstration program

*/

#include <dos.h>
#include <process.h>
#include <stdio.h>
#include <string.h>

#include <blinker.h>
#include <blx286.h>

#define VID_BUF 0xB800
#define VID_SIZE 0x8000l

void DumpFlags(SEL sel)
{
   /* Dumps an interpreted version of the segment attribute */

   USHORT flags;
   if (DosVerifyAccess(sel, &flags) == 0)
      if (flags & SEL_VALID)         /* is a valid selector */
         {
         if (flags & SEL_READABLE)
               printf ("READABLE ");
         if (flags & SEL_WRITABLE)
               printf ("WRITABLE ");
         if (flags & SEL_CODE)
               printf ("EXECUTABLE");
         printf ("\n");
         }
      else
         printf ("NOT A SELECTOR\n");
}

void apitsterr (char *apierrmsg)
{
   printf ("\n%s\n%c",apierrmsg,7);
   exit (255);
}

void main (void)
{
   BYTE     host_mode;
   BYTE     ProcMode;
   USHORT   para;
   SEL      bios_sel,selbase;
   USHORT   video_buffer;
   USHORT   hshift;
   DESC     desc_buf;
   int      selinc;
   ULONG    realvec;
   PINTHAN  protvec;
   SEL      tmpsel;
   USHORT   cnt,x;
   void     *fp;
   REGS16   regs;

   printf ("\nAPITST 1.0 Blinker extender API test program");
   printf ("\n--------------------------------------------\n\n");

   if (DosIsBlinkX() == 0)
      printf ("Not running under the Blinker DOS extender\n");

   if (DosGetMachineMode(&ProcMode) == 0)
      {
      printf ("The processor is in ");
      switch (ProcMode)
         {
         case MODE_REAL :
            printf ("real mode/V86 mode\n");
            break;
         case MODE_PROTECTED :
            printf ("286 Protected mode\n");
            break;
         default:
            printf ("another mode - interesting\n");
            exit (255);
         }
      }


   if(DosGetHostMode(&host_mode) == 0)
      {
      printf ("The true host is ");
      switch(host_mode)
         {
         case BliHostNone :
            printf ("(none)\n");
            break;
         case BliHostDPMI :
            printf ("DPMI\n");
            break;
         case BliHostVCPI :
            printf ("VCPI\n");
            break;
         case BliHostXMS :
            printf ("XMS\n");
            break;
         default :
            printf ("Unknown\n");
         }
      }

   printf ("\nBlinker Status functions\n");
   printf ("------------------------\n");
   printf ("Total Extended memory available : %08ld bytes\n",
          BLIMGRSTS(BliExtMemAvail));
   printf ("Total Virtual memory available  : %08ld bytes\n",
          BLIMGRSTS(BliVirMemAvail));
   printf ("Total Real memory available     : %08ld bytes\n",
          BLIMGRSTS(BliRealMemAvail));
   printf ("Host mode                       : %02ld\n",
          BLIMGRSTS(BliHostMode));
   printf ("Machine Mode                    : %02ld\n",
          BLIMGRSTS(BliMachineMode));
   printf ("Overlay pool location           : %p\n",
          BLIMGRSTS(BliOverlayLoc) << 12);
   printf ("Overlay pool size               : %06ld bytes\n",
          BLIMGRSTS(BliOverlaySize));
   printf ("Overlay cache location          : %02ld\n",
          BLIMGRSTS(BliCacheLoc));
   printf ("Overlay cache size              : %06ld bytes\n\n",
          BLIMGRSTS(BliCacheSize));

   printf ("Demonstration date              : %s\n",
          BLIDEMDTE( ));
   printf ("Demonstration minutes           : %04d\n",
          BLIDEMMIN((unsigned) -1));
   printf ("Error number                    : %04d\n",
          BLIERRNUM( ));
   printf ("Error parameter                 : %s\n",
          BLIERRPRM( ));
   printf ("Overlay pool size               : %06ld bytes\n",
          BLIOVLOPS( ));
   printf ("Current overlay pool size       : %06ld bytes\n",
          BLIOVLSIZ( ));
   printf ("Serial number                   : %s\n",
          BLISERNUM( ));

   /* Get a selector that corresponds to the screen buffer */

   if (DosMapRealSeg (VID_BUF, VID_SIZE,&video_buffer) != 0)
      apitsterr ("Unable to map screen segment");

   printf ("\nSelector for video buffer   : %04X\n\n",video_buffer);

   if (DosGetSegDesc(video_buffer,&desc_buf) == 0)
      {
      printf ("Video buffer descriptor\n");
      printf ("-----------------------\n");
      printf ("Base address : %08lX\n",desc_buf.segbase);
      printf ("Length       : %08lX\n",desc_buf.seglen);
      printf ("Attributes   : %04X\n\n",desc_buf.segattrib);
      }

   /* Get a selector for the Bios Data area */
   if (DosGetBIOSSeg(&bios_sel) !=0)
      apitsterr ("Unable to get descriptor for BIOS data area\n");

   printf ("Selector for BIOS data area : %04X\n\n",bios_sel);
   if (DosGetSegDesc(bios_sel,&desc_buf) == 0)
      {
      printf ("BIOS data area descriptor\n");
      printf ("-------------------------\n");
      printf ("Base address : %08lX\n",desc_buf.segbase);
      printf ("Length       : %08lX\n",desc_buf.seglen);
      printf ("Attributes   : %04X\n\n",desc_buf.segattrib);
      }

   /* Allocate a 17KB block in REAL memory */

   if (DosAllocRealSeg((16L << 10), &para, &selbase) != 0)
      apitsterr ("DosAllocRealSeg() failed");

   printf ("16kb real mode memory allocated at : %04X\n",para);
   printf ("Protected mode selector for block  : %04X\n\n",selbase);

   if (DosGetSegDesc(selbase,&desc_buf) == 0)
      {
      printf ("Real memory block descriptor\n");
      printf ("-----------------------------\n");
      printf ("Base address : %08lX\n",desc_buf.segbase);
      printf ("Length       : %08lX\n",desc_buf.seglen);
      printf ("Attributes   : %04X\n\n",desc_buf.segattrib);
      }

   if (DosFreeRealSeg(selbase)==0)
      printf ("Freed real segment selector %04X\n\n",selbase);
   else
      printf ("Unable to free real segment\n");

   if (DosLockSeg (SELECTOROF (main)) != 0)     /* Must lock before aliasing */
      apitsterr ("DosLockSeg() failed");

   if (DosCreateDSAlias (SELECTOROF (main), &selbase) != 0)
      apitsterr ("DosCreateDSAlias() failed");

   printf ("Code selector for main() is : %04X\n",SELECTOROF (main));
   printf ("Data alias selector is      : %04X\n",selbase);
   printf ("Code selector flags         : "); DumpFlags(SELECTOROF(main));
   printf ("Data alias selector flags   : "); DumpFlags(selbase);
   printf ("Sel FFFFh flags (invalid!)  : "); DumpFlags(0xffff);
   printf ("\n");

/* Comment out so that create CSAlias can work

   if (DosFreeSelector(selbase) != 0)
      printf ("Unable to free DATA alias\n");
   else
      printf ("Data Alias freed\n");
*/

   if (DosLockSeg (selbase) != 0)               /* Must lock before aliasing */
      apitsterr ("DosLockSeg() failed");

   if (DosCreateCSAlias (selbase, &tmpsel) != 0)
      apitsterr ("DosCreateCSAlias() failed");

   printf ("Code alias of data alias    : %04X\n",tmpsel);
   printf ("Code alias flags            : "); DumpFlags(tmpsel);
   if (DosGetSegDesc(tmpsel,&desc_buf) == 0)
      {
      printf ("\nCode alias descriptor\n");
      printf ("---------------------\n");
      printf ("Base address : %08lX\n",desc_buf.segbase);
      printf ("Length       : %08lX\n",desc_buf.seglen);
      printf ("Attributes   : %04X\n\n",desc_buf.segattrib);
      }

   if (DosGetSegDesc(SELECTOROF(main),&desc_buf) == 0)
      {
      printf ("Descriptor for main() code segment\n");
      printf ("----------------------------------\n");
      printf ("Base address : %08lX\n",desc_buf.segbase);
      printf ("Length       : %08lX\n",desc_buf.seglen);
      printf ("Attributes   : %04X\n\n",desc_buf.segattrib);
      }

   DosGetHugeShift(&hshift);                    /* Get the shift */
   selinc = 1 << hshift ;
   printf ("Selector shift for huge segments %04X\n",hshift);
   printf ("     Increment for huge segments %04X\n\n",selinc);

   printf ("Interrupt vectors\n");
   printf ("-----------------\n");
   for (cnt=0; cnt < 5; cnt++)
      if (DosGetRealVec(cnt,&realvec) == 0)
         if (DosGetProtVec(cnt,&protvec) == 0)
            printf ("Int %02X  real @ %p  prot @ %p\n",cnt,realvec,protvec);

   printf ("\nExecute real mode interrupt (DOS Get Time)\n");
   printf ("--------------------------------------------\n");

   memset(&regs, 0, sizeof(REGS16)) ;          /* Important: clear to zero */
   regs.ax = 0x2c00 ;                          /* DOS Get Time */

   if (DosRealIntr(0x21,&regs,0L,0) == 0)
      {
/*
      printf ("AX = %04x, BX = %04x CX = %04x DX = %04x\n",
         regs.ax,regs.bx,regs.cx,regs.dx);
      printf ("SI = %04x, DI = %04x SP = %04x BP = %04x\n",
         regs.si,regs.di,regs.sp,regs.bp);
      printf ("ES = %04x, DS = %04x FL = %04x          \n",
         regs.es,regs.ds,regs.flags);
*/

      if (regs.flags & 0x0001 )
         apitsterr ("DOS call returned with carry set");
      else
         {
         printf ("Time is %02d:%02d:%02d.%02d\n\n",
                 regs.cx >> 8 ,regs.cx & 0xff,regs.dx >> 8, regs.dx & 0xff);
         printf ("Note: Normally there is no need to call this, or most\n");
         printf ("other DOS int 21 calls from real mode - they are fully \n");
         printf ("supported in protected mode. This example serves only to \n");
         printf ("illustrate how real mode interrupts are called.\n");
         }
      }

   printf ("\nAllocate protected mode memory\n");
   printf ("--------------------------------\n");

   if (DosAllocSeg(3072,&tmpsel,0) != 0)
      apitsterr ("DosAllocSeg() failed");
   else
      {
      printf ("Allocated 3KB block : %04X\n\n",tmpsel);
      if (DosGetSegDesc(tmpsel,&desc_buf) == 0)
         {
         printf ("Block descriptor\n");
         printf ("----------------\n");
         printf ("Base address : %08lX\n",desc_buf.segbase);
         printf ("Length       : %08lX\n",desc_buf.seglen);
         printf ("Attributes   : %04X\n\n",desc_buf.segattrib);
         }

      if (DosLockSeg(tmpsel) != 0)
         printf ("Block not locked : %04X\n",tmpsel);
      else
         {
         printf ("Block locked   : %04X\n",tmpsel);
         if (DosLockSeg(tmpsel) == 0)
            printf ("Block locked   : %04X\n",tmpsel);
         }

      if (DosUnLockSeg(tmpsel) != 0)
         printf ("Block not unlocked : %04X\n",tmpsel);
      else
         {
         printf ("Block unlocked : %04X\n",tmpsel);
         if (DosUnLockSeg(tmpsel) == 0)
            printf ("Block unlocked : %04X\n",tmpsel);
         }

      x = DosReallocSeg(16384,tmpsel);          /* Save result */

      if (x == 0)
         if (DosGetSegDesc(tmpsel,&desc_buf) == 0)
            {
            printf ("\nReallocated block to 16384 bytes : %04X\n\n",tmpsel);
            printf ("Block descriptor\n");
            printf ("----------------\n");
            printf ("Base address : %08lX\n",desc_buf.segbase);
            printf ("Length       : %08lX\n",desc_buf.seglen);
            printf ("Attributes   : %04X\n\n",desc_buf.segattrib);
            }
         else
            printf ("DosGetSegDesc() failed\n");
      else
         printf ("Unable to reallocate block %04X\n",tmpsel);

      if (DosFreeSeg(tmpsel) !=0 )
         printf ("Unable to free Prot mode memory block\n");
      else
         printf ("Prot mode memory block freed: %04X\n",tmpsel);
      }

   /* Allocate 256KB block that can be reallocated to 1MB */

   if (DosAllocHuge(4,0,&selbase,16,0) != 0)
      apitsterr ("DosAllocHuge() failed");

   printf ("\nAllocated a 256KB block starting at selector %04X\n",selbase);
   printf ("            for each subsequent selector add %04X\n\n",selinc);

   printf ("Sel  Base     Length   Attr\n");
   printf ("---------------------------\n");

   /* Fill each 64K block with NULLS */

   for (cnt = 1, tmpsel=selbase; cnt <= 4; cnt++, tmpsel+= selinc)
      {
      fp = MK_FP(tmpsel,0);
      memset(fp, 0, 0xFFFF);                    /* Not the last byte */
      if (DosGetSegDesc(tmpsel,&desc_buf) == 0)
         printf ("%04X %08lX %08lX %04X\n",
              tmpsel,desc_buf.segbase ,desc_buf.seglen, desc_buf.segattrib);
      }

   if (DosReallocHuge(6,0,selbase) != 0)        /* Reallocate the block to 384 Kb */
      printf ("\nAttempt to reallocate block to 384 Kb failed");
   else
      {
      printf ("\nReallocated block to 384 Kb\n\n");

      /* Fill each block with NULLS */

      printf ("Sel  Base     Length   Attr\n");
      printf ("---------------------------\n");

      for (cnt = 1, tmpsel=selbase; cnt <= 6; cnt++, tmpsel+= selinc)
         {
         if (DosGetSegDesc(tmpsel, &desc_buf) == 0)
            {
            fp = MK_FP(tmpsel,0);
            if (desc_buf.seglen == 0x10000l)    /* Check for a 64K segment */
               memset(fp, 0, 0xFFFF);           /* Can't do the last byte */
            else
               memset(fp, 0, (int) desc_buf.seglen);
            printf ("%04X %08lX %08lX %04X -> %4dkb  ",
               tmpsel,desc_buf.segbase ,desc_buf.seglen, desc_buf.segattrib,cnt*64);
            DumpFlags(tmpsel);
            }
         }
      }

   if (DosFreeSeg(selbase) != 0)                /* Free the block */
      apitsterr ("DosFreeSeg() failed");
   else
      printf ("\nFreed huge block at : %04X\n",selbase);

   exit (0);
}

