/***
*   examplec.c
*
*   Example "C" functions using the CLIPPER Extend interface.
*   
*   The CLIPPER callable functions are.....
*
*       SOUNDEX()
*       STUFF()          
*       DISKSPACE()
*
**/


/***
*   SOUNDEX()
*   kevin j. shepherd, NANTUCKET Corporation.
*   09/14/87
*
*   Produces a code based on the "Soundex" method originally developed
*       by M.K. Odell and R.C. Russell.  Algorithm can be found on page
*       392 of Knuths' book 'Sorting and Searching', volume 3 of 'The Art
*       of Computer Programming", Addison/Wesley publisher.
*
*   code = SOUNDEX(name)
*
*       code    -   character string.
*       name    -   character string.
*
*   Non-alphabetic characters in input stream will cause the function
*       to abort and return a NULL pointer.
*
**/

#include "nandef.h"
#include "extend.h"

#define ISALPHA(c)  ((c) >= 'a' && (c) <= 'z' || (c) >= 'A' && (c) <= 'Z')
#define UPPER(c)    ((c) >= 'a' && (c) <= 'z' ? (c) - 32 : (c))

#define MAX_OMITS   9   /** characters to be ignored **/
#define MAX_GROUPS  6   /** +1 for NULL pointer in static declare/init **/
#define MAX_DIGITS  4   /** number of digits in code sequence **/
#define CODE_ALLOC  5   /** size of code sequence **/

static byte omit_letter[MAX_OMITS]   = " AEHIOUWY";
static byte *code_group[MAX_GROUPS + 1] =  {
                                            "BFPV",
                                            "CGJKQSXZ",
                                            "DT",
                                            "L",
                                            "MN",
                                            "R",
                                            NULL                                            
                                        };

extern Boolean  name_2_code();
extern byte     translate();
extern Boolean  omit();


/***
*
*   soundex()
*   kjs
*   09/14/87
*
*   Main soundex function, does param checking, allocation, string prep,
*       and deallocation.
*
**/


CLIPPER SOUNDEX()

{
    Boolean error;

    quant i;
    quant name_size;

    byte *name;
    byte *code;

	code = NULL;
    error = (PCOUNT != 1 || !ISCHAR(1) || _parclen(1) == 0);

    if (!error)
    {
        name      = _parc(1);
        name_size = (quant)(_parclen(1) + 1);   /** +1 for NIL byte **/

        code = _exmgrab(name_size >= CODE_ALLOC ? name_size : CODE_ALLOC);

        /** make uppercase **/
        for (i = 0; i < name_size; i++)
            name[i] = UPPER(name[i]);

        error = name_2_code(name, name_size, code);
    }

    if (!error)
        _retc(code);
    else
        _retc("");

    if (code)
        _exmback(code, name_size >= CODE_ALLOC ? name_size : CODE_ALLOC);
}


/***
*
*   name_2_code()
*   kjs
*   09/14/87
*
*   Converts a name into 4 unit code (alpha, digit, digit, digit)
*       as per the SOUNDEX method rules.
*
*   error = name_2_code(source, source_size, target)
*
**/

Boolean name_2_code(source, source_size, target)

byte  *source;
quant source_size;
byte  *target;

{
    Boolean error;

    quant i;
    quant j;

    error = FALSE;

    /** first character not translated **/
    target[0] = source[0];
    i = 1;
    j = 1;

    /** copy while filtering unwanted characters **/
    while (i < (source_size - 1) && !error)
    {
        if ((target[j - 1] != source[i]) && !omit(source[i]))
        {
            error = !ISALPHA(source[i]);

            if (!error)
            {
                target[j] = source[i];
                j++;
            }
        }

        i++;
    }

    /** truncate string **/
    if (j > MAX_DIGITS)
        j = MAX_DIGITS;

    target[j] = NIL;        

    if (!error)
    {
        /** translation **/
        for (i = 1; i < j; i++)
            target[i] = translate(target[i]);

        /** zero fill **/
        for (i = j; i < MAX_DIGITS; i++)
            target[i] = '0';

        target[i] = NIL;        
    }

    return (error);
}


/***
*
*   translate()
*
*   Translates a character into a code digit.
*
*   digit = translate(chr)
*
**/

byte translate(chr)

byte chr;

{
    Boolean found;
    
    quant i;
    quant j;

    byte digit;

    found = FALSE;

    i = 0;
    j = 0;

    digit = NIL;
    
    /** scan groups until match is found **/
    while (i < MAX_GROUPS && !found)
    {
        /** scan the list of character in this group **/
        j = 0;
        while (j < strlen(code_group[i]) && !found)
        {
            found = (chr == code_group[i][j]);
            j++;
        }

        if (!found)
            i++;
    }

    digit = (i + 1) + 48;   /** convert the subscript to asci **/

    return (digit);
}


/***
*
*   omit()
*
*   Check the character if it is on the omit list.
*
*   status = omit(chr)
*
**/

Boolean omit(chr)

byte chr;

{
    quant i;

    Boolean found;

    found = FALSE;

    for (i = 0; (i < MAX_OMITS && !found); i++)
        found = (chr == omit_letter[i]);    

    return (found);
}


/***
*   STUFF()
*   kevin j. shepherd, NANTUCKET Corporation.
*   09/13/87
*
*   Replace LENGTH number of characters in SOURCE starting at START
*       with the entire MODIFIER string.
*
*   target = STUFF(source, start, length, modifier)
*
*       target      -   character string.       
*       source      -   character string.
*       start       -   numeric.
*       length      -   numeric.
*       modifier    -   character string.
*
**/

CLIPPER STUFF()
{
    quant i;
    quant j;
    quant s_max;
    quant m_max;
    quant buffer_size;

    quant start;
    quant length;

    byte  *source;
    byte  *modifier;
    byte  *buffer;

    /** parameter OK? **/
    if (PCOUNT == 4 && ISCHAR(1) && ISNUM(2) && ISNUM(3) && ISCHAR(4) &&
        _parclen(1) + _parclen(4) > 0)
    {
        /** local copies **/
        source   = _parc(1);
        modifier = _parc(4);
        start    = (quant)(_parnl(2) >= 0 ? _parnl(2) : 0);
        length   = (quant)(_parnl(3) >= 0 ? _parnl(3) : 0);

        /** string sizes **/
        s_max = (quant)_parclen(1);
        m_max = (quant)_parclen(4);

        /** allocate a work buffer. **/
        buffer_size = _parclen(1) + _parclen(4) + 1;
        buffer = _exmgrab(buffer_size);

        /** adjust dBASE string base values to 'C' base, off-by-one, yea! **/
        start = (start > 0 ? start - 1 : 0);

        /** get first part of source string. **/
        j = 0;
        while (j < start && j < s_max)
        {
            buffer[j] = source[j];
            j++;
        }
        
        /** insert **/
        i = 0;
        while (i < m_max)
        {
            buffer[j] = modifier[i];
            j++;
            i++;
        }

        /** copy the rest of the source string. **/
        i = start + length;
        while (i < s_max)
        {
            buffer[j] = source[i];
            j++;
            i++;
        }

        buffer[j] = NIL;

        _retclen(buffer, j);

        _exmback(buffer, buffer_size);
    }
    else
    {
        _retc("");
    }
}


/***
*   DISKSPACE()
*   Tom Rettig, Brian Russell
*   11/01/85
*
*   Bytes of empty space on a disk drive.  The drive is specified by the 
*       drive_code parameter.  DRIVE_CODE is a numeric from 0 to n. 
*       0 is the default if code is omitted and indicates the 
*       currently selected drive.  1 to n reference drives A to x.
*
*   count = DISKSPACE([drive_code])
*
*       count       -   numeric.
*       drive_code  -   numeric.
*
*   Placed in the public domain by Tom Rettig Associates.
*   
**/

#define DEFAULT      0

CLIPPER DISKSPACE()
{
   struct                       /* structure to hold disk info */
   {
      unsigned no_clusts;       /* number of free clusters */
      unsigned secs_clusts;     /* sectors per cluster */
      unsigned clusts_drv;      /* total clusters per drive */
   } drv_info;

   /* if there is one parameter and it is numeric */
   if (PCOUNT == 1 && ISNUM(1))
   {
      _dspace(_parni(1), &drv_info);  /* specified drive */
   }
   else
      _dspace(DEFAULT, &drv_info);    /* default drive */

   /* bytes ::= number of clusters times sectors per cluster times 512 */

   _retnl(512L * (long)drv_info.secs_clusts * (long)drv_info.no_clusts);
}

