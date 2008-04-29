/*-------------------------------------------------------------*
 *                                                             *
 * Korean Part-Of-Speech Tagging System ( kts ) Version 0.9    *
 *                                                             *
 * Sang Ho Lee                                                 *
 *                                                             *
 * jhlee@csone.kaist.ac.kr shlee2@adam.kaist.ac.kr             *
 *                                                             *
 * Computer Systems Lab.                                       *
 * Computer Science , KAIST                                    *
 *                                                             *
 * ktsdefs.h ( Korean Tagging System Defines Header File )     *
 *                                                             *
 *-------------------------------------------------------------*/

#ifndef __NEWTYPE__
#define __NEWTYPE__

typedef unsigned char UCHAR ; 
typedef short int     SINT  ; 
typedef short int     FLAG  ; 

#endif

#ifndef PRIVATE
#define PRIVATE static
#endif

#ifndef PUBLIC
#define PUBLIC
#endif

#ifndef EXTERN
#define EXTERN extern
#endif

#ifndef __NUMOFTAG__
#define __NUMOFTAG__ 55  /* contains INI , FIN */
#endif

#ifndef __TAGINITIALS__
#define __TAGINITIALS__
#define __INI__ "INI"
#define __FIN__ "FIN"
#endif

#ifndef __DICTFORMAT__
#define __DICTFORMAT__
#define F_T    'T'      /* Format : T : Tag                                   */
#define F_P    'P'      /* Format : P : Pre-Morph-Analyzed                    */
#define F_S    'S'      /* Format : S : Semantics                             */
#define F_M    'M'      /* Format : M : Marker                                */
#define F_L    'L'      /* Format : L : Lookahead like Trie : not implemented */
#define F_F    'F'      /* Format : F : Preference Morph-Analyzed             */
#endif


#ifndef __SENTAG__
#define __SENTAG__

#define __MAXMORPH__      51  /* �ϳ��� ���¼��� �ִ� ���� ( �̼��� code )  */
#define __BUFFERLENGTH__ 1024 /* sentence buffer length                     */
#define __SENTLENGTH__   570 /* sentence�� �ִ� ���¼� ����                */
#define __NUMEOJEOLINSENT__ 60 /* �� ����ȿ� �ִ� ������ ����            */
#define __EOJEOLLENGTH__ 100  /* ������ �̼��� code�� ��ȯ�� ��  �ִ� ���� */ 
#define __WSPARE__       100  /* input word�� ��ȭ�� ���� ������           */
#define __SKIPVALUE__      6  /* node���� ���� : ���ڰ� __SKIPVALUE__ ���� */
#define __NUMIRR__        20  /* ó���� �ִ� �ұ�Ģ ������ ����            */
#define __NUMMORPH__     570  /* morph pool�� ũ��                         */
#define __NUMWSM__         3  /* ���ο� ȯ���� ���� ���ɼ�                 */
#define __NUMCONNECTION__ 80  /* ���¼Ұ� ���� ���¼ҿ� ���� ���ɼ�        */
#define __NUMATTR__       40  /* ���¼��� ambiguity                        */
#define __ATTRSIZE__      40  /* ���¼��� ������ (Format,Value)�� ũ��     */
#define __NUMPREMORANAL__ 10  /* ���¼� ��м��� �ִ� ���¼� ����          */
#define __MAXPATHLEN__    50  /* ���� �ϳ��� ���� ���¼��� �ִ� ��         */  
#define __MAXNUMPATH__   900  /* ���� �ϳ��� ���� ������ Path�� ����       */
#define __MAXPTTRN__     300  /* �̵�Ͼ� ������ ���� �ִ� tag pattern ��  */
#define __NUMOFOPENCLASS__ 12 /* �̵�Ͼ� �����Ǵ� tag ����                */
#define __TEMPPATHSIZE__ __MAXNUMPATH__ /* path ó���� ���� ���� ���      */
#define __TEMPPROB__     900 /* ML Tagging : gammaprob�� sorting�ϱ� ����  */ 
#define __PTTRNTOT__     650 /* lexical pattern�� Max value                */ 

#define _HAN_ 'H'   /* Hanguel              */
#define _ENG_ 'E'   /* English              */
#define _COM_ ','   /* Symbol : ,           */
#define _PER_ '.'   /* Symbol : PERIOD .    */
#define _SEN_ '?'   /* Symbol : ? ! .       */
#define _OPE_ 'O'   /* Symbol : { ( [       */
#define _CLO_ 'C'   /* Symbol : } ) ]       */
#define _NUM_ 'N'   /* Symbol : 0 .. 9      */
#define _SPA_ 'S'   /* Symbol : Space , Tab */
#define _STA_ '$'   /* Symbol : Start       */
#define _EOL_ '#'   /* Symbol : End OF Line */
#define _CON_ '-'   /* Symbol : - --        */
#define _UNI_ '@'   /* Symbol : Unit %      */
#define _CUR_ '!'   /* Symbol : Currency $  */
#define _OTH_ '*'   /* Symbol : Others ...  */

#endif

