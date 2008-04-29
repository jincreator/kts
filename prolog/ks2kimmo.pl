/************************************************************************************/
/***        kimmo code 와 한글 완성형 코드(KSC-5601)의 상호 변환 rouine.          ***/
/***                                                                              ***/
/***                            by     Lee sangho.  Kaist, Korea.                 ***/
/***                            Email  shlee@csone.kaist.ac.kr    1993/7/10       ***/
/************************************************************************************/

/*  kstable는 완성형 코드 대 조합형 코드의 table이다.  */
:- consult('kstable').   

/* whatType은 CH(kimmo code)의 type(초성,중성,종성)을 return */ 
whatType(CH,TYPE) :- is_Jungs(CH,TYPE), !.
whatType(CH,TYPE) :- is_Chos(CH,TYPE), !.
whatType(CH,TYPE) :- is_Jongs(CH,TYPE), !.  
whatType(_,none).
is_Chos(CH,chos) :- chos(CH).
is_Jungs(CH,jungs) :- jungs(CH).
is_Jongs(CH,jongs) :- jongs(CH).

/* 초성의 kimmo code */
chos(p).  chos(g).  chos(h).  chos(q).  chos(n).  chos(d).  chos(l).
chos(m).  chos(b).  chos(r).  chos(s).  chos(v).  chos(f).  chos(j).
chos(z).  chos(c).  chos(k).  chos(t).  
/* 중성의 kimmo code */
jungs(a).   jungs(8).  jungs(ya). jungs(y8).  jungs(e).   jungs(9).
jungs(ye).  jungs(y9). jungs(o).  jungs(wa).  jungs(w8).  jungs(wi).
jungs(yo).  jungs(u).  jungs(we). jungs(w9).  jungs(wu).  jungs(yu).
jungs('_'). jungs(yi). jungs(i). 
/* 종성의 kimmo code */
jongs('G').  jongs('Q').  jongs('GS'). jongs('N').  jongs('NJ'). jongs('NH').
jongs('D').  jongs('L').  jongs('LG'). jongs('LM'). jongs('LB'). jongs('LS').
jongs('LP'). jongs('LT'). jongs('LH'). jongs('M').  jongs('B').  jongs('BS').
jongs('S').  jongs('V').  jongs('*').  jongs('J').  jongs('C').  jongs('K').
jongs('T').  jongs('P').  jongs('H'). 

/***********************************************************/
/*  완성형 한글 코드를 kimmo code로 상호 전환 하는 routine */
/*               MAIN  FUNCTION                            */
/***********************************************************/
ks2kimmo(X,Y) :- var(X), var(Y), !, fail.
ks2kimmo(X,Y) :- var(X), kimmo2ks(Y,X), !.
ks2kimmo(X,Y) :- var(Y), ks2kimmoSub(X,Y), !.
ks2kimmo(X,Y1) :- ks2kimmoSub(X,Y1).

/* kimmo code를 완성형 한글 코드로 변형 */
kimmo2ks([],[]) :- !.
kimmo2ks(LIST,Output) :- 
	kimmoConv(LIST,Output1), 
	removeSpace(Output1,Output2),
	makeString(Output2,Output), !.

kimmoConv([],[]).
kimmoConv([H|T],Output) :-
	kimmoWord(H,Output1), 
	kimmoConv(T,Output2),
	cat(Output1,[' '],Output3),
	cat(Output3,Output2,Output).

kimmoWord([],[]).                                  /* kimmo code를 어절단위로 처리 */
kimmoWord([H|T],Output) :-
	kimmoWordSub(H,Output1), 
	kimmoWord(T,Output2),
	cat(Output1,Output2,Output).

kimmoWordSub([],[]).
kimmoWordSub([eng|T],T).                           /* 영어를 처리 */
kimmoWordSub([sym|T],T).                           /* symbol를 처리 */
kimmoWordSub([num|T],T).                           /* 숫자를 처리 */
kimmoWordSub([kor|T],[Output2]) :-                 /* 한글을 처리 */
	makeList(T,T1), 
	kimmoHangul(T1,Output1,_), 
	name(Output2,Output1). 
kimmoWordSub([chr|T],[Output]) :-                  /* 불완전한 한글 처리 */
        ksc_s_c(C1,C2,T), name(Output,[C1|[C2]]).

kimmoHangul([[]],[],[[]]).                         /* kimmo code를 완성형 한글로 변형 */
kimmoHangul([H|T],Output,Next) :-
	whatType(H,Type), 
	kimmoHangulSub(Type,[H|T],Output1,Next1),
	kimmoHangul(Next1,Output2,Next),
	cat(Output1,Output2,Output).

/*************************************************************************************/
/** kimmoHangulSub와 kimmoHangulChos, kimmoHangulChosSub는 연속적으로 들어오는      **/
/** kimmo code를 한 글자단위로 잘라서 완성형 code로 바꾸는 것이다.                  **/
/** 여기서 kimmo code를 완성형 코드로 mapping시키는 routine는 ksc_s_c이다.          **/
/** 여기서 사용한 rule은 다음과 같다.                                               **/
/**   초성 -> 중성 -> 종성                                                          **/ 
/**   초성 -> 중성                                                                  **/
/**   초성                                                                          **/
/**   중성 -> 종성                                                                  **/
/**   중성                                                                          **/
/**   종성                                                                          **/
/*************************************************************************************/


kimmoHangulSub(chos,[H|[]],[C1|[C2]],[[]]) :-
	Output1 = [H], ksc_s_c(C1,C2,Output1).
kimmoHangulSub(chos,[H|T],[C1|[C2]],Next) :-
	move(H1,_,T), whatType(H1,Type), 
	kimmoHangulChos(Type,T,Output1,Next), 
	Output2 = [H|Output1], ksc_s_c(C1,C2,Output2).
kimmoHangulSub(jungs,[H|[]],[C1|[C2]],[[]]) :-
	Output1 = [H], ksc_s_c(C1,C2,Output1).
kimmoHangulSub(jungs,[H|T],[C1|[C2]],Next) :-
	move(H1,_,T), whatType(H1,Type), 
	kimmoHangulJungs(Type,T,Output1,Next), 
	Output2 = [H|Output1], ksc_s_c(C1,C2,Output2).
kimmoHangulSub(jongs,[H|[]],[C1|[C2]],[[]]) :-
	Output1 = [H], ksc_s_c(C1,C2,Output1).
kimmoHangulSub(jongs,[H|Next],[C1|[C2]],Next) :-
	Output1 = [H], ksc_s_c(C1,C2,Output1).
kimmoHangulSub(none,[_|[]],[],[[]]).
kimmoHangulSub(none,[_|Next],[],Next).

kimmoHangulChos(jongs,Next,[],Next).
kimmoHangulChos(chos,Next,[],Next).
kimmoHangulChos(jungs,[H|[]],[H],[[]]).
kimmoHangulChos(jungs,[H|T],[H],[H1|T1]) :-
	move(H1,T1,T), whatType(H1,Type), 
	Type \== jongs.
kimmoHangulChos(jungs,[H|T],[H|[H1]],Next) :-
	move(H1,T1,T), whatType(H1,Type), 
	Type == jongs, kimmoHangulChosSub(T1,Next).

kimmoHangulJungs(jungs,Next,[],Next).
kimmoHangulJungs(chos,Next,[],Next).
kimmoHangulJungs(jongs,[H|[]],[H],[[]]).
kimmoHangulJungs(jongs,[H|T],[H],T).

kimmoHangulChosSub([],[[]]).
kimmoHangulChosSub(T,T).

/*  완성형 한글 코드를 kimmo code로 바꾸는 것 */
ks2kimmoSub('',[]) :- !. 
ks2kimmoSub(LIST,Output) :- 
	name(LIST,LIST1), 
	ksConv([],LIST1,Output,_,_), !.


ksConv(9,[],[],[],[[]]). 
ksConv(9,[H|T],Output,X,Y) :- 
	ksConv(H,T,Output,X,Y).
ksConv(10,[],[],[],[[]]). 
ksConv(10,[H|T],Output,X,Y) :- 
	ksConv(H,T,Output,X,Y).
ksConv(32,[],[],[],[[]]). 
ksConv(32,[H|T],Output,X,Y) :- 
	ksConv(H,T,Output,X,Y).
ksConv([],[[]],[],[],[[]]).
ksConv([],[H|T],Output,_,_) :- 
	ksConv(H,T,Output,_,_).
ksConv(H,T,[Output1|Output2],X,Y) :-
	ksWord(H,T,Output1,X,Y), 
	ksConv(X,Y,Output2,_,_).

ksWord(9,[],[],[],[[]]).                           /* TAB을 어절단위로 처리 */
ksWord(9,[H|T],[],H,T).
ksWord(10,[],[],[],[[]]).                           /* RETURN을 어절단위로 처리 */
ksWord(10,[H|T],[],H,T).
ksWord(32,[],[],[],[[]]).                           /* SPACE을 어절단위로 처리 */
ksWord(32,[H|T],[],H,T).
ksWord([],[[],[]],[],[[]]).
ksWord([],[[]],[],[],[[]]).
ksWord(H,T,[[chr|[Output3]]|Output2],X,Y) :-        /* 불완전한 한글을 처리 */
	H > 127, ksChar(H,T,Output1,X1,Y1), 
	ksWord(X1,Y1,Output2,X,Y),
	makeString(Output1,Output3).
ksWord(H,T,[[kor|[Output3]]|Output2],X,Y) :-        /* 한글을 처리  */
	H > 127, ksHangul(H,T,Output1,X1,Y1), 
	ksWord(X1,Y1,Output2,X,Y),
	makeString(Output1,Output3).
ksWord(H,T,[[num|[Output3]]|Output2],X,Y) :-        /* 숫자를 처리 */
	47 < H, H < 58, ksNum(H,T,Output1,X1,Y1), 
	ksWord(X1,Y1,Output2,X,Y),
	makeString(Output1,Output3).
ksWord(H,T,[[eng|[Output3]]|Output2],X,Y) :-        /* 영어를 처리 */
	((64 < H, H < 91); (96 < H, H < 123)), 
	ksEng(H,T,Output1,X1,Y1), 
	ksWord(X1,Y1,Output2,X,Y),
	makeString(Output1,Output3).
ksWord(H,T,[[sym|[Output3]]|Output2],X,Y) :-        /* symbol을 처리 */
	H < 128, ksSym(H,T,Output1,X1,Y1), 
	ksWord(X1,Y1,Output2,X,Y),
	makeString(Output1,Output3).

ksChar(H,T,Code,X,Y) :-
	move(H1,T1,T), ksc_s_c(H,H1,Code), !,
	countAtom(Code), Code = [CH], !, 
        not(jungs(CH)), move(X,Y,T1). 

ksHangul([],_,[],[],[[]]).                             /* 완성형 코드 --> kimmo code */
ksHangul(H,T,Output,X,Y) :-
	move(H1,T1,T), ksc_s_c(H,H1,Code), move(H2,T2,T1),
	ksHangulSub(H2,T2,Output1,X,Y),
	cat(Code,Output1,Output).
	
ksHangulSub([],_,[],[],[[]]). 
ksHangulSub(9,T,[],9,T).
ksHangulSub(10,T,[],10,T).
ksHangulSub(32,T,[],32,T).
ksHangulSub(H,T,[],H,T) :- 
	(H < 128; (47 < H, H < 58)). 
ksHangulSub(H,T,[],H,T) :-
	H > 127, ksChar(H,T,_,_,_).
ksHangulSub(H,T,Output,X,Y) :-
	H > 127, ksHangul(H,T,Output,X,Y).

ksNum([],_,[],[],[[]]).                                /* 숫자를 처리 */
ksNum(H,T,[Code|Output1],X,Y) :-
	move(H1,T1,T), 
	ksNumSub(H1,T1,Output1,X,Y),
	name(Code,[H]).

ksNumSub([],_,[],[],[[]]).
ksNumSub(9,T,[],9,T).
ksNumSub(10,T,[],10,T).
ksNumSub(32,T,[],32,T).
ksNumSub(H,T,[],H,T) :-
	(48 > H; H > 57). 
ksNumSub(H,T,Output,X,Y) :-
	47 < H,H < 58, ksNum(H,T,Output,X,Y).

ksEng([],_,[],[],[[]]).                                /* 영어를 처리 */
ksEng(H,T,[Code|Output1],X,Y) :-
	move(H1,T1,T),
	ksEngSub(H1,T1,Output1,X,Y),
	name(Code,[H]).

ksEngSub([],_,[],[],[[]]).
ksEngSub(9,T,[],9,T).
ksEngSub(10,T,[],10,T).
ksEngSub(32,T,[],32,T).
ksEngSub(H,T,[],H,T) :-
	H < 65; (90 < H, H < 97); 122 < H. 
ksEngSub(H,T,Output,X,Y) :-  
	((64 < H, H < 91); (96 < H, H < 123)), 
	ksEng(H,T,Output,X,Y).

ksSym([],_,[],[],[[]]).                                /* symbol를 처리 */
ksSym(H,T,[Code|Output1],X,Y) :-
	move(H1,T1,T),
	ksSymSub(H1,T1,Output1,X,Y),
	name(Code,[H]).

ksSymSub([],_,[],[],[[]]).
ksSymSub(9,T,[],9,T).
ksSymSub(10,T,[],10,T).
ksSymSub(32,T,[],32,T).
ksSymSub(H,T,[],H,T) :-
	(H > 127; (47 < H,H < 58); 
	(64 < H, H < 91); (96 < H, H < 123)). 
ksSymSub(H,T,Output,X,Y) :-
	(H < 47; 58 < H, H < 65;                       /* Not Number */
	(90 < H, H < 97); (122 < H, H < 128)),         /* Not English neither Hangul */
        ksSym(H,T,Output,X,Y).

cat([],Y,Y) :- !.                                       /* [A],[B] --> [A,B] */     
cat([H|[]],Y,[H|Y]) :-  !.
cat([H|T],Y,[H|Output1]) :- 
	cat(T,Y,Output1).


move([],[[]|[]],[]).                                 /* 한 list에서 head,tail을 추출 */
move(H,T,[H|T]).

moveN(Z,T,T1,[_]) :- move(Z,T,T1).              /* move와 비슷하는 이것은 4번째 arg   */
moveN(Z,T,[_|T1],[_|T2]) :- moveN(Z,T,T1,T2).   /* 와 같은 앞부분을 없애후move를 수행 */

removeSpace([' '],[]).                             /* list의 끝에 있는 space를 없앰 */
removeSpace([H|[]],H).
removeSpace([H|T],[H|Output1]) :- 
	removeSpace(T,Output1). 

makeString([],'').                             /* list --> string */
makeString(Input,Output) :- 
	makeStringSub(Input,Output1), 
	name(Output,Output1).
makeStringSub([H|[]],Output) :- name(H,Output).
makeStringSub([H|T],Output) :- 
	name(H,Output1), makeStringSub(T,Output2), 
	cat(Output1,Output2,Output).

makeList(``,[]).                               /* kimmo string --> kimmo list */
makeList([Input],Output) :- 
	name(Input,Output1), 
	makeListSub(Output1,Output).

makeListSub([],[]).
makeListSub([H|[]],[C]) :- name(C,[H]).
makeListSub([H|T],[Output1|Output2]) :-
	makeListSubTest([H|T]),move(H1,T1,T),
	name(C1,[H]), name(C2,[H1]),
	makeString([C1,C2],Output1),
	makeListSub(T1,Output2).
makeListSub([H|T],[C|Output1]) :-
	makeListSub(T,Output1), name(C,[H]).

makeListSubTest([_|[]]) :- fail.
makeListSubTest([H|[H1|_]]) :-
	(H == 0'y; H == 0'w; (64 < H, H < 91 ,64 < H1, H1 < 91)).

countAtom([_|[]]).

not(X) :- (X, !, fail) ; true.

