/***
*	extend.h
*
*	DEFINEs and EXTERNs for interfacing with Clipper from C.
*
*	Large model C only (double word pointers to code and data)
*
*	Copyright (c) Nantucket Corporation 1987
*/

#define CLIPPER		void pascal

/* _parinfo types */
#define UNDEF		0
#define CHARACTER	1
#define NUMERIC		2
#define LOGICAL		4
#define DATE		8
#define ALIAS		16
#define MPTR		32		/* or'ed with type when passed by reference */
#define MEMO		65
#define WORD		128
#define ARRAY		512


/* parameter count/type */
extern int _parinfo(int);
extern int _parinfa(int, int);


/* parameter values */
extern char *_parc(int, ...);
extern int _parcsiz(int, ...);
extern int _parclen(int, ...);
extern int _parni(int, ...);
extern long _parnl(int, ...);
extern double _parnd(int, ...);
extern int _parl(int, ...);
extern char *_pards(int, ...);


/* one and only one of the _ret?? functions must used */

/* Clipper-function return values */
extern void _retc(char *);
extern void _retclen(char *, int);
extern void _retni(int);
extern void _retnl(long);
extern void _retnd(double);
extern void _retl(int);
extern void _retds(char *);

/* procedure (DO) return */
extern void _ret(void);


/* allocate memory */
/* parameter:  requested size in bytes */
/* returns:  far pointer to memory or NULL */
extern unsigned char *_exmgrab(unsigned);

/* free allocated memory */
/* parameters:  pointer from _exmgrab(), same size passed to _exmgrab() */
extern void _exmback(unsigned char *, unsigned);


/* misc. */
extern unsigned strlen(unsigned char *);


/* parameter check macros */
#define PCOUNT		(_parinfo(0))
#define ISCHAR(n)	(_parinfo(n) & CHARACTER)
#define ISNUM(n)	(_parinfo(n) & NUMERIC)
#define ISLOG(n)	(_parinfo(n) & LOGICAL)
#define ISDATE(n)	(_parinfo(n) & DATE)
#define ISMEMO(n)	(_parinfo(n) & MEMO)
#define ISBYREF(n)	(_parinfo(n) & MPTR)
#define ISARRAY(n)	(_parinfo(n) & ARRAY)
#define ALENGTH(n)	(_parinfa(n, 0))

/* Header structure */
typedef struct
{
	byte signature;		/* 03 = dbf, 83 dbf+dbt */
	byte ymd[3];		/* y+1900 m d */
	long last_rec;
	quant data_off;
	quant rec_size;
	byte pad[20];
} DBF_HEADER;


extern DBF_HEADER *_dbfhead();
extern int _dbfopen();

