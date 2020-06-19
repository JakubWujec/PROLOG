program([]) --> [].
program([Instrukcja | Program]) -->
    instrukcja(Instrukcja),
    [sep(';')],
    program(Program).

instrukcja(read(ID)) -->
	[key(read)],
	[id(ID)].
instrukcja(write(WYRAŻENIE)) -->
	[key(write)],
	wyrażenie(WYRAŻENIE).
instrukcja(assign(ID,WYRAŻENIE)) -->
	[id(ID)],
	[sep(':=')],
	wyrażenie(WYRAŻENIE).
instrukcja(if(WARUNEK,PROGRAM)) -->
	[key(if)],
	warunek(WARUNEK),
	[key(then)],
	program(PROGRAM),
	[key(fi)].
instrukcja(if(WARUNEK,PROGRAM1,PROGRAM2)) -->
	[key(if)],
	warunek(WARUNEK),
	[key(then)],
	program(PROGRAM1),
	[key(else)],
	program(PROGRAM2),
	[key(fi)].
instrukcja(while(WARUNEK, PROGRAM)) -->
	[key(while)],
	warunek(WARUNEK),
	[key(do)],
	program(PROGRAM),
	[key(od)].


wyrażenie(SKŁADNIK) --> składnik(SKŁADNIK).
wyrażenie(SKŁADNIK + WYRAŻENIE) -->
	składnik(SKŁADNIK),
	[sep('+')],
	wyrażenie(WYRAŻENIE).
wyrażenie(SKŁADNIK - WYRAŻENIE) -->
	składnik(SKŁADNIK),
	[sep('-')],
	wyrażenie(WYRAŻENIE).


warunek(KONIUNKCJA) -->
	koniunkcja(KONIUNKCJA).
warunek(KONIUNKCJA ; WARUNEK) -->
	koniunkcja(KONIUNKCJA),
	[key(or)],
	warunek(WARUNEK).


% dopiero jak umieściłem przecinek w cudzysłowie,
% zaczęło działać, nie wiem dlaczego :/
koniunkcja(PROSTY ',' KONIUNKCJA) -->
	prosty(PROSTY),
	[key(and)],
	koniunkcja(KONIUNKCJA).

koniunkcja(PROSTY) -->
	prosty(PROSTY).



prosty(WYRAŻENIE1 > WYRAŻENIE2) -->
	wyrażenie(WYRAŻENIE1),
	[sep('>')],
	wyrażenie(WYRAŻENIE2).
prosty(WYRAŻENIE1 =:= WYRAŻENIE2) -->
	wyrażenie(WYRAŻENIE1),
	[sep('=')],
	wyrażenie(WYRAŻENIE2).
prosty(WYRAŻENIE1 < WYRAŻENIE2) -->
	wyrażenie(WYRAŻENIE1),
	[sep('<')],
	wyrażenie(WYRAŻENIE2).
prosty(WYRAŻENIE1 >= WYRAŻENIE2) -->
	wyrażenie(WYRAŻENIE1),
	[sep('>=')],
	wyrażenie(WYRAŻENIE2).
prosty(WYRAŻENIE1 =< WYRAŻENIE2) -->
	wyrażenie(WYRAŻENIE1),
	[sep('=<')],
	wyrażenie(WYRAŻENIE2).
prosty(WYRAŻENIE1 =\= WYRAŻENIE2) -->
	wyrażenie(WYRAŻENIE1),
	[sep('/=')],
	wyrażenie(WYRAŻENIE2).
prosty((WARUNEK)) -->
	[sep('(')],
        warunek(WARUNEK),
	[sep(')')].


składnik(CZYNNIK) --> czynnik(CZYNNIK).
składnik(CZYNNIK * SKŁADNIK) -->
	czynnik(CZYNNIK),
	[sep('*')],
	składnik(SKŁADNIK).
składnik(CZYNNIK mod SKŁADNIK) -->
	czynnik(CZYNNIK),
	[key(mod)],
	składnik(SKŁADNIK).
składnik(CZYNNIK / SKŁADNIK) -->
	czynnik(CZYNNIK),
	[sep('/')],
	składnik(SKŁADNIK).


czynnik(id(ID)) --> [id(ID)].
czynnik(int(LICZBA_NATURALNA)) --> [int(LICZBA_NATURALNA)].
czynnik(WYRAŻENIE) -->
	[sep('(')],
	wyrażenie(WYRAŻENIE),
	[sep(')')].


% PROGRAM działa dopóki są przerwy takie jak w przykładzie,
% tzn zamiast 2+5, jest 2 + 5 (tak jest też opisane w gramatyce)
%
%  open('ex1.prog', read, X), scanner(X, Y), close(X), write(Y).
%
%  open('ex1.prog', read, X), scanner(X, Y), close(X),open('res.txt',write,WStream), write(WStream,Y), close(WStream)
%scanner(STRUMIEŃ,OUT)
key(read).
key(write).
key(if).
key(then).
key(else).
key(fi).
key(while).
key(do).
key(od).
key(and).
key(or).
key(mod).

% nie są prefixem innego separatora
sep(';').
sep('+').
sep('-').
sep('*').
sep('(').
sep(')').
sep('<').

% moga być prefixem innego separatora
sep('/').
sep('/=').
sep('>').
sep('>=').
sep('=').
sep('=<').
sep(':=').



biały(' ').
biały('\t').
biały('\n').




scanner(Strumień,Tokeny):-
	scanner2(Strumień,Tokeny,[]).

scanner2(Strumień,Tokeny,TmpTokeny):-
	get_char(Strumień,Char),
	scanner3(Strumień,Tokeny,TmpTokeny,Char).


scanner3(Strumień,Tokeny,TmpTokeny,Char):-
 (
    (char_type(Char,space) -> scanner2(Strumień,Tokeny,TmpTokeny))
    ;
    (char_type(Char,lower) -> scanner_key(Strumień,Tokeny,TmpTokeny,Char))
    ;
    (char_type(Char,upper) -> scanner_id(Strumień,Tokeny,TmpTokeny,Char))
    ;
    (char_type(Char,digit) -> scanner_int(Strumień,Tokeny,TmpTokeny,Char))
    ;
    (member(Char,[';','+','-','*',')','(','<']) ->
	    append(TmpTokeny,[sep(Char)],TmpTokeny2),
	    scanner2(Strumień,Tokeny,TmpTokeny2))
    ;
    (member(Char,['/','>','=',':']) -> scanner_sep(Strumień,Tokeny,TmpTokeny,Char))
    ;

    (char_type(Char, end_of_file) -> Tokeny = TmpTokeny)
 ).


%sep

scanner_sep(Strumień,Tokeny,TmpTokeny,SepPrefix):-
	get_char(Strumień, CharNext),
	scanner_sep(Strumień,Tokeny,TmpTokeny,SepPrefix,CharNext).

% nastepny space to dodaj od razu
scanner_sep(Strumień,Tokeny,TmpTokeny,SepPrefix,CharNext):-
	char_type(CharNext,space),
	!,
	append(TmpTokeny,[sep(SepPrefix)],TmpTokeny2),
	scanner2(Strumień,Tokeny,TmpTokeny2).

% ew może być '=' or '<'
scanner_sep(Strumień,Tokeny,TmpTokeny,SepPrefix,CharNext):-
	member(CharNext,['=','<']),
	!,
	atom_concat(SepPrefix,CharNext,NewSepPrefix),
	append(TmpTokeny,[sep(NewSepPrefix)],TmpTokeny2),
	scanner2(Strumień,Tokeny,TmpTokeny2).


% ID
scanner_id(Strumień,Tokeny,TmpTokeny,IdPrefix):-
	get_char(Strumień,CharNext),
	scanner_id(Strumień,Tokeny,TmpTokeny,IdPrefix,CharNext).


scanner_id(Strumień,Tokeny,TmpTokeny,IdPrefix,CharNext):-
	char_type(CharNext,space),
	!,
	append(TmpTokeny,[id(IdPrefix)],TmpTokeny2),
        scanner2(Strumień,Tokeny,TmpTokeny2).

% nastepny char jest tez upper
scanner_id(Strumień,Tokeny,TmpTokeny,IdPrefix,CharNext):-
	char_type(CharNext, upper),
	!,
	atom_concat(IdPrefix,CharNext,NewIdPrefix),
	scanner_id(Strumień,Tokeny,TmpTokeny,NewIdPrefix).

%nastepny char jest ;
scanner_id(Strumień,Tokeny,TmpTokeny,IdPrefix,CharNext):-
	member(CharNext,[';']),
	!,
	append(TmpTokeny,[id(IdPrefix),sep(';')],TmpTokeny2),
        scanner2(Strumień,Tokeny,TmpTokeny2).





%  INTY
% czytanie intow trwa az do spacji albo średnika
scanner_int(Strumień,Tokeny,TmpTokeny,IntPrefix):-
	get_char(Strumień,CharNext),
	scanner_int(Strumień,Tokeny,TmpTokeny,IntPrefix,CharNext).


% nastepny char jest tez cyfra
scanner_int(Strumień,Tokeny,TmpTokeny,IntPrefix,CharNext):-
	char_type(CharNext,digit),
	!,
	atom_concat(IntPrefix,CharNext,NewIntPrefix),
	scanner_int(Strumień,Tokeny,TmpTokeny,NewIntPrefix).


% nastepny char jest spacja
scanner_int(Strumień,Tokeny,TmpTokeny,IntPrefix,CharNext):-
	char_type(CharNext,space),
	!,
	atom_number(IntPrefix,Number),
	append(TmpTokeny,[int(Number)],TmpTokeny2),
        scanner2(Strumień,Tokeny,TmpTokeny2).

%nastepny char jest ;
scanner_int(Strumień,Tokeny,TmpTokeny,IntPrefix,CharNext):-
	member(CharNext,[';']),
	!,
	atom_number(IntPrefix,Number),
	append(TmpTokeny,[int(Number),sep(';')],TmpTokeny2),
        scanner2(Strumień,Tokeny,TmpTokeny2).




% KEY %

scanner_key(Strumień, Tokeny, TmpTokeny, KeyPrefix):-
	get_char(Strumień,CharNext),
	scanner_key(Strumień,Tokeny,TmpTokeny,KeyPrefix,CharNext),
	!.


% następny char konczy key
scanner_key(Strumień, Tokeny, TmpTokeny, KeyPrefix, CharNext):-
	atom_concat(KeyPrefix,CharNext,NewKeyPrefix),
	key(NewKeyPrefix),
	append(TmpTokeny,[key(NewKeyPrefix)],TmpTokeny2),
        scanner2(Strumień,Tokeny,TmpTokeny2).



% nastepny char jest czescia keya
scanner_key(Strumień,Tokeny,TmpTokeny,KeyPrefix,CharNext):-
	atom_concat(KeyPrefix,CharNext,NewKeyPrefix),
        scanner_key(Strumień,Tokeny,TmpTokeny,NewKeyPrefix).

% nie trzeba sprawdzać ';' bo key jest z góry ustalony




