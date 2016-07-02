// FPATH library for FoxPro API
//
// This is a library of string handling routines for manipulating DOS
// strings, filenames and pathnames.  It should be compiled with the Large 
// memory model.
//--------------------------------------------------------------------------
//
//	To compile for a Windows FLL #define fpathw and remove or comment
//	#define fpathdos.  To compile for a DOS PLB #define fpathdos and remove
//	or comment #define fpathw.
//
#define fpathw
//#define fpathdos

#ifdef fpathw
   #undef  fpathdos
#endif
#ifdef fpathdos
   #undef  fpathw
#endif

#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

#ifdef fpathw
   #include <windows.h>
   #include <commdlg.h>
#endif

#include "pro_ext.h"
//--------------------------------------------------------------------------
#define   MAXPATH         256          /*    maximum path length          */
#define   MAXSTRING      1024          /*    maximum string length        */
#define   DFTBREAK       " \t\n"       /*    default break string         */
#define   MAXBREAK        256          /*    maximum break string length  */
#define   MAXWORD         256          /*    maximum length of return word*/
#define   BOOL            int
//==========================================================================
MHANDLE gethandle(ParamBlk FAR *parm, int pnum)
//--------------------------------------------------------------------------
//
// Returns an MHANDLE to a copy of the string passed in parameter pnum of
// parm.  This function null-terminates the handle also.  It is useful 
// for functions that expect to see character data, but don't know whether
// the data will be passed by value or reference, or through a memo field.
//
// Author:  Walter J. Kennamer
// History: Initially written November 25, 1991
//--------------------------------------------------------------------------
{
   Value FAR *v, FAR *memvarvalue;
   Value valbuffer;
   Locator FAR *varlocate;
   int errcode       = 0;
   MHANDLE t;

   // Various types for managing memo fields
   int memchan;       // memo file channel
   long int memsize, memread, memseek, memfind;
   MHANDLE memohand = 0;

   v = &parm->p[pnum].val;
   if (v->ev_type == 'C') {
      if ((t = _AllocHand(v->ev_length+1)) == 0) {
         _Error(182);   // insufficient memory
         }
      _HLock(t);
      _HLock(v->ev_handle);
      _MemMove(_HandToPtr(t),_HandToPtr(v->ev_handle),v->ev_length);
      _HUnLock(v->ev_handle);
      *((char FAR *)_HandToPtr(t) + v->ev_length) = '\0';
      _HUnLock(t);
      return t;
   }
   else if (v->ev_type == 'R') { 
      // This parameter was passed by reference.  See what kind it is.
      varlocate  = &parm->p[pnum].loc;
      if ( varlocate->l_where > 0 ) {
         // since it has a file channel, it's a memo field
         memchan = _MemoChan(varlocate->l_where);

         if ((memfind = _FindMemo(varlocate)) < 0)  // find the memo file offset 
            _Error(-(int)memfind);

         memsize = _MemoSize(varlocate);        // find the memo size
         if (memsize < 0) 
            _UserError("Invalid memo size\n");
         if (memsize > 0x7FFFL)
            _UserError("Memo is too large for FPATH function--32K limit");
            
         memseek = _FSeek(memchan,memfind,0);    // move the file pointer

         // Allocate enough memory to read in the memo field 
         memohand  = _AllocHand((unsigned int)memsize+1);
         if (memohand == 0) 
            _Error(182);    // insufficient memory
         // Read the memo into our handle
         memread = _FRead(memchan,_HandToPtr(memohand),(int)memsize);
         if (memread != memsize)
            _UserError("Error reading memo field\n");

         // Make sure the handle is null-terminated
         *((char FAR *)_HandToPtr(memohand) + memsize) = '\0';
         return memohand;
      }
      else {
         // This is some other kind of memory variable passed by reference.
         // It is not a memo field.  Store it into a value structure so 
         // that we can learn its secrets.
         memvarvalue = &valbuffer;
         if ( (errcode = _Load(varlocate,memvarvalue)) != 0)
            _Error(-errcode);
     
         if (memvarvalue->ev_type == 'C') {
            // This is a character string. 
     
            // Make the handle large enough to hold the terminating null
            if (!_SetHandSize(memvarvalue->ev_handle,memvarvalue->ev_length+1)) {
               _Error(182);
            }
     
            // Null-terminate the handle
            *((char FAR *)_HandToPtr(memvarvalue->ev_handle) 
               + memvarvalue->ev_length) = '\0';
     
            return memvarvalue->ev_handle;
         }
         else {
            // Something passed by reference other than char or memo
            _FreeHand(memvarvalue->ev_handle);
            return 0;
         }
      }
   }
   else {
      // Something passed by value other than char
      return 0;
   }
     
}
//--------------------------------------------------------------------------
char FAR *k_replicate(char FAR *strg, int num, char FAR *outstr)
//
// This procedure is for internal use within FPATH.  It produces an 
// output string "outstr" composed of "num" repititions of "strg".  "strg"
// is unchanged.  Outstr must be large enough to hold the string or 
// memory corruption will result.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   int i;

   *outstr = '\0';
   for(i = 1 ; i <= num ; i++)
      _fstrcat(outstr,strg);
   return(outstr);
}
//--------------------------------------------------------------------------
char FAR *k_spaces(int num, char FAR *outstr)
//
// This procedure is for internal use within FPATH.  It returns a 
// string of num spaces as outstr.  outstr must be big enough to
// hold the result or memory corruption can result.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   _MemFill(outstr,' ',num);
   *(outstr+num) = 0;
   return(outstr);
}
//--------------------------------------------------------------------------
char FAR *k_delete(char FAR *instrg, int num, char FAR *outstr)
//
// This procedure is for internal use within FPATH.  It deletes the
// first num bytes from the string pointed to by strg, copying the 
// results into outstr.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   _StrCpy(outstr,instrg);
   if(_StrLen(outstr) <= num)    // zap string if it is shorter than num
      *outstr = '\0';
   else 
      if(num > 0)                // move string left by num positions
         _MemMove(outstr,outstr+num,_StrLen(outstr+num)+1);
   return(outstr);
}
//--------------------------------------------------------------------------
char FAR *k_insert(char FAR *instrg1, char FAR *insstrg2 , char FAR *outstr)
//
// This procedure is for internal use within FPATH.  It inserts the
// insstrg at the first position in strg.  
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   int inslen = 0;

   _MemMove(outstr,instrg1,_StrLen(instrg1)+1);
   inslen = _StrLen(insstrg2);

   if(inslen > 0) {
      // move strg to the right by inslen places.
      _MemMove(outstr+inslen,outstr,_StrLen(outstr)+1);

      // Put the insert string where strg points.
      _MemMove(outstr,insstrg2,inslen);
   }
   return(outstr);
}
//--------------------------------------------------------------------------
char FAR *k_rtrim(char FAR *p , char FAR *outstr)
//
// This procedure is for internal use within FPATH.  It trims trailing
// white space from the string pointed to by p.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char FAR *q;

   _MemMove(outstr,p,_StrLen(p)+1);
   q = outstr+_StrLen(outstr)-1;
   while ((isspace(*q)) && (q >= outstr))
      q--;
   *(++q) = '\0';
   return(outstr);
}

//--------------------------------------------------------------------------
char FAR *k_ltrim(char FAR *p , char FAR *outstr)
//
// This procedure is for internal use within FPATH.  It trims leading
// white space from the string pointed to by p.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   int i = 0;

   _MemMove(outstr,p,_StrLen(p)+1);
   while ( isspace(*(outstr+i)) )
      i++;
   if(i > 0) {                        // move everything left by i positions
      _MemMove(outstr,outstr+i,_StrLen(outstr)-i+1);
      }
   return(outstr);
}
//--------------------------------------------------------------------------
char FAR *k_alltrim(char FAR *p, char FAR *outstr)
//
// This procedure is for internal use within FPATH.  It trims leading
// and trailing white space from the string pointed to by p.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char FAR *lead, FAR *trail;

   *outstr = 0;
   // count leading spaces
   for (lead = p ; *lead && isspace(*lead); lead++) 
      ;
   if (*lead) {   // it isn't all white space or empty
      // count trailing spaces
      for (trail = p+_StrLen(p)-1 ; trail > p && isspace(*trail); trail--) 
         ;
      _MemMove(outstr,lead,(unsigned int)(trail - lead) + 1);
      *(outstr + (unsigned int) (trail - lead) + 1 ) = 0;
      }
   return(outstr);
}

//--------------------------------------------------------------------------
char FAR *k_upper(char FAR *p, char FAR *outstr)
//
// This procedure is for internal use within FPATH.  It converts the 
// string pointed to by p to upper case.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   _MemMove(outstr,p,_StrLen(p)+1);
   return _fstrupr(outstr);
}

//--------------------------------------------------------------------------
char FAR *k_padr(char FAR *p, int num , char FAR *outstr)
//
// This procedure is for internal use within FPATH.  It pads the p
// string to length num with spaces.  outstr must be big enough to hold 
// the entire string or memory corruption may result.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   int plen = _StrLen(p);

   _MemMove(outstr,p,_StrLen(p)+1);
   if(plen < num) {
      _MemFill(outstr+plen,' ',num-plen);
      *(outstr+num) =0;
      }
   return(outstr);
}
//--------------------------------------------------------------------------
char FAR *k_padl(char FAR *p, int num, char FAR *outstr)
//
// This procedure is for internal use within FPATH.  It lead pads the p
// string to length num with spaces.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   int plen = _StrLen(p);

   _MemMove(outstr,p,_StrLen(p)+1);
   if(plen < num) {
      // Move the string to the right to create space
      _MemMove(outstr+(num-plen),outstr,plen+1);
      // Fill the newly created room with space chars
      _MemFill(outstr,' ',num-plen);
      }
   return(outstr);
}

//--------------------------------------------------------------------------
char FAR *k_reduce(char FAR *instrg, char FAR *bkstr, 
                   char FAR *outstr, int skipquotes)
//
// This procedure is for internal use within FPATH.  It returns 
// "instrg" unchanged, and "outstr" as with duplicate white space 
// (defined by characters in "bkstr") reduced to a single space.
// This function does not modify "instrg" or "bkstr".
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char FAR *p, FAR *q;

   q = outstr;

   // skip opening white space
   for(p = instrg ; *p && isspace(*p) ; p++)
      ;

   while(*p) {
      if(skipquotes) {
         if(*p == '"') {                // skip over double quotes
            do
              *q++ = *p++;
            while(*p && *p != '"');
            *q++ = *p++;                // skip past closing quote
            }
         if(*p == 39) {                 // skip over single quotes
            do
               *q++ = *p++;
            while(*p && *p != 39);
            *q++ = *p++;                // skip past closing quote
            }
         }

      if(_fstrchr(bkstr,*p) == NULL) {
         *q++ = *p++;
         }
      else if ( *(p+1) != '\0' && (_fstrchr(bkstr,*(p+1)) == NULL) )  {
         // replace any break character with a space
         *q++ = ' ';
         p++;
         }
      else {
         p++;                         // always advance p
         }
      }

   *q = '\0';

   // trim off closing spaces
   q = outstr + _StrLen(outstr) - 1;   // last non-0 character
   while( isspace(*q) && q <= outstr)
      --q;
   *(q+1) = 0;

   return(outstr);
}
//--------------------------------------------------------------------------
int k_occurs(char FAR *strg, char chr)
//
// This procedure is for internal use within FPATH.  It counts the
// number of "chr" characters in "strg."
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   int i;

   for(i = 0 ; *strg ; strg++)
      if(*strg == chr)
    i++;
   return(i);
}
//--------------------------------------------------------------------------
int k_at(char FAR *strg, char chr)
//
// This procedure is for internal use within FPATH.  It returns
// the byte number (starting with 1) of the first occurrence of chr 
// in strg, or 0 if chr is not found in strg.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char FAR *p;
   p = _fstrchr(strg,chr);
   if (p != NULL)
      return(p-strg+1);
   else
      return(0);
}
//--------------------------------------------------------------------------
int k_rat(char FAR *strg, char chr)
//
// This procedure is for internal use within FPATH.  It returns
// the byte number (starting with 1) of the last occurrence of chr 
// in strg, or 0 if chr is not found in strg.
//
// Author:  Walter J. Kennamer
// History: Initially written May 25, 1991
//--------------------------------------------------------------------------
{
   char FAR *p;
   p = _fstrrchr(strg,chr);
   if (p != NULL)
      return(p-strg+1);
   else
      return(0);
}
//--------------------------------------------------------------------------
char FAR *k_stralltran(char FAR *strg,   char FAR *source, 
             char FAR *target, char FAR *outstr)
//
// This procedure is for internal use within FPATH.  It converts 
// all occurrences of the source string to the target string.  
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char FAR *p;
   int srclen  = _StrLen(source);
   int targlen = _StrLen(target);

   _MemMove(outstr,strg,_StrLen(strg)+1);

   if(srclen == 0) {
      // nothing to translate--just return the string
      return (outstr);
      }

   p = outstr;

   while(p != NULL && *p) {
      p = _fstrstr(p,source);
      if(p != NULL) {
         // delete the source string.
         _MemMove(p,p+srclen,_StrLen(p+srclen)+1);

         // make room for the target.  Make sure to move the 0 too.
         _MemMove(p+targlen,p,_StrLen(p)+1);

         // put the target into p
         _MemMove(p,target,targlen);

         p = p + _StrLen(target);            // advance past the target
         }
      }
   return(outstr);
}
//--------------------------------------------------------------------------
char FAR *k_chrtran(char FAR *strg, char FAR *source, 
          char FAR *target, char FAR *outstr)
//
// This procedure is for internal use within FPATH.  It converts 
// characters in source to their corresponding character in target.  If
// there is no corresponding character in target, the source character
// is deleted.  Strg, source and target are left unchanged.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char FAR *p;
   unsigned long int srcpos  = 0;
   unsigned long int srclen  = _StrLen(source);
   unsigned long int targlen = _StrLen(target);
   unsigned long int outlen  = _StrLen(outstr);

   _MemMove(outstr,strg,_StrLen(strg)+1);
   if (srclen == 0)
      return(outstr);

   p = outstr;
   while(p != NULL && *p) {
      p = strpbrk(p,source);         // find anything in source string
      if(p != NULL) {
         srcpos = k_at(source,*p);   // get position in source string
         if( (targlen > 0) && (targlen >= srcpos)) {
            // replace from target
            *p = *(target + srcpos - 1);
            p++;
            }
         else {
            // delete a character
            _MemMove(p,p+1,_StrLen(p+1)+1);
            --outlen;
            }
         }
      }
   return(outstr);
}
//--------------------------------------------------------------------------
char FAR *k_strfilter(char FAR *strg, char FAR *source, char FAR *outstr)
//
// This procedure is for internal use within FPATH.  It deletes all
// characters in "strg" that are not found in "source".  It writes its
// output to "outstr".
//
// Author:  Walter J. Kennamer
// History: Initially written June 10, 1991
//--------------------------------------------------------------------------
{
   char FAR *p, *q;
   q = outstr;
   for (p = strg ; *p ; p++)
      if ( strchr(source,*p) != NULL)
        *q++ = *p;
   *q =  '\0';
   return(outstr);
}

//--------------------------------------------------------------------------
char FAR *k_stuff(char FAR *strg, int startpos, int delchars,
        char FAR *stuffstr, char FAR *outstr)
//
// This procedure is for internal use within FPATH.  It stuffs 
// "stuffstr" into "strg" at position "startpos" and replaces
// "delchars" characters.  The output string is stored in "outstr".
//
// Author:  Walter J. Kennamer
// History: Initially written June 22, 1991
//--------------------------------------------------------------------------
{
   _MemMove(outstr,strg,_StrLen(strg)+1);
   if (delchars == 0 && _StrLen(stuffstr) == 0)
      return(outstr);

   --startpos;   // map to 0 base
   if(startpos >= 0 && startpos < _StrLen(strg)) {
      if (delchars > 0)
         // delete the "delchars"
         _MemMove(outstr+startpos,outstr+startpos+delchars,_StrLen(outstr+startpos)+1);

      if (_StrLen(stuffstr) > 0) {
         // move string to right to make room for target
         _MemMove(outstr+startpos+_StrLen(stuffstr),outstr+startpos,_StrLen(outstr+startpos)+1);

         // copy in the stuff string
         _MemMove(outstr+startpos,stuffstr,_StrLen(stuffstr));
         }
      }
   return(outstr);
}
//--------------------------------------------------------------------------
int k_words(char FAR *strg, char FAR *bkstr)
//
// This procedure is for internal use within FPATH.  It counts the 
// "words" in strg.  A word is delimited with any character in bkstr.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char FAR *p;
   int wordcount = 0;

   // skip opening white space
   for (p = strg ; *p && _fstrchr(bkstr,*p) != NULL ; p++) ;

   if (*p) {
      wordcount = 1;  // count the one we are in now
      // count transitions from "not in word" to "in word"
      // if the current character is a break char, but the next one
      // is not, we've entered a new word.
      for (; *p ; p++ ) {
         if( *(p+1) && _fstrchr(bkstr,*p) != NULL 
                    && _fstrchr(bkstr,*(p+1)) == NULL) {
            wordcount++;
            p++;    // Skip over the first character in the word
                    // We know it can't be a break character.
            }
         }
       }
   return(wordcount);
}
//--------------------------------------------------------------------------
char FAR *k_nextword(char FAR *strg, int index, 
           char FAR *bkstr, char FAR *outstr)
//
// This procedure is for internal use within FPATH.  It returns the
// next word in "strg" beginning at position "index."  Words are 
// defined as characters delimited by anything in "bkstr."  The 
// next word is returned as the function value and also stored in 
// "outstr." 
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char FAR *p,
   FAR *startstr;

   outstr = '\0';   // assume there isn't one

   // skip opening break characters
   p = strg + index - 1;
   while((strchr(bkstr,*p) != NULL) && *p)
      p++;

   if(*p) {
      startstr = p;
      p = strpbrk(p,bkstr);         // find next break string char
      if(p != NULL) {
         *p = '\0';
         // Protect against returning too many characters
         if (_StrLen(startstr) > MAXWORD) {
            *(startstr + MAXWORD) = 0;
            }
         _StrCpy(outstr,startstr);
         }
      else {   // nextword is the last word in the string
         // Protect against returning too many characters
         if (_StrLen(startstr) > MAXWORD) {
            *(startstr + MAXWORD) = 0;
            }
         }
      _StrCpy(outstr,startstr);
      }
   return(outstr);
}

//--------------------------------------------------------------------------
char FAR *k_nextwordptr(char FAR *strg, char FAR *bkstr, 
         char FAR *nword, char FAR *outp)
//
// This procedure is for internal use within FPATH.  It returns the
// first word in "strg".  Words are defined as characters delimited by 
// anything in "bkstr."  The next word is returned as the function value 
// and also stored in "nword."  "outp" contains a pointer just past
// the word returned.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char FAR *q;
   int  wordlen = 0;

   *nword = 0;   // assume there isn't one

   // skip opening break characters
   outp = strg;
   while((strchr(bkstr,*outp) != NULL) && *outp)
      outp++;

   if( *outp ) {
      q = _fstrpbrk(outp,bkstr);
      if(q == NULL) {
         q = outp + _StrLen(outp);   // now points to the zero
         }
      _fstrncpy(nword,outp,min(q-outp,MAXWORD));
      wordlen = min(q - outp, MAXWORD);
      *(nword + wordlen) = 0;
      }
   outp = q;
   return(nword);
}
//--------------------------------------------------------------------------
char FAR *k_wordnum(char FAR *strg, int num, 
          char FAR *bkstr, char FAR *outstr)
//
// This procedure is for internal use within FPATH.  It returns the
// "numth" word in strg, delimited by characters in bkstr, and puts the
// word in outstr also.  "strg" is unchanged by this procedure.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   int i, outlen;

   char FAR *p, FAR *q, FAR *end_of_string;

   *outstr = 0;    // assume no such word
   p       = strg;

   end_of_string = p + _StrLen(p);

   for (i = 1; i <= num ; i++) {
      // Skip opening break characters, if any
      for ( ; *p && _fstrchr(bkstr,*p) != NULL ; p++)
         ;
      if (*p == 0)
         break;

      // find next break character--it marks the end of this word
      q = _fstrpbrk(p,bkstr);
      if(q == NULL) {
         q = end_of_string;   // now points to the zero
         }

      // This is the actual word we are looking for.  Copy it.
      if (i == num) {
         _fstrncpy(outstr,p,min(q-p,MAXWORD));
         outlen = min(q - p, MAXWORD);
         *(outstr + outlen) = 0;
         break;
         }
      p = q++;

      if (p >= end_of_string)
         return(outstr);
   }
   return(outstr);
}
//--------------------------------------------------------------------------
char FAR *k_fctnparm(char FAR *strg, int index, char FAR *outstr)
//
// This procedure is for internal use within FPATH.  It returns the
// index-th parameter from a function paramter list, accounting for
// quotations and parenthetical expressions.  It returns the parameter
// as "outstr."  For example, assume that strg is:
//      CHRTRAN(foo,", ",'a')
// k_fctnparm(strg,3,outstr) would return 'a'.  Note that it 
// accounted for the comma inside the second parameter--quoted string ", ".
// This function leaves "strg" unchanged.
//
// Author:  Walter J. Kennamer
// History: Initially written May 22, 1991
//--------------------------------------------------------------------------
{
   int parencount  = 1,
       comma_count = 0,
       slen = _StrLen(strg);
   char FAR *p,
   FAR *strstart;
   MHANDLE temp;

   // Assume that there is not an index-th parameter
   *outstr = '\0';

   if(index != 0 || slen != 0) {
      if ( (temp = _AllocHand(slen + 1)) == 0) {
        _Error(182);   // insufficient memory
        }
      _HLock(temp);
      _StrCpy(_HandToPtr(temp),strg);
      p = strchr(_HandToPtr(temp),'(');
      if( p != NULL) {
         p++;   // skip past opening parenthesis

         // Advance through the string until you reach the index-th 
         // parameter.
         while(*p && (comma_count < index - 1) && (parencount > 0)) {
            if( (*p == ',') && (parencount == 1))
               comma_count++;
            else if (*p == '(' )
               parencount++;
            else if( *p == ')' )
               parencount--;
            else if( *p == '"') {           // skip over double quote marks
               p++;
               while (*p && *p != '"')
                  p++;
               }
            else if( (int)*p == 39) {       // skip over single quote marks
               p++;
               while (*p && (int)*p != 39) 
                  p++;
               }
            p++;
            }
         strstart = p;     // output string begins at position p

         // Continue advancing through the string until you 
         // reach the index-th + 1 parameter.
         while(*p && (comma_count < index) && (parencount > 0)) {
            if( (*p == ',') && (parencount == 1))
               comma_count++;
            else if (*p == '(' )
               parencount++;
            else if( *p == ')' )
               parencount--;
            else if( *p == '"') {          // skip over double quote marks
               p++;
               while (*p && *p != '"')
                  p++;
               }
            else if( (int)*p == 39) {      // skip over single quote marks
               p++;
               while (*p && (int)*p != 39) 
                  p++;
               }
            p++;
            }

         // p now points at the end of string or the beginning of the
         // index-th + 1 parameter
         if( *(p-1) == ',')
            *(p-1) = '\0';
         else if(parencount==0 && *(p-1) == ')')  // closing paren
            *(p-1) = '\0';
         else
            *p = '\0';
         _StrCpy(outstr,strstart);
         }
      else {
         // just return everything if there aren't any left parentheses
         _StrCpy(outstr,strg);   
         }
      _HUnLock(temp);
      _FreeHand(temp);
      }
   return(outstr);
}

//--------------------------------------------------------------------------
char FAR *k_justfname(char FAR *filname, char FAR *fname)
//
// This procedure is for internal use within FPATH.  It returns the 
// filename portion of "filname".  The filename contains the stem and 
// the extension, but excludes the path, if any.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char FAR *p, FAR *q;

   _MemMove(fname,filname,_StrLen(filname)+1);
   for (p = fname + _StrLen(fname) - 1 ; p >= fname && isspace(*p) ; p--)
      ;
   *(++p) = 0;

   // Find the rightmost backslash and take everything after it.
   q = fname;
   p = _fstrrchr(q,'\\');
   if(p != NULL)
      q = p+1;

   // Find the rightmost remaining colon and take everything after it.
   p = _fstrrchr(q,':');
   if(p != NULL)
      q = p+1;

   _MemMove(fname,q,_StrLen(q)+1);
   return(fname);
}

//--------------------------------------------------------------------------
char FAR *k_juststem(char FAR *filname, char FAR *stem)
//
// This procedure is for internal use within FPATH.  It returns the 
// stem portion of "filname".  The stem excludes the extension and the
// pathname, if any.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char FAR *p, FAR *start;
   
   _MemMove(stem,filname,_StrLen(filname)+1);
   // trim right spaces
   for (p = stem + _StrLen(stem) - 1; p >= stem && isspace(*p) ; p--)
      ;
   *(++p) = 0;

   start = stem;
   // strip off the path
   // Find the rightmost backslash and take everything after it.
   // This is an important step because the path/file name could have
   // periods in it, like:  "..\FOO"
   p = _fstrrchr(start,'\\');
   if(p != NULL)
      start = p+1;
   // If there is a colon, take everything past the rightmost one.
   p = _fstrrchr(start,':');
   if(p != NULL)
      start = p+1;

   // Find the first period and take everything before it.  If p = NULL,
   // return the entire remaining stem (after having stripped off the 
   // path).
   p = _fstrchr(start,'.');
   if(p != NULL)
      *p = '\0';

   _MemMove(stem,start,_StrLen(start)+1);
   return(stem);

}
//--------------------------------------------------------------------------
char FAR *k_justext(char FAR *filname, char FAR *extname)
//
// This procedure is for internal use within FPATH.  It returns the 
// file extension portion of "filname".
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char FAR *p, FAR *q;

   _MemMove(extname,filname,_StrLen(filname)+1);
   // trim right spaces
   for(p = extname + _StrLen(extname) - 1; p >= extname && isspace(*p) ; p--)
      ;
   *(++p) = '\0';

   q = extname;
   // strip off the path
   // Find the rightmost backslash and take everything after it.
   // This is an important step because the path/file name could have
   // periods in it, like:  "..\FOO"
   p = _fstrrchr(extname,'\\');
   if(p != NULL)
      q = p+1;
   // If there is a colon, take everything past the rightmost one.
   p = _fstrrchr(q,':');
   if(p != NULL)
      q = p+1;

   // Find the rightmost period and take everything after it.  If there
   // are no periods, return an empty string.
   p = _fstrrchr(q,'.');
   if(p != NULL)
      q = p+1;
   else
      *q = '\0';

   _StrCpy(extname,q);
   return(extname);
}
//--------------------------------------------------------------------------
char FAR *k_justpath(char FAR *filname, char FAR *pname)
//
// This procedure is for internal use within FPATH.  It returns the 
// path name portion of "filname".  The pathname contains the drive 
// designation, if any.  It does not include a trailing backslash, unless
// the path is for the root, in which case k_justpath returns a single
// backslash character (plus drive, if any).
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char FAR *p;

   _MemMove(pname,filname,_StrLen(filname)+1);
   // trim right spaces
   for (p = pname + _StrLen(pname) - 1; p >= pname && isspace(*p) ; p--)
      ;
   *(++p) = 0;

   // Find the rightmost backslash and take everything before it.
   p = _fstrrchr(pname,'\\');

   if(p==NULL) {
      //  No backslashes in the file name.  This looks like an ordinary 
      //  file name, such as "COMMAND.COM".  Return an empty string.
      *pname = '\0';
      }
   else {
      *p = '\0';

      // special case of single backslash as path (e.g., \FOXPRO2)
      if((_StrLen(pname) == 0) && (*filname == '\\'))
         _StrCpy(pname,"\\");

      // special case of drive name followed by root (e.g., C:\COMMAND.COM)
      if((_StrLen(pname) == 2) && (*(filname+1) == ':'))
         _fstrcat(pname,"\\");
      }
   return(pname);
}

//--------------------------------------------------------------------------
char FAR *k_justdrive(char FAR *filname, char FAR *outstr)
//
// This procedure is for internal use within FPATH.  It returns the 
// drive name portion of "filname" including the colon.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char FAR *p;

   _MemMove(outstr,filname,_StrLen(filname)+1);

   p = _fstrchr(outstr,':');
   if(p != NULL)
      *(++p) = '\0';
   else
      *outstr = '\0';
      
   // invalid drive string if the name plus the colon isn't exactly
   // two characters long.
   if (_StrLen(outstr) != 2)
      *outstr = '\0';
   return(outstr);
}
//--------------------------------------------------------------------------
char FAR *k_addbs(char FAR *filname, char FAR *newfname)
//
// This procedure is for internal use within FPATH.  It returns 
// "filname" with a backslash added, unless filname is empty or already
// ends with a backslash, in which case it simply returns filname
// unchanged.  Newfname must be large enough to hold the path and the
// extra backslash.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char FAR *p;

   _MemMove(newfname,filname,_StrLen(filname)+1);
   // trim right spaces
   for (p = newfname + _StrLen(newfname) - 1; 
           p >= newfname && isspace(*p) ; p--)
      ;
   *(++p) = 0;

   // If the last character in the string is not already a backslash,
   // and if the string is not empty, add a backslash to it.
   if( *(newfname + _StrLen(newfname) ) != '\\' && _StrLen(newfname) > 0 ) {
      _fstrcat(newfname,"\\");
      }
   return(newfname);
}

//--------------------------------------------------------------------------
char FAR *k_cleanpath(char FAR *strg, char FAR *buffer)
//
// This procedure is for internal use within FPATH.  It takes a 
// file/path name and cleans it up, stripping out invalid characters,
// dropping duplicate backslash characters, making sure that the names
// aren't too long, etc.
//
// Author:  Walter J. Kennamer
// History: Initially written March 21, 1991
//--------------------------------------------------------------------------
{
   char validchars[] 
   = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_^$~!#%&-{}()@`:.'€‚ƒ„…†‡ˆ‰Š‹ŒŽ‘’“”•–—˜™š ¡¢£¤¥\\";
   char FAR *p, FAR *q;

   char filname[MAXPATH], newfile[MAXPATH], stemname[MAXPATH], extension[MAXPATH], temp[MAXPATH];
   int stemlen = 0, extlen = 0;
   int endbs = 0;   // was there a backslash on the end of the pathname?

   _MemMove(filname,strg,_StrLen(strg)+1);
   
   k_upper(filname,temp);
   
   k_ltrim(temp,filname);
   k_rtrim(filname,temp);
   
   _StrCpy(newfile,temp);

   endbs = (newfile[_StrLen(newfile)-1] == '\\');   
   
   // strip out invalid characters, copying the valid ones from newfile
   // into buffer.
   k_strfilter(newfile,validchars,buffer);
 
   _StrCpy(newfile,buffer);

   // Get rid of any duplicate backslashes
   k_stralltran(newfile,"\\\\","\\",buffer);

   // Make sure there weren't several hiding together.
   while(_fstrstr(buffer,"\\\\") != NULL) {
      _StrCpy(newfile,buffer);
      k_stralltran(newfile,"\\\\","\\",buffer);
   }  
   
   // make sure there aren't too many colons
   q = buffer;
   if (k_occurs(buffer,':') > 1 ) {
      q = strrchr(buffer,':')-1;   // start just before the rightmost colon

      // Make sure character before colon is a valid drive letter.  If it 
      // isn't, skip the colon entirely.
      if( *q < 'A' || *q > 'Z')
         q += 2;
   }

   // q now points to the start of the path we will return

   // Step through all the directories and the final stem and extension
   // names and make sure they aren't too long.
   
   // Record the drive designation if there is one.
   p = strchr(newfile,'\\');
   if ( p != NULL) {
      k_justdrive(q,newfile);
   }
   else {
      newfile[0] = '\0';
   }
      
   p = _fstrtok(q,"\\");   // pull out entries separated by backslashes
   while (p != NULL) {
            
      k_juststem(p,stemname);
      stemlen = _StrLen(stemname);
      if( stemlen > 8)
         stemname[8] = '\0';
      _fstrcat(newfile,stemname);
      
      k_justext(p,extension);
      extlen = _StrLen(extension);
      if( (stemlen > 0) && (extlen > 0 ) ) {
         if( extlen > 3)
            extension[3] = '\0';
         _fstrcat(newfile,".");
         _fstrcat(newfile,extension);
      }
      _fstrcat(newfile,"\\");

      p = _fstrtok(NULL,"\\");
   }

   // There is always a terminating backslash at this point.  Do we need
   // to remove it?
   if( !endbs )
      newfile[_StrLen(newfile)-1] = '\0';

   _StrCpy(buffer,newfile);
   return(buffer);
}

#ifdef fpathw
//--------------------------------------------------------------------------
void far getdrive(ParamBlk FAR *parm)
//
// This function returns a number indicating the drive type for the 
// drive letter passed to it.
//
// Usage:   getdrive(drive)
//
// Returns: number (2 = DRIVE_REMOVABLE, 3 = DRIVE_FIXED, 4 = DRIVE_REMOTE)
//
// Author:  Walter J. Kennamer
// History: Initially written Feb 15, 1993
//--------------------------------------------------------------------------
{
   MHANDLE hDeviceLetter;
   WORD wReturn; // 2 = DRIVE_REMOVABLE, 3 = DRIVE_FIXED, 4 = DRIVE_REMOTE
   int drivenum;

   hDeviceLetter = gethandle(parm,0);
   if (hDeviceLetter == 0) {
      _Error(302);  // Data type mismatch
      }
   _HLock(hDeviceLetter);
   if (*((char *)_HandToPtr(hDeviceLetter) + 1) == ':')
      *((char *)_HandToPtr(hDeviceLetter) + 1) = '\0';
   drivenum = toupper(*((char *)_HandToPtr(hDeviceLetter))) - 65;
   wReturn = (WORD)GetDriveType(drivenum);  // 0=A, 1=B, ...
   _FreeHand(hDeviceLetter);
   _RetInt((long)wReturn,10);
   return;
}
#endif
//--------------------------------------------------------------------------
void far justfname(ParamBlk FAR *parm)
//
// This function returns the filename portion of a file/path name.
//
// Usage:   justfname(pathname)
//
// Returns: string
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char temp[MAXPATH];
   MHANDLE t ;

   t = gethandle(parm,0);
   if (t == 0) {
      _Error(302);  // Data type mismatch
      }
   _HLock(t);
   if (_StrLen(_HandToPtr(t)) >= MAXPATH) 
      *((char FAR *)_HandToPtr(t)+MAXPATH-1) = '\0';

   k_justfname(_HandToPtr(t),temp);   // get fname of t
   _RetChar(temp);
   _FreeHand(t);
   }


//--------------------------------------------------------------------------
void far juststem(ParamBlk FAR *parm)
//
// This function returns the stem portion of a file/path name.
//
// Usage:   juststem(pathname)
//
// Returns: string
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char temp[MAXPATH];
   MHANDLE t ;

   t = gethandle(parm,0);
   if (t == 0) {
      _Error(302);  // Data type mismatch
      }

   _HLock(t);
   k_juststem(_HandToPtr(t),temp);
   _RetChar(temp);
   _FreeHand(t);
   return;
}

//--------------------------------------------------------------------------
void far justext(ParamBlk FAR *parm)
//
// This function returns the extension of a file/path name.
//
// Usage:   justext(pathname)
//
// Returns: string
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char temp[MAXPATH];
   MHANDLE t ;

   t = gethandle(parm,0);
   if (t == 0) {
      _Error(302);  // Data type mismatch
      }

   k_justext(_HandToPtr(t),temp);
   _RetChar(temp);
   _FreeHand(t);
}

//--------------------------------------------------------------------------
void far justpath(ParamBlk FAR *parm)
//
// This function returns the path portion of a file/path name.
//
// Usage:   justpath(pathname)
//
// Returns: string
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char temp[MAXPATH];
   MHANDLE t;

   t = gethandle(parm,0);
   if (t == 0) {
      _Error(302);  // Data type mismatch
      }

   k_justpath(_HandToPtr(t),temp);
   _RetChar(temp);
   _FreeHand(t);
}
//--------------------------------------------------------------------------
void far justdrive(ParamBlk FAR *parm)
//
// This function returns the drive designation of a file/path name.
//
// Usage:   justdrive(pathname)
//
// Returns: string
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char temp[MAXPATH];
   MHANDLE t ;

   t = gethandle(parm,0);
   if (t == 0) {
      _Error(302);  // Data type mismatch
      }
   _HLock(t);

   k_justdrive(_HandToPtr(t),temp);
   _RetChar(temp);
   _FreeHand(t);
}

//--------------------------------------------------------------------------
void far forceext(ParamBlk FAR *parm)
//
// This function returns parameter 1 with the extension changed to 
// parameter 2.  If there isn't an extension on parameter 1 already,
// it adds one.
//
// Usage:   forcetext(pathname,extension)
//
// Returns: string
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char stem[MAXPATH], temp[MAXPATH];
   char FAR *filname, 
   FAR *p, 
   FAR *stemname;
   MHANDLE t, e ;

   t = gethandle(parm,0);
   if (t == 0) {
      _Error(302);  // Data type mismatch
      }

   e = gethandle(parm,1);
   if (e == 0) {
      _Error(302);  // Data type mismatch
      }
   _HLock(t);
   _HLock(e);
   stemname = k_juststem(_HandToPtr(t),stem);

   if(_StrLen(stemname) != 0) {
      filname  =  k_justpath(_HandToPtr(t),temp);
      filname  =  k_addbs(filname,temp);

      _fstrcat(filname,stemname);
      _fstrcat(filname,".");
      _fstrcat(filname,_HandToPtr(e));

      _RetChar(filname);
      }
   else {
      p = _HandToPtr(t);
      *p = '\0';
      _RetChar(p);
      }
   _FreeHand(t);
   _FreeHand(e);
 }
//--------------------------------------------------------------------------
void far defaultext(ParamBlk FAR *parm)
//
// This function adds parameter 2 as the extension of parameter 1, but
// only if parameter 1 does not have an extension.  If it does, this
// function simply returns parameter 1.
//
// Usage:   defaultext(pathname,extension)
//
// Returns: string
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char temp[MAXPATH];
   char FAR *filname, 
   FAR *ext;
   MHANDLE t, e;

   t = gethandle(parm,0);
   if (t == 0) {
      _Error(302);  // Data type mismatch
      }

   e = gethandle(parm,1);
   if (e == 0) {
      _Error(302);  // Data type mismatch
      }
   _HLock(t);
   _HLock(e);

   filname = _HandToPtr(t);
   ext     = _HandToPtr(e);

   if(_StrLen(filname) != 0) {
      k_justext(filname,temp);
      if(_StrLen(temp) == 0) {
         // OK, it doesn't have an extension.  Let's add one if there isn't
         // a terminating period.
         if(*(filname+_StrLen(filname)-1) != '.') {
            // Make room to hold the (possibly larger) filename
            _StrCpy(temp,filname);
            _fstrcat(temp,".");
            _fstrcat(temp,ext);
         }
         _RetChar(temp);
      }
      else {
         _RetChar(filname);
      }
   }
   else {
      filname  = _HandToPtr(t);
      *filname = '\0';
      _RetChar(filname);
      }
   _FreeHand(t);
   _FreeHand(e);
 }

 
//--------------------------------------------------------------------------
void far addbs(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
//
// Add a trailing backslash to a path name, unless there is 
// already one there or the string is empty.  Returns a pathname.
//
// Usage:   addbs(pathname)
//
// Returns: string
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   char temp[MAXPATH];
   MHANDLE t;

   t = gethandle(parm,0);
   if (t == 0) {
      _Error(302);  // Data type mismatch
      }

   _HLock(t);
   k_addbs(_HandToPtr(t),temp);
   _RetChar(temp);
   _HUnLock(t);
   _FreeHand(t);

}

//--------------------------------------------------------------------------
void far validpath(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
//
// Returns TRUE if the filename passed as a parameter is a valid MS-DOS
// file name.
//
// Usage:   validpath(pathname)
//
// Returns: boolean
//
// Author:  Walter J. Kennamer
// History: Initially written March 21, 1992
//--------------------------------------------------------------------------
{
   char validchars[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_^$~!#%&-{}()@`:.'\\";
   char FAR *p;
   char buffer[MAXPATH];
   MHANDLE t;
   int valid = 1;

   t = gethandle(parm,0);
   if (t == 0)
      _Error(302);  // Data type mismatch

   _HLock(t);

   // Check for invalid characters in the file name
   p = _HandToPtr(t);
   while( *p && valid) {
      if(_fstrchr(validchars,toupper(*p)) == NULL)
    valid = 0;
      p++;
      }

   // Check for blank stem, or stem too long
   k_juststem(_HandToPtr(t),buffer);
   if((buffer[0] == '\0') || (_StrLen(buffer) > 8))
      valid = 0;

   // Check for extension too long
   k_justext(_HandToPtr(t),buffer);
   if(_StrLen(buffer) > 3)
      valid = 0;

   // Check for too many colons
   if( k_occurs(_HandToPtr(t),':') > 1 )
      valid = 0;

   // Check for duplicate backslashes
   p = _fstrstr(_HandToPtr(t),"\\\\");
   if (p != NULL)
      valid = 0;

   _RetLogical(valid);
   _FreeHand(t);
   
}

//--------------------------------------------------------------------------
void far cleanpath(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
//
// Returns a cleaned-up file and path name, stripping out invalid chars,
// eliminating duplicate backslash chars, making sure there aren't too
// many colons, etc.
//
// Usage:   cleanpath(pathname)
//
// Returns: string
//
// Author:  Walter J. Kennamer
// History: Initially written March 21, 1992
//--------------------------------------------------------------------------
{
   MHANDLE t;
   char buffer[MAXPATH];

   t = gethandle(parm,0);
   if (t == 0)
      _Error(302);  // Data type mismatch

   _HLock(t);

   k_cleanpath(_HandToPtr(t),buffer);

   _RetChar(buffer);
   _FreeHand(t);
}

//--------------------------------------------------------------------------
void far reduce(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
//
// Reduce multiple white space characters to a single space and trims all
// leading and trailing white space.  If the optional second parameter
// is non-zero, quoted strings will be unaffected.
//
// Usage:   reduce(string,[skipquotes])
//
// Returns: string
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   Value FAR *v;
   Value rval;
   char FAR *temp;
   char bkstr[MAXBREAK];
   int i=0;
   MHANDLE t;

   t = gethandle(parm,0);
   if (t == 0) {
      _Error(302);  // Data type mismatch
      }

   if(parm->pCount > 1) {      // get parm for break string
      v = &parm->p[1].val;
      _MemMove(bkstr,_HandToPtr(v->ev_handle),min(v->ev_length,MAXBREAK));
      bkstr[min(v->ev_length,MAXBREAK)] = '\0';
      }
   else {
      _StrCpy(bkstr,DFTBREAK);
      }

   if(parm->pCount > 2) {      // get parm for skipping quotes
      v = &parm->p[2].val;
      i = (int)v->ev_long;
      }

   _HLock(t);
   if( (temp = _Alloca(_StrLen(_HandToPtr(t))+1)) == (char FAR *)0 ) {
      _Error(182);
      }

   k_reduce(_HandToPtr(t),bkstr,temp,i);
   _StrCpy(_HandToPtr(t),temp);

   rval.ev_handle = t;
   rval.ev_length = (unsigned short) _StrLen(_HandToPtr(t));
   rval.ev_type   = 'C';
   _RetVal(&rval);
   _FreeHand(t);
}
//--------------------------------------------------------------------------
void far strfilter(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
//
// Filter out any characters that aren't in filt_str.
//
// Usage:   strfilter(string,filt_str)
//
// Returns: string
//
// Author:  Walter J. Kennamer
// History: Initially written June 18, 1991
//--------------------------------------------------------------------------
{
   Value FAR *v;
   char filt[MAXBREAK];
   MHANDLE t, temp;

   t = gethandle(parm,0);
   if (t == 0) {
      _Error(302);  // Data type mismatch
      }
   v = &parm->p[0].val;
   if ((temp = _AllocHand(v->ev_length+1)) == 0) {
      _Error(182);   // insufficient memory
      }

   v = &parm->p[1].val;
   _MemMove(filt,_HandToPtr(v->ev_handle),min(v->ev_length,MAXBREAK));
   filt[min(v->ev_length,MAXBREAK)] = '\0';

   k_strfilter(_HandToPtr(t),filt,_HandToPtr(temp));
   _RetChar(_HandToPtr(temp));
   _FreeHand(temp);
   _FreeHand(t);

}
//--------------------------------------------------------------------------
void far words(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
//
// Counts the number of words in a string.  Words are delimited by
// characters in the break string, or by DFTBREAK characters
// if no break string is specified.
//
// Usage:   words(string,[break])
//
// Returns: int
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   Value FAR *v;
   unsigned int i    = 0;
   char bkstr[MAXBREAK];
   MHANDLE t;

   t = gethandle(parm,0);
   if (t == 0) {
      _UserError("Data type mismatch in function WORDS\n");
      }
   _HLock(t);

   if(parm->pCount > 1)
      {
      v = &parm->p[1].val;
      _MemMove(bkstr,_HandToPtr(v->ev_handle),min(MAXBREAK,v->ev_length));
      bkstr[min(MAXBREAK,v->ev_length)] = '\0';
      }
   else
      _StrCpy(bkstr,DFTBREAK);

   i = k_words(_HandToPtr(t),bkstr);

   _RetInt(i,10);
   _FreeHand(t);
}
//--------------------------------------------------------------------------
void far wordnum(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
//
// Returns the "index-th" word in a string, delimited by the break string.
// If no break string is specified, the function uses spaces, tabs
// and commas to delimit words.
//
// Usage:   wordnum(string,index,[break])
//
// Returns: string
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   Value FAR *v;
   MHANDLE t;
   char      bkstr[MAXBREAK], outstr[MAXWORD];
   int       i;

   t = gethandle(parm,0);
   v = &parm->p[1].val;
   i = (int)v->ev_long;

   if(parm->pCount >= 3) {
      v = &parm->p[2].val;
      _MemMove(bkstr,_HandToPtr(v->ev_handle),min(v->ev_length,MAXBREAK));
      bkstr[min(v->ev_length,MAXBREAK)] = '\0';
      }
   else
      _StrCpy(bkstr,DFTBREAK);

   _HLock(t);
   k_wordnum(_HandToPtr(t),i,bkstr,outstr);
   _RetChar(outstr);
   _FreeHand(t);

}
//--------------------------------------------------------------------------
void far nextword(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
//
// Returns the next word in a string, beginning with the index specified
// by the second parameter.  It skips break characters from the index 
// position forward.  It accepts an optional third parameter containing
// a string of break characters.  If no break string is specified,
// only white space characters are break characters.
//
// Usage:   nextword(string,index,[break])
//
// Returns: string
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{
   Value FAR *v;
   MHANDLE t;
   char      temp[MAXWORD], bkstr[MAXBREAK];
   int       i;

   v = &parm->p[0].val;
   if ( (t = _AllocHand(v->ev_length+1) ) == 0) {
      _Error(182);   // insufficient memory
      }
   _MemMove(_HandToPtr(t),_HandToPtr(v->ev_handle),v->ev_length);
   *((char FAR *)_HandToPtr(t) + v->ev_length) = '\0';

   v = &parm->p[1].val;
   i = (int)v->ev_long;

   if(parm->pCount > 2)
      {
      v = &parm->p[2].val;
      _MemMove(bkstr,_HandToPtr(v->ev_handle),min(MAXBREAK,v->ev_length));
      bkstr[min(MAXBREAK,v->ev_length)] = '\0';
      }
   else
      _StrCpy(bkstr,DFTBREAK);

   _HLock(t);
   k_nextword(_HandToPtr(t),i,bkstr,temp);
   _FreeHand(t);
   _RetChar(temp);

}
//--------------------------------------------------------------------------
void far fctnparm(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
//
// Returns the specified parameter in a string of function parameters,
// accounting for nexted parentheses, etc.
//
// Usage:   fctnparm(string,index)
//
// Returns: string
//
// Auns: string
//
// Author:  Walter J. Kennamer
// History: Initially written May 25, 1991
//--------------------------------------------------------------------------
{
   Value FAR *v;
   MHANDLE   t;
   char      temp[MAXWORD];
   int       i;

   v = &parm->p[0].val;
   if ( (t = _AllocHand(v->ev_length+1) ) == 0) {
      _Error(182);   // insufficient memory
      }
   _MemMove(_HandToPtr(t),_HandToPtr(v->ev_handle),v->ev_length);
   *((char FAR *)_HandToPtr(t) + v->ev_length) = '\0';

   v = &parm->p[1].val;
   i = (int)v->ev_long;

   _HLock(t);
   k_fctnparm(_HandToPtr(t),i,temp);
   _FreeHand(t);
   _RetChar(temp);
}
//--------------------------------------------------------------------------
void far bxor(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
// This routine returns the bitwise "exclusive or" of byte1 and byte2.
//
// Usage:   bxor(byte1,byte2)
//
// Returns: int
//
// Author:  Walter J. Kennamer
// History: Initially written July 31, 1991
//--------------------------------------------------------------------------
{
   Value FAR *v;
   int       b1,b2,b3;

   v  = &parm->p[0].val;
   b1 = (int)v->ev_long;
   v  = &parm->p[1].val;
   b2 = (int)v->ev_long;

   b3 = b1 ^ b2;

   _RetInt(b3,10);

}
//--------------------------------------------------------------------------
void far bor(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
// This routine returns the bitwise "inclusive or" of byte1 and byte2.
//
// Usage:   bor(byte1,byte2)
//
// Returns: int
//
// Author:  Walter J. Kennamer
// History: Initially written July 31, 1991
//--------------------------------------------------------------------------
{
   Value FAR *v;
   int       b1,b2,b3;

   v  = &parm->p[0].val;
   b1 = (int)v->ev_long;
   v  = &parm->p[1].val;
   b2 = (int)v->ev_long;

   b3 = b1 | b2;

   _RetInt(b3,10);

}
//--------------------------------------------------------------------------
void far band(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
// This routine returns the bitwise "and" of byte1 and byte2.
//
// Usage:   band(byte1,byte2)
//
// Returns: int
//
// Author:  Walter J. Kennamer
// History: Initially written July 31, 1991
//--------------------------------------------------------------------------
{
   Value FAR *v;
   int       b1,b2,b3;

   v  = &parm->p[0].val;
   b1 = (int)v->ev_long;
   v  = &parm->p[1].val;
   b2 = (int)v->ev_long;

   b3 = b1 & b2;

   _RetInt(b3,10);

}

//--------------------------------------------------------------------------
void far bnot(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
// This routine returns the ones' compliment of byte1.
//
// Usage:   bnot(byte1)
//
// Returns: int
//
// Author:  Walter J. Kennamer
// History: Initially written July 31, 1991
//--------------------------------------------------------------------------
{
   Value FAR *v;
   int       b1,b3;

   v  = &parm->p[0].val;
   b1 = (int)v->ev_long;

   b3 = ~b1;

   _RetInt(b3,10);

}
//--------------------------------------------------------------------------
void far bshr(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
// This routine returns byte1 shifted right by num positions, or by one
// position if num is not specified.  As bytes are shifted, the new bytes
// on the left are zero-filled.
//
// Usage:   bshr(byte1,num)
//
// Returns: int
//
// Author:  Walter J. Kennamer
// History: Initially written July 31, 1991
//--------------------------------------------------------------------------
{
   Value FAR *v;
   unsigned int b1,b2,b3;

   v  = &parm->p[0].val;
   b1 = (unsigned int)v->ev_long;
   if (parm->pCount > 1) {
      v  = &parm->p[1].val;
      b2 = (unsigned int)v->ev_long;
      }
   else {
      b2 = 1;
   }

   b2 = b2 % 8;

   if (b2 > 0) {
      b3 = b1 >> b2;
      }
   else {
      b3 = 0;
   }

   _RetInt(b3,10);

}
//--------------------------------------------------------------------------
void far bshl(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
// This routine returns byte1 shifted left by num positions, or by one
// position if num is not specified.  As bytes are shifted, the new bytes
// on the right are filled with 0.
//
// Usage:   bshl(byte1,num)
//
// Returns: int
//
// Author:  Walter J. Kennamer
// History: Initially written July 31, 1991
//--------------------------------------------------------------------------
{
   Value FAR *v;
   unsigned int b1,b2,b3;

   v  = &parm->p[0].val;
   b1 = (unsigned int)v->ev_long;
   if (parm->pCount > 1) {
      v  = &parm->p[1].val;
      b2 = (unsigned int)v->ev_long;
      }
   else {
      b2 = 1;
   }

   b2 = b2 % 8;

   if (b2 > 0) {
      b3 = b1 << b2;
      }
   else {
      b3 = 0;
   }

   _RetInt(b3,10);

}

//--------------------------------------------------------------------------
void far dbl2num(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
// This routine returns a FoxPro numeric variable corresponding to the
// double (8-byte) number passed to it as a character string.  It is 
// useful for converting data written by other applications into FoxPro
// format.
//
// Usage:   dbl2num(8 bytes)
//
// Returns: floating point number
//
// Author:  Walter J. Kennamer
// History: Initially written March 21, 1992
//--------------------------------------------------------------------------
{
   int width = 20;
   int leftpos = 0;   // positions to the left of the decimal
   double * num;
   char *p;
   char buffer[21];
   MHANDLE t;

   t = gethandle(parm,0);
   if (t == 0) {
      _Error(302);  // Data type mismatch
      }
   _HLock(t);

   num = (double *)_HandToPtr(t);
   gcvt(*num,width,buffer);    // convert double to a string

   for (p = buffer; *p && *p != '.'; p++)
      leftpos++;
   _RetFloat(*num,width, (leftpos < 20) ? width-leftpos-1 : 0);
   _FreeHand(t);
}
//--------------------------------------------------------------------------
void far num2dbl(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
// This routine returns a double (8 byte) number corresponding to the 
// FoxPro numeric variable passed to it.  It is useful for converting data 
// written by other applications into FoxPro format.  The double number is
// returned in a character string.
//
// Usage:   dbl2num(8 bytes)
//
// Returns: String, via value structure 
//
// Author:  Walter J. Kennamer
// History: Initially written March 21, 1992
//--------------------------------------------------------------------------
{
   Value * v;
   Value outval;
   double num;
   char  * p;

   v = &parm->p[0].val;
   if( v->ev_type == 'I') {
      num = (double) v->ev_long;
      }
   else if (v->ev_type == 'N') {
      num = (double) v->ev_real;
      }
   else {
      _Error(302);  // Data type mismatch
      }

   // Make p point to the address of the num.
   p = (char *) &num;

   // Assemble a value structure to pass the results back to FoxPro.
   // Since the dbl string can contain embedded CHR(0) values, we have
   // to use _RetVal instead of _RetChar.

   // Get 8 bytes of RAM for ev_handle to point to
   if( (outval.ev_handle = _AllocHand(8)) == 0) {
      _Error(182);    // out of memory
      }
   // Move the first 8 bytes pointed to by 'p' to ev_handle
   _HLock(outval.ev_handle);
   _MemMove(_HandToPtr(outval.ev_handle),p,8);
   outval.ev_type    = 'C';
   outval.ev_length  = 8;
   _HUnLock(outval.ev_handle);

   _RetVal(&outval);

}

//--------------------------------------------------------------------------
void far bcd2num(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
// This routine returns a FoxPro numeric variable corresponding to the
// 10-byte BCD real number passed to it as a character string.  It is 
// useful for converting data written by the Turbo Database Toolbox
// into FoxPro numeric format.
//
// Usage:   bcd2num(10 bytes)
//
// Returns: floating point number
//
// Author:  Sherri Bruhn Kennamer
// History: Initially written March 28, 1992
//--------------------------------------------------------------------------
{
   char byte_array[10];
   char temp[3], hexstrg[3], mantissa_strg[25], buffer[21];
   char *p;
   
   // Width of the return number and the default number of positions
   // before the decimal point.
   int width = 20, leftpos = 0;
   int i;

   // types for storing the numeric equivalents of the BCD
   int sign;
   double mantissa, thevalue;
   int exponent;

   Value FAR *v;

   v = &parm->p[0].val;

   if( v->ev_length != 10 )  {
     _UserError("Not a BCD Real\n");
     }

   // copy the parameter string into the 'byte_array' array
   _MemMove(byte_array,_HandToPtr(v->ev_handle),v->ev_length);

   // sign is negative if the leftmost bit is a one
   sign = ( ((byte_array[0] >> 7) & 0x0001) ? -1 : 1) ;

   // The exponent is the rightmost seven bits in the leftmost byte,
   // less 63dec.  
   exponent = (byte_array[0] & 0x7F) - 0x3F;

   _StrCpy(mantissa_strg,"0.");
   
   // Step through the rest of the bytes in reverse order.  This format
   // encodes decimal digits in hex digits to save space.  Convert the 
   // byte values to a string of hex digits, then treat them as decimal
   // digits for a conversion back into type double.
   for (i = 9 ; i >= 1 ; i--) {
      itoa(byte_array[i],hexstrg,16);
   
      // if it's only one hex digit, put a 0 in front.
      if (_StrLen(hexstrg) == 1) {
         temp[0] = '\0';
         _fstrcat(temp,"0");
         _fstrcat(temp,hexstrg);
         _StrCpy(hexstrg,temp);
      }
   _fstrcat(mantissa_strg,hexstrg);
   }

   mantissa = strtod(mantissa_strg,NULL);

   // Try to figure out how many decimal positions we'll need
   gcvt(mantissa,width,buffer);    // convert double to a string
   
   for (p = buffer; *p && *p != '.'; p++)
      leftpos++;

   thevalue = sign * mantissa * pow(10,exponent);
  
   _RetFloat(thevalue, width, (leftpos < 20) ? width-leftpos-1 : 0);

}
//--------------------------------------------------------------------------
void far num2bcd(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
// This routine returns a FoxPro numeric variable corresponding to the
// double (8-byte) number passed to it as a character string.  It is 
// useful for converting data written by other applications into FoxPro
// format.
//
// Usage:   dbl2num(8 bytes)
//
// Returns: floating point number
//
// Author:  Walter J. Kennamer
// History: Initially written March 21, 1992
//--------------------------------------------------------------------------
{
   Value * v;
   Value outval;
   double num;
   char FAR * p;

   v = &parm->p[0].val;
   if( v->ev_type == 'I') {
      num = (double) v->ev_long;
      }
   else if (v->ev_type == 'N') {
      num = (double) v->ev_real;
      }
   else {
      _Error(302);  // Data type mismatch
      }

   // Make p point to the address of the num.
   p = (char FAR *) &num;

   // Assemble a value structure to pass the results back to FoxPro.
   // Since the dbl string can contain embedded NULL values, we have
   // to use _RetVal instead of _RetChar.

   // Get 8 bytes of RAM for ev_handle to point to
   if( (outval.ev_handle = _AllocHand(8)) == 0) {
      _Error(182);    // out of memory
      }
   // Move the first 8 bytes pointed to by 'p' to ev_handle
   _HLock(outval.ev_handle);
   _MemMove(_HandToPtr(outval.ev_handle),p,8);
   outval.ev_type    = 'C';
   outval.ev_length  = 8;
   _HUnLock(outval.ev_handle);

   _RetVal(&outval);

}
//--------------------------------------------------------------------------
void far float2num(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
// This routine returns a FoxPro numeric variable corresponding to the
// real (6-byte) number passed to it as a character string.  It is 
// useful for converting data written by other applications into FoxPro
// format.
//
// Usage:   float2num(6 bytes)
//
// Returns: floating point number
//
// Author:  Walter J. Kennamer
// History: Initially written March 21, 1992
//--------------------------------------------------------------------------
{
   int width = 20;
   int leftpos = 0;   // positions to the left of the decimal
   float * num;
   char FAR * p;
   char buffer[21];
   MHANDLE t;

   t = gethandle(parm,0);
   if (t == 0) {
      _Error(302);  // Data type mismatch
      }
   _HLock(t);

   num = (float *)_HandToPtr(t);
   gcvt(*num,width,buffer);    // convert double to a string
   for (p = buffer; *p && *p != '.'; p++)
      leftpos++;
   _RetFloat(*num,width, (leftpos < 20) ? width-leftpos-1 : 0);
   _FreeHand(t);
}

//--------------------------------------------------------------------------
void far long2num(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
// This routine returns a FoxPro numeric variable corresponding to the
// long int (4-byte) number passed to it as a character string.  It is 
// useful for converting data written by other applications into FoxPro
// format.
//
// Usage:   long2num (4 bytes)
//
// Returns: floating point number
//
// Author:  Walter J. Kennamer
// History: Initially written March 21, 1992
//--------------------------------------------------------------------------
{
   int width = 20;
   long int * num;
   MHANDLE t;

   t = gethandle(parm,0);
   if (t == 0) {
      _Error(302);  // Data type mismatch
      }
   _HLock(t);

   num = (long int *)_HandToPtr(t);
   _RetFloat(*num,width,0);
   _FreeHand(t);
}

//--------------------------------------------------------------------------
void far int2num(ParamBlk FAR *parm)
//--------------------------------------------------------------------------
// This routine returns a FoxPro numeric variable corresponding to the
// int (2-byte) number passed to it as a character string.  It is 
// useful for converting data written by other applications into FoxPro
// format.
//
// Usage:   int2num (2 bytes)
//
// Returns: floating point number
//
// Author:  Walter J. Kennamer
// History: Initially written March 21, 1992
//--------------------------------------------------------------------------
{
   int width = 20;
   int * num;
   MHANDLE t;

   t = gethandle(parm,0);
   if (t == 0) {
      _Error(302);  // Data type mismatch
      }
   _HLock(t);

   num = (int *)_HandToPtr(t);
   _RetFloat(*num,width,0);
   _FreeHand(t);
}

//--------------------------------------------------------------------------
void far k_assert(BOOL expr, char FAR *testname)
//--------------------------------------------------------------------------
{
   if(!expr) {
      _PutStr("\007");
      _PutStr(testname);
      _PutStr(": Assert failed\n");
      }
}

//--------------------------------------------------------------------------
void far k_fpathtest()
//--------------------------------------------------------------------------
{
   // Tests for internal fpath functions

   char foo[] = "C:\\FOXPRO2\\FOXAPP\\APPS\\INVOICES.APP";
   char foo1[] = "FOXPRO2\\FOXAPP\\APPS\\INVOICES.APP";
   char foo2[] = "FOXPRO2\\FOXAPP\\APPS";
   char foo4[] = " FOO    BAR    BAZ   FOO ";
   char foo5[] = "C:\\FOXPRO2\\FOXAPP\\APPS\\INVOICES.APP   ";
   char buffer[255];
   char FAR *temp;

   if( (temp = _Alloca(256)) == (char FAR *)0 ) {
      _Error(182);
      }

   k_assert(_StrCmp(k_replicate("",4,buffer),"")==0,"REPLICATE-1");
   k_assert(_StrCmp(k_replicate("FOO",0,buffer),"")==0,"REPLICATE-2");
   k_assert(_StrCmp(k_replicate("FOO",4,buffer),"FOOFOOFOOFOO")==0,"REPLICATE-3");

   k_assert(_StrCmp(k_spaces(0,buffer),"")==0,"SPACES-1");
   k_assert(_StrCmp(k_spaces(4,buffer),"    ")==0,"SPACES-2");

   k_assert(_StrCmp(k_delete(foo,3,temp),foo1)==0,"DELETE-1");
   k_assert(_StrCmp(k_delete(foo,0,temp),foo )==0,"DELETE-2");

   k_assert(_StrCmp(k_insert(foo,"",temp),foo)==0,"INSERT-1");
   k_assert(_StrCmp(k_insert(foo1,"C:\\",temp),foo )==0,"INSERT-2");

   k_assert(_StrCmp(k_rtrim(" FOO ",temp)," FOO")==0,"RTRIM-1");
   k_assert(_StrCmp(k_rtrim("   ",temp),"")==0,"RTRIM-2");
   k_assert(_StrCmp(k_rtrim("",temp),"")==0,"RTRIM-3");
   k_assert(_StrCmp(k_rtrim("FOO",temp),"FOO")==0,"RTRIM-4");

   k_assert(_StrCmp(k_ltrim(" FOO ",temp),"FOO ")==0,"LTRIM-1");
   k_assert(_StrCmp(k_ltrim("   ",temp),"")==0,"LTRIM-2");
   k_assert(_StrCmp(k_ltrim("",temp),"")==0,"LTRIM-3");
   k_assert(_StrCmp(k_ltrim("FOO",temp),"FOO")==0,"LTRIM-4");

   k_assert(_StrCmp(k_alltrim(" FOO ",temp),"FOO")==0,"ALLTRIM-1");
   k_assert(_StrCmp(k_alltrim("   ",temp),"")==0,"ALLTRIM-2");
   k_assert(_StrCmp(k_alltrim("",temp),"")==0,"ALLTRIM-3");
   k_assert(_StrCmp(k_alltrim("FOO",temp),"FOO")==0,"ALLTRIM-4");
   k_assert(_StrCmp(k_alltrim("FOO    ",temp),"FOO")==0,"ALLTRIM-5");

   k_assert(_StrCmp(k_reduce(foo4,DFTBREAK,temp,0),"FOO BAR BAZ FOO") ==0,"REDUCE-1");
   k_assert(_StrCmp(k_reduce("",DFTBREAK,temp,0),"") ==0,"REDUCE-2");
   k_assert(_StrCmp(k_reduce("","",temp,0),"") ==0,"REDUCE-2");

   k_assert(_StrCmp(k_upper("abc",temp),"ABC") ==0,"UPPER-1");
   k_assert(_StrCmp(k_upper("",temp),"") ==0,"UPPER-2");
   k_assert(_StrCmp(k_upper("ABC",temp),"ABC") ==0,"UPPER-3");
   k_assert(_StrCmp(k_upper("ABC ",temp),"ABC ") ==0,"UPPER-4");

   k_assert(_StrCmp(k_padr("ABC",4,temp),"ABC ") ==0,"PADR-1");
   k_assert(_StrCmp(k_padr("",4,temp),"    ") ==0,"PADR-2");
   k_assert(_StrCmp(k_padr("",0,temp),"") ==0,"PADR-3");
   k_assert(_StrCmp(k_padr("ABC",0,temp),"ABC") ==0,"PADR-4");

   k_assert(_StrCmp(k_padl("ABC",4,temp)," ABC") ==0,"PADL-1");
   k_assert(_StrCmp(k_padl("",4,temp),"    ") ==0,"PADL-2");
   k_assert(_StrCmp(k_padl("",0,temp),"") == 0,"PADL-3");
   k_assert(_StrCmp(k_padl("ABC",0,temp),"ABC") ==0,"PADL-4");

   k_assert(_StrCmp(k_stralltran("","","",temp),"")==0,"STRALLTRAN-1");
   k_assert(_StrCmp(k_stralltran("","A","B",temp),"")==0,"STRALLTRAN-2");
   k_assert(_StrCmp(k_stralltran("ABC","A","B",temp),"BBC")==0,"STRALLTRAN-3");
   k_assert(_StrCmp(k_stralltran("ABC ","A","B",temp),"BBC ")==0,"STRALLTRAN-4");
   k_assert(_StrCmp(k_stralltran("\\","\\","\\",temp),"\\")==0,"STRALLTRAN-5");
   k_assert(_StrCmp(k_stralltran("ABC","AB","B",temp),"BC")==0,"STRALLTRAN-6");
   k_assert(_StrCmp(k_stralltran("ABC","B","BB",temp),"ABBC")==0,"STRALLTRAN-7");
   k_assert(_StrCmp(k_stralltran("ABC","AB","",temp),"C")==0,"STRALLTRAN-8");
   k_assert(_StrCmp(k_stralltran("ABC","ABC","",temp),"")==0,"STRALLTRAN-9");
   k_assert(_StrCmp(k_stralltran("BBB","B","BA",temp),"BABABA")==0,"STRALLTRAN-10");
   k_assert(_StrCmp(k_stralltran("BBB","B","Bb",temp),"BbBbBb")==0,"STRALLTRAN-11");
   k_assert(_StrCmp(k_stralltran("BBB","B","BB",temp),"BBBBBB")==0,"STRALLTRAN-12");
   k_assert(_StrCmp(k_stralltran("BBB","","BB",temp),"BBB")==0,"STRALLTRAN-13");

   k_assert(_StrCmp(k_chrtran("","","",temp),"")==0,"CHRTRAN-1");
   k_assert(_StrCmp(k_chrtran("ABC()","()","",temp),"ABC")==0,"CHRTRAN-2");
   k_assert(_StrCmp(k_chrtran("ABC","()","",temp),"ABC")==0,"CHRTRAN-3");
   k_assert(_StrCmp(k_chrtran("ABC","","",temp),"ABC")==0,"CHRTRAN-4");
   k_assert(_StrCmp(k_chrtran("ABC","","()",temp),"ABC")==0,"CHRTRAN-5");
   k_assert(_StrCmp(k_chrtran("ABC ","","()",temp),"ABC ")==0,"CHRTRAN-6");
   k_assert(_StrCmp(k_chrtran("ABC","D","E",temp),"ABC")==0,"CHRTRAN-7");
   k_assert(_StrCmp(k_chrtran("ABC ","A","B",temp),"BBC ")==0,"CHRTRAN-8");

   k_assert(_StrCmp(k_stuff("",0,0,"",temp),"")==0,"STUFF-1");
   k_assert(_StrCmp(k_stuff("",0,1,"",temp),"")==0,"STUFF-2");
   k_assert(_StrCmp(k_stuff("",1,0,"",temp),"")==0,"STUFF-3");
   k_assert(_StrCmp(k_stuff("",1,1,"",temp),"")==0,"STUFF-4");
   k_assert(_StrCmp(k_stuff("",1,0,"A",temp),"")==0,"STUFF-5");
   k_assert(_StrCmp(k_stuff("",0,1,"A",temp),"")==0,"STUFF-6");
   k_assert(_StrCmp(k_stuff("ABCDEF",0,0,"",temp),"ABCDEF")==0,"STUFF-7");
   k_assert(_StrCmp(k_stuff("ABCDEF",1,1,"",temp),"BCDEF")==0,"STUFF-8");
   k_assert(_StrCmp(k_stuff("ABCDEF",1,1,"B",temp),"BBCDEF")==0,"STUFF-9");
   k_assert(_StrCmp(k_stuff("ABCDEF",4,0,"FOO",temp),"ABCFOODEF")==0,"STUFF-10");
   k_assert(_StrCmp(k_stuff("ABCDEF",30,0,"FOO",temp),"ABCDEF")==0,"STUFF-11");

   k_assert(_StrCmp(k_fctnparm("function(a+b,c+d,foo(e-f+g,h),i)",1,temp),"a+b")==0,"FCTNPARM-1");
   k_assert(_StrCmp(k_fctnparm("function(a+b,c+d,foo(e-f+g,h),i)",2,temp),"c+d")==0,"FCTNPARM-2");
   k_assert(_StrCmp(k_fctnparm("function(a+b,c+d,foo(e-f+g,h),i)",3,temp),"foo(e-f+g,h)")==0,"FCTNPARM-3");
   k_assert(_StrCmp(k_fctnparm("function(a+b,c+d,foo(e-f+g,h),i)",4,temp),"i")==0,"FCTNPARM-4");

   k_assert(k_words(" This is a sample sentence.",DFTBREAK)==5,"WORDS-1");
   k_assert(k_words("This",DFTBREAK)==1,"WORDS-2");
   k_assert(k_words("  This",DFTBREAK)==1,"WORDS-3");
   k_assert(k_words("",DFTBREAK)==0,"WORDS-4");
   k_assert(k_words(" This",DFTBREAK)==1,"WORDS-5");
   k_assert(k_words("This, ",DFTBREAK)==1,"WORDS-6");

   k_assert(_StrCmp(k_wordnum(" This is   a sample sentence.",0,DFTBREAK,temp),"")==0,"WORDNUM-0");
   k_assert(_StrCmp(k_wordnum(" This is   a sample sentence.",1,DFTBREAK,temp),"This")==0,"WORDNUM-1");
   k_assert(_StrCmp(k_wordnum(" This is   a sample sentence.",2,DFTBREAK,temp),"is")==0,"WORDNUM-2");
   k_assert(_StrCmp(k_wordnum(" This is   a sample sentence.",3,DFTBREAK,temp),"a")==0,"WORDNUM-3");
   k_assert(_StrCmp(k_wordnum(" This is   a sample sentence.",4,DFTBREAK,temp),"sample")==0,"WORDNUM-4");
   k_assert(_StrCmp(k_wordnum(" This is   a sample sentence.",5,DFTBREAK,temp),"sentence.")==0,"WORDNUM-5");
   k_assert(_StrCmp(k_wordnum(" This is   a sample sentence.",6,DFTBREAK,temp),"")==0,"WORDNUM-6");

   k_assert(k_occurs("This is a sample sentence.",' ')==4,"OCCURS-1");
   k_assert(k_occurs("",' ')==0,"OCCURS-2");
   k_assert(k_occurs(" ",' ')==1,"OCCURS-3");

   k_assert(_StrCmp(k_justfname(foo,buffer),"INVOICES.APP")==0,"JUSTFNAME-1");
   k_assert(_StrCmp(k_justfname(foo1,buffer),"INVOICES.APP")==0,"JUSTFNAME-2");
   k_assert(_StrCmp(k_justfname(foo5,buffer),"INVOICES.APP")==0,"JUSTFNAME-3");
   k_assert(_StrCmp(k_justfname("",buffer),"")==0,"JUSTFNAME-4");
   k_assert(_StrCmp(k_justfname("   ",buffer),"")==0,"JUSTFNAME-5");

   k_assert(_StrCmp(k_justpath(foo,buffer),"C:\\FOXPRO2\\FOXAPP\\APPS")==0,"JUSTPATH-1");
   k_assert(_StrCmp(k_justpath(foo1,buffer),"FOXPRO2\\FOXAPP\\APPS")==0,"JUSTPATH-2");
   k_assert(_StrCmp(k_justpath(foo5,buffer),"C:\\FOXPRO2\\FOXAPP\\APPS")==0,"JUSTPATH-3");
   k_assert(_StrCmp(k_justpath("",buffer),"")==0,"JUSTPATH-4");
   k_assert(_StrCmp(k_justpath("   ",buffer),"")==0,"JUSTPATH-5");

   k_assert(_StrCmp(k_justdrive(foo,buffer),"C:")==0,"JUSTDRIVE-1");
   k_assert(_StrCmp(k_justdrive(foo1,buffer),"")==0,"JUSTDRIVE-2");
   k_assert(_StrCmp(k_justdrive(foo5,buffer),"C:")==0,"JUSTDRIVE-3");
   k_assert(_StrCmp(k_justdrive("",buffer),"")==0,"JUSTDRIVE-4");
   k_assert(_StrCmp(k_justdrive("  ",buffer),"")==0,"JUSTDRIVE-5");

   k_assert(_StrCmp(k_juststem(foo,buffer),"INVOICES")==0,"JUSTSTEM-1");
   k_assert(_StrCmp(k_juststem(foo1,buffer),"INVOICES")==0,"JUSTSTEM-2");
   k_assert(_StrCmp(k_juststem(foo5,buffer),"INVOICES")==0,"JUSTSTEM-3");
   k_assert(_StrCmp(k_juststem("",buffer),"")==0,"JUSTSTEM-4");
   k_assert(_StrCmp(k_juststem("   ",buffer),"")==0,"JUSTSTEM-5");

   k_assert(_StrCmp(k_justext(foo,buffer),"APP")==0,"JUSTEXT-1");
   k_assert(_StrCmp(k_justext(foo1,buffer),"APP")==0,"JUSTEXT-2");
   k_assert(_StrCmp(k_justext(foo5,buffer),"APP")==0,"JUSTEXT-3");
   k_assert(_StrCmp(k_justext("",buffer),"")==0,"JUSTEXT-4");
   k_assert(_StrCmp(k_justext("   ",buffer),"")==0,"JUSTEXT-5");

   k_assert(_StrCmp(k_addbs(foo2,buffer),"FOXPRO2\\FOXAPP\\APPS\\")==0,"ADDBS-1");
   k_assert(_StrCmp(k_addbs("C:",buffer),"C:\\")==0,"ADDBS-2");
   k_assert(_StrCmp(k_addbs("",buffer),"")==0,"ADDBS-3");
   k_assert(_StrCmp(k_addbs("   ",buffer),"")==0,"ADDBS-4");

   k_assert(_StrCmp(k_cleanpath(foo,buffer),foo)==0,"CLEANPATH-1");
   k_assert(_StrCmp(k_cleanpath(foo1,buffer),foo1)==0,"CLEANPATH-2");
   k_assert(_StrCmp(k_cleanpath(foo5,buffer),foo)==0,"CLEANPATH-3");
   k_assert(_StrCmp(k_cleanpath("",buffer),"")==0,"CLEANPATH-4");
   k_assert(_StrCmp(k_cleanpath("D:C:\\ FOXPRO2 \\\\ FOXAPP",buffer),
       "C:\\FOXPRO2\\FOXAPP")==0,"CLEANPATH-5");

   // Make sure nothing has modified the string table
   k_assert(_StrLen("FOO")==3,"STRINGLEN-1");
   k_assert(_StrLen(" FOO ")==5,"STRINGLEN-2");
   k_assert(_StrLen(" FOO")==4,"STRINGLEN-3");
   k_assert(_StrLen("FOO ")==4,"STRINGLEN-4");
   k_assert(_StrLen("BBC")==3,"STRINGLEN-5");

   _PutStr("Assert sequence completed\n");
}

//--------------------------------------------------------------------------
void far fpathtest(void)
//--------------------------------------------------------------------------
//
// Routines to test the FPATH functions.
//
// Author:  Walter J. Kennamer
// History: Initially written May 10, 1991
//--------------------------------------------------------------------------
{

   char strbuffer[MAXSTRING], bkstr[MAXSTRING], temp[MAXSTRING],
              outstr[MAXSTRING];
   int i,j;
   char *tempstr;

   k_fpathtest();

   _StrCpy(strbuffer,"   The quick     brown\tfox\tjumps over the lazy dog.\t  \n");
   _StrCpy(bkstr ,DFTBREAK);

   _StrCpy(temp,strbuffer);
   _PutStr(temp);
   _PutStr("\n");

   _PutStr("The ALLTRIM test\n");
   _StrCpy(temp,strbuffer);
   tempstr = temp;
   k_alltrim(tempstr,outstr);
   _PutStr(tempstr);
   _PutStr("\n\n");

   _PutStr("The REDUCE test\n");
   _StrCpy(temp,strbuffer);
   k_reduce(temp,bkstr,outstr,0);
   _PutStr(outstr);
   _PutStr("\n\n");

   _PutStr("The DELETE test\n");
   _StrCpy(temp,k_reduce(strbuffer,bkstr,outstr,0));
   k_delete(temp,4,outstr);
   _PutStr(outstr);
   _PutStr("\n\n");

   _PutStr("The INSERT test\n");
   _StrCpy(temp,k_reduce(strbuffer,bkstr,outstr,0));
   tempstr = temp;
   k_insert(tempstr,"Inserted: ",outstr);
   _PutStr(outstr);
   _PutStr("\n\n");

   _PutStr("The CHRTRAN test\n");
   _StrCpy(temp,k_reduce(strbuffer,bkstr,outstr,0));
   tempstr = temp;
   k_chrtran(tempstr,"e","",outstr);
   _PutStr(outstr);
   _PutStr("\n\n");

   _PutStr("The OCCURS test\n");
   _PutStr("  Count the number of 'e' characters in string.\n");
   _StrCpy(temp,k_reduce(strbuffer,bkstr,outstr,0));
   tempstr = temp;
   i = k_occurs(tempstr,'e');
   itoa(i,tempstr,10);
   _PutStr(tempstr);
   _PutStr("\n\n");

   _PutStr("The AT test\n");
   _PutStr("  Find the position of the first 's'\n");
   _StrCpy(temp,k_reduce(strbuffer,bkstr,outstr,0));
   tempstr = temp;
   i = k_at(tempstr,'s');
   tempstr = temp;
   itoa(i,tempstr,10);
   _PutStr(tempstr);
   _PutStr("\n\n");

   _PutStr("The RAT test\n");
   _PutStr("  Find the position of the last 's'\n");
   _StrCpy(temp,k_reduce(strbuffer,bkstr,outstr,0));
   tempstr = temp;
   i = k_rat(tempstr,'s');
   tempstr = temp;
   itoa(i,tempstr,10);
   _PutStr(tempstr);
   _PutStr("\n\n");

   _PutStr("The REPLICATE test\n");
   _PutStr("  Make 5 'z' characters.\n");
   tempstr = temp;
   k_replicate("z",5,tempstr);
   _PutStr(tempstr);
   _PutStr("\n\n");

   _PutStr("The STRALLTRAN test\n");
   _StrCpy(temp,k_reduce(strbuffer,bkstr,outstr,0));
   tempstr = temp;
   k_stralltran(tempstr,"the lazy","the crazy",outstr);
   _PutStr(outstr);
   _PutStr("\n\n");

   _PutStr("The PADL test\n");
   _StrCpy(temp,k_reduce(strbuffer,bkstr,outstr,0));
   tempstr = temp;
   _PutStr(k_padl(tempstr,80,outstr));
   _PutStr("\n\n");

   _PutStr("The PADR test\n");
   _StrCpy(temp,k_reduce(strbuffer,bkstr,outstr,0));
   tempstr = temp;
   _PutStr(k_padr(tempstr,79,outstr));
   _PutStr("x\n\n");

   _PutStr("The SPACES test\n");
   tempstr = temp;
   _StrCpy(tempstr,k_spaces(10,outstr));
   _fstrcat(tempstr,k_reduce(strbuffer,bkstr,outstr,0));
   _PutStr(tempstr);
   _PutStr("\n\n");

   _PutStr("The STUFF test\n");
   _StrCpy(temp,k_reduce(strbuffer,bkstr,outstr,0));
   tempstr = temp;
   k_stuff(tempstr,5,5,"lazy",outstr);
   _PutStr(outstr);
   _PutStr("\n\n");

   _PutStr("The WORDS test\n");
   _StrCpy(temp,k_reduce(strbuffer,bkstr,outstr,0));
   tempstr = temp;
   i = k_words(tempstr,bkstr);
   itoa(i,tempstr,10);
   _PutStr("There are ");
   _PutStr(tempstr);
   _PutStr(" words in the string.\n");
   _PutStr("\n\n");

   _PutStr("The WORDNUM test\n");
   _StrCpy(temp,k_reduce(strbuffer,bkstr,outstr,0));
   tempstr = temp;
   i = k_words(tempstr,bkstr);
   for(j = 1 ; j <= i ; j++)
   {
      k_wordnum(tempstr,j,bkstr,outstr);
      _PutStr(outstr);
      _PutStr("\n");
   }
   _PutStr("\n\n");

   _PutStr("The FCTNPARM test\n");
   _StrCpy(strbuffer,"function(a+b,c+d,foo(e-f+g,h),i)\n");
   _PutStr(strbuffer);
   for(j = 1 ; j <= 4 ; j++)
   {
      k_fctnparm(strbuffer+8,j,outstr);
      _PutStr(_fstrcat(outstr,"\n"));
   }
   _RetChar("\0");
   return;

}

FoxInfo myFoxInfo[] = 
   {
   {"JUSTFNAME",(FPFI) justfname,1,"?"},        // just file name (stem+ext)
   {"JUSTSTEM",(FPFI) juststem,1,"?"},          // just stem name
   {"JUSTEXT",(FPFI) justext,1,"?"},            // just file extension
   {"JUSTPATH",(FPFI) justpath,1,"?"},          // just path name (no file name)
   {"JUSTDRIVE",(FPFI) justdrive,1,"?"},        // just drive designation
   {"FORCEEXT",(FPFI) forceext,2,"?,?"},        // force file extension to ...
   {"DEFAULTEXT",(FPFI) defaultext,2,"?,?"},    // give file a default extension
   {"ADDBS",(FPFI) addbs,1,"?"},                // add a backslash if one is needed
   {"VALIDPATH",(FPFI) validpath,1,"?"},        // is this a valid path/file name?
   {"CLEANPATH",(FPFI) cleanpath,1,"?"},        // clean up a file/path name'
   {"REDUCE",(FPFI) reduce,3,"?,.C,.I"},        // reduce white space to single blank
   {"STRFILTER",(FPFI) strfilter,2,"?,C"},      // filter out anything that isn't in second string
   {"WORDS",(FPFI) words,2,"?,.C"},             // number of words in string
   {"WORDNUM",(FPFI) wordnum,3,"?,I,.C"},       // word number i from string
   {"NEXTWORD",(FPFI) nextword,3,"?,I,.C"},     // next word from string
   {"FCTNPARM",(FPFI) fctnparm,2,"C,I"},        // function parameter i
   {"BXOR",(FPFI) bxor,2,"I,I"},                // xor two numbers
   {"BOR",(FPFI) bor,2,"I,I"},                  // or two numbers
   {"BAND",(FPFI) band,2,"I,I"},                // and two numbers
   {"BNOT",(FPFI) bnot,1,"I"},                  // not a number
   {"BSHR",(FPFI) bshr,2,"I,.I"},               // shift a number right
   {"BSHL",(FPFI) bshl,2,"I,.I"},               // shift a number left
   {"DBL2NUM",(FPFI) dbl2num,1,"?"},            // convert 8-byte double to Fox num
   {"NUM2DBL",(FPFI) num2dbl,1,"?"},            // convert Fox num to 8-byte double
   {"FLOAT2NUM",(FPFI) float2num,1,"?"},        // convert 6-byte float to Fox num
   {"LONG2NUM",(FPFI) long2num,1,"?"},          // convert 6-byte float to Fox num
   {"INT2NUM",(FPFI) int2num,1,"?"},            // convert 6-byte float to Fox num
   {"FPATHTEST",(FPFI) fpathtest,1,".C"}        // testing function
   };

FoxTable _FoxTable = 
   {
   (FoxTable FAR *)0, sizeof(myFoxInfo)/ sizeof(FoxInfo), myFoxInfo
   };
