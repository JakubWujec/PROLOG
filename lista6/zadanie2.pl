:- consult(zadanie1).
wykonaj(NazwaPliku):-
	open(NazwaPliku,read,X),
	scanner(X,Y),
	close(X),
	phrase(program(PROGRAM),Y),
	interpreter(PROGRAM).

% kod z wykładu
%interpreter(+Program, +Asocjacje)
interpreter([],_).
interpreter([read(ID)|PGM],AS):- !,
	read(N),
	integer(N),
	podstaw(AS,ID,N,AS1),
	interpreter(PGM,AS1).
interpreter([read(ID) | PGM], ASSOC) :- !,
	read(N),
	integer(N),
	podstaw(ASSOC, ID, N, ASSOC1),
	interpreter(PGM, ASSOC1).
interpreter([write(W) | PGM], ASSOC) :- !,
	wartość(W, ASSOC, WART),
	write(WART), nl,
	interpreter(PGM, ASSOC).
interpreter([assign(ID, W) | PGM], ASSOC) :- !,
	wartość(W, ASSOC, WAR),
	podstaw(ASSOC, ID, WAR, ASSOC1),
	interpreter(PGM, ASSOC1).
interpreter([if(C, P) | PGM], ASSOC) :- !,
	interpreter([if(C, P, []) | PGM], ASSOC).
interpreter([if(C, P1, P2) | PGM], ASSOC) :- !,
	( prawda(C, ASSOC)
	-> append(P1, PGM, DALEJ)
	; append(P2, PGM, DALEJ)),
	interpreter(DALEJ, ASSOC).
interpreter([while(C, P) | PGM], ASSOC) :- !,
	append(P, [while(C, P)], DALEJ),
	interpreter([if(C, DALEJ) | PGM], ASSOC).
% interpreter(+Program)
interpreter(PROGRAM) :-
	interpreter(PROGRAM, []).

% podstaw(+Stare, +ID, +Wartosc, -Nowe)
podstaw([], ID, N, [ID = N]).
podstaw([ID=_ | AS], ID, N, [ID=N | AS]) :- !.
podstaw([ID1=W1 | AS1], ID, N, [ID1=W1 | AS2]) :-
podstaw(AS1, ID, N, AS2).

% pobierz(+Asocjacje, +ID, -wartość)
pobierz([ID=N | _], ID, N) :- !.
pobierz([_ | AS], ID, N) :-
pobierz(AS, ID, N).

% wartosc(+Wyraoenie, +Asocjacje, -WartoúE)
wartość(int(N), _, N).
wartość(id(ID), AS, N) :-
	pobierz(AS, ID, N).
wartość(W1 + W2, AS, N) :-
	wartość(W1, AS, N1), wartość(W2, AS, N2),
	N is N1 + N2.
wartość(W1 - W2, AS, N) :-
	wartość(W1, AS, N1), wartość(W2, AS, N2),
	N is N1 - N2.
wartość(W1 * W2, AS, N) :-
	wartość(W1, AS, N1), wartość(W2, AS, N2),
	N is N1 * N2.
wartość(W1 / W2, AS, N) :-
	wartość(W1, AS, N1), wartość(W2, AS, N2),
	N2 =\= 0, N is N1 div N2.
wartość(W1 mod W2, AS, N) :-
	wartość(W1, AS, N1), wartość(W2, AS, N2),
	N2 =\= 0,
	N is N1 mod N2.

% prawda(+Warunek, +Asocjacje)
prawda(W1 =:= W2, AS) :-
	wartość(W1, AS, N1), wartość(W2, AS, N2),
	N1 =:= N2.
prawda(W1 =\= W2, AS) :-
	wartość(W1, AS, N1), wartość(W2, AS, N2),
	N1 =\= N2.
prawda(W1 < W2, AS) :-
	wartość(W1, AS, N1), wartość(W2, AS, N2),
	N1 < N2.
prawda(W1 > W2, AS) :-
	wartość(W1, AS, N1), wartość(W2, AS, N2),
	N1 > N2.
prawda(W1 >= W2, AS) :-
	wartość(W1, AS, N1), wartość(W2, AS, N2),
	N1 >= N2.
prawda(W1 =< W2, AS) :-
	wartość(W1, AS, N1), wartość(W2, AS, N2),
	N1 =< N2.
prawda((W1, W2), AS) :-
	prawda(W1, AS),
	prawda(W2, AS).
prawda((W1; W2), AS) :-
	( prawda(W1, AS),
	  !
	; prawda(W2, AS)).

