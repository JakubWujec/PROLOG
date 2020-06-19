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




