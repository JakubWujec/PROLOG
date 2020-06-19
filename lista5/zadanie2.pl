% 1=black 0=white
% hetmany(12, X), board(X).

board(L):-
    length(L,N),
    reverse(L,L1),
    print_rows(N,L1).

print_rows(N,L):-
    print_rows(N,N,L).

print_rows(0,N,_):- print_floor(N),!.
print_rows(ROWNUM,N,L):-
    print_floor(N),
    print_row(ROWNUM,N,L),
    ROWNUM2 is ROWNUM-1,
    print_rows(ROWNUM2,N,L).


print_row(RowNum,N,L):-
    indexOf(L,RowNum,QPOS),!,
    (is_even(RowNum) -> (print_white_row(N,N,QPOS),print_white_row(N,N,QPOS))
    ;
    (   print_black_row(N,N,QPOS), print_black_row(N,N,QPOS))).


% naprzemienne rysowanie białego i czarnego pola
print_black_row(_,0,_):- write('|'),nl,!.
print_black_row(N,TMP_COLNUM,QPOS):-
    print_black(QPOS,TMP_COLNUM),
    TMP2 is TMP_COLNUM - 1,
    print_white_row(N,TMP2,QPOS).

print_white_row(_,0,_):- write('|'),nl,!.
print_white_row(N,TMP_COLNUM,QPOS):-
    print_white(QPOS,TMP_COLNUM),
    TMP2 is TMP_COLNUM - 1,
    print_black_row(N,TMP2,QPOS).

print_floor(0):- print('+'),nl.
print_floor(N):-
    write('+-----'),
    N1 is N-1,
    print_floor(N1),!.

% QPOS-pozycja hetmana, ColNum - aktualnie rysowana kolumna
print_black(QPOS,ColNum):-(QPOS =:= ColNum -> print_black_w_queen ; print_black_empty).
print_white(QPOS,ColNum):-(QPOS =:= ColNum -> print_white_w_queen ; print_white_empty).
print_black_empty:- write('|:::::').
print_white_empty:- write('|     ').
print_black_w_queen:- write('|:###:').
print_white_w_queen:- write('| ### ').


% pozycja elementu na liście
indexOf([H|_],H,1).
indexOf([_|T],Elem,Index):-
    indexOf(T,Elem,Index1),
    !,
    Index is Index1+1.

is_even(N):-
    0 is N mod 2.



% HETMANY Z WYKŁADU %
hetmany(N, P) :-
	numlist(1, N, L),
	perm(L, P),
	dobra(P).

perm([], []).
perm(L1, [X | L3]) :-
	select(X, L1, L2),
	perm(L2, L3).

dobra(X) :-
	\+ zła(X).

zła(X) :-
	append(_, [Wi | L1], X),
	append(L2, [Wj | _], L1),
	length(L2, K),
	abs(Wi - Wj) =:= K + 1.





