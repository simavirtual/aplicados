/***
*
*  Ord.ch
*
*  Standard definitions for extended Index capabilities (some are supported
*  only by DBFCDX)
*
*/

#command INDEX ON <key> [TAG <(cOrder)>] TO <(cBag)>                    ;
            [FOR <for>]                                                 ;
            [WHILE <while>]                                             ;
            [<lUnique: UNIQUE>]                                         ;
            [<ascend: ASCENDING>]                                       ;
            [<descend: DESCENDING>]                                     ;
            [<lUsecurrent: USECURRENT>]                                 ;
            [<lAdditive: ADDITIVE>]                                     ;
            [EVAL <eval> [ EVERY <nEvery> ]]                            ;
            [<lCustom: CUSTOM>]                                         ;
            [<lNoOpt: NOOPTIMIZE>]                                                                          ;
    =>  ordCondSet( <"for">, <{for}>,                                   ;
                     nil,                                               ;
                     <{while}>,                                         ;
                     <{eval}>, <nEvery>,                                ;
                     nil, nil, nil,                                     ;
                     nil, [<.descend.>],                                ;
                     nil, <.lAdditive.>, <.lUsecurrent.>, <.lCustom.>,  ;
                     <.lNoOpt.>)                                        ;
        ;  ordCreate(<(cBag)>, <(cOrder)>, <"key">, <{key}>, [<.lUnique.>])

#command INDEX ON <key> TAG <(cOrder)> [TO <(cBag)>]                    ;
            [FOR <for>]                                                 ;
            [WHILE <while>]                                             ;
            [<lUnique: UNIQUE>]                                         ;
            [<ascend: ASCENDING>]                                       ;
            [<descend: DESCENDING>]                                     ;
            [<lUsecurrent: USECURRENT>]                                 ;
            [<lAdditive: ADDITIVE>]                                     ;
            [EVAL <eval> [ EVERY <nEvery> ]]                            ;
            [<lCustom: CUSTOM>]                                         ;
            [<lNoOpt: NOOPTIMIZE>]                                                                          ;
    =>  ordCondSet( <"for">, <{for}>,                                   ;
                     nil,                                               ;
                     <{while}>,                                         ;
                     <{eval}>, <nEvery>,                                ;
                     nil, nil, nil,                                     ;
                     nil, [<.descend.>],                                ;
                     nil, <.lAdditive.>, <.lUsecurrent.>, <.lCustom.>,  ;
                     <.lNoOpt.>)                                        ;
        ;  ordCreate(<(cBag)>, <(cOrder)>, <"key">, <{key}>, [<.lUnique.>])


#define TOPSCOPE			0
#define BOTTOMSCOPE			1


/* Codes for SELF_ORDINFO() */

#define DBOI_CONDITION     1  /* Get the order condition     */
#define DBOI_EXPRESSION    2  /* Get the order expression    */
#define DBOI_POSITION      3  /* Get the order position      */
#define DBOI_RECNO         4  /* Get the order record number */
#define DBOI_NAME          5  /* Get the order list name     */
#define DBOI_NUMBER        6  /* Get the order list position */
#define DBOI_BAGNAME       7  /* Get the order Bag name      */
#define DBOI_BAGEXT        8  /* Get the order Bag Extension */
#define DBOI_INDEXEXT      DBOI_BAGEXT
#define DBOI_INDEXNAME     DBOI_BAGNAME
#define DBOI_ORDERCOUNT    9  /* Get the number of orders in the index file */
#define DBOI_FILEHANDLE   10  /* Get the handle of the index file */
#define DBOI_ISCOND       11  /* Get the flag if the order has a for condition */
#define DBOI_ISDESC       12  /* Get the flag if the order is descending */
#define DBOI_UNIQUE       13  /* Get the flag if the order has the unique attribute set */

/* New constants */
#define DBOI_FULLPATH			20	/* Get the order Bag Full Path			*/
#define DBOI_KEYTYPE			24	/* Get the keytype of order 			*/
#define DBOI_KEYSIZE			25	/* Get the keysize of order 			*/
#define DBOI_KEYCOUNT			26	/* Get the number of keys				*/
#define DBOI_SETCODEBLOCK		27	/* Set codeblock for order key			*/
#define DBOI_KEYDEC 			28	/* Get decimals of order keyt			*/
#define DBOI_HPLOCKING			29	/* High performance index locking		*/
#define DBOI_LOCKOFFSET 		35	/* New locking offset					*/

#define DBOI_KEYADD 			36	/* Gets/Sets the Key to be added		*/
#define DBOI_KEYDELETE			37	/* Gets/Sets the Key to be deleted		*/
#define DBOI_KEYVAL 			38	/* Get current key value				*/
#define DBOI_SCOPETOP			39	/* Gets/Sets top of scope				*/
#define DBOI_SCOPEBOTTOM		40	/* Gets/Sets bottom of scope			*/
#define DBOI_SCOPETOPCLEAR		41	/* Clears top scope setting 			*/
#define DBOI_SCOPEBOTTOMCLEAR	42	/* Clears bottom scope setting			*/

#define DBOI_CUSTOM 			45	/* Custom created order 				*/
#define DBOI_SKIPUNIQUE 		46	/* Flag for skip unique 				*/

#define DBOI_KEYSINCLUDED		50  /* # of keys included while indexing	*/
#define DBOI_KEYGOTO                    DBOI_POSITION   /* keyno                                        */
#define DBOI_KEYNORAW			51  /* keyno ignoring any filter			*/
#define DBOI_KEYCOUNTRAW		52	/* keycount ignoring any filter			*/
#define DBOI_OPTLEVEL			53  /* Optimization achieved for last query	*/

	//	Ideally shoud be an entry point that doesn't require an open table
#define DBOI_STRICTREAD			60  /* Get/set read thru RDD when indexing	*/
#define DBOI_OPTIMIZE			61	/* Get/set use of query optimization	*/
#define DBOI_AUTOOPEN			62	/* Get/set auto open of production index	*/
#define DBOI_AUTOORDER			63	/* Get/set default order of production index	*/
#define DBOI_AUTOSHARE			64	/* Get/set automatic sharing control	*/


/* Codes for SELF_INFO() */
/* DBI_* are defined in DBINFO.CH */


/* codes for SELF_RECINFO() */
/* DBRI_* are defined in DBINFO.CH */


/* codes for SELF_FIELDINFO() */
#define DBS_NAME          1
#define DBS_TYPE          2
#define DBS_LEN           3
#define DBS_DEC           4


/* SCOPE and related SETS */
#command SET SCOPE TO                                                   ;
    =>  ordScope(0, nil)                                                ;
        ; ordScope(1, nil)

#command SET SCOPE TO <xValue>                                          ;
    =>  ordScope(0, <xValue>)                                           ;
        ; ordScope(1, <xValue>)

#command SET SCOPE TO <xVal1>, <xVal2>                                  ;
    =>  ordScope(0, <xVal1>)                                            ;
        ; ordScope(1, <xVal2>)

#xcommand SET SCOPETOP TO                                               ;
    =>  ordScope(0, nil)

#xcommand SET SCOPETOP TO <xValue>                                      ;
    =>  ordScope(0, <xValue>)

#xcommand SET SCOPEBOTTOM TO                                            ;
    =>  ordScope(1, nil)

#xcommand SET SCOPEBOTTOM TO <xValue>                                   ;
    =>  ordScope(1, <xValue>)

#xcommand SET DESCENDING ON                                             ;
    =>  ordDescend(,, .t.)

#xcommand SET DESCENDING OFF                                            ;
    =>  ordDescend(,, .f.)
