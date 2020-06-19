zapalki(N,KWADRATY):-
    (KWADRATY = (duze(X),srednie(Y),male(Z)) ; (KWADRATY = (duze(X),srednie(Y)), Z is 0) ; (KWADRATY = (duze(X),male(Z)),Y is 0) ; (KWADRATY = (srednie(Y),male(Z)),X is 0) ;
    (KWADRATY = (duze(X)), Y is 0, Z is 0) ; (KWADRATY = (srednie(Y)),X is 0, Z is 0) ; (KWADRATY = (male(Z)),X is 0, Y is 0) ) ,!,
    daj_N_duzych(X,D),
    daj_N_srednich(Y,S),
    daj_N_malych(Z,M),
    union(D,S,R1),
    union(R1,M,R),
    sort(R,RES),
    length(RES,Zapa³ek),
    N is 24 - Zapa³ek,
    duzych_w_srodku(RES,X),
    srednich_w_srodku(RES,Y),
    malych_w_srodku(RES,Z),
    print_board(RES,N).


full_board(X):- numlist(1,24,X).
all_duze([[1,2,3,4,7,11,14,18,21,22,23,24]]).
duzy([1,2,3,4,7,11,14,18,21,22,23,24]).
all_srednie([[1,2,4,6,11,13,15,16],[2,3,5,7,12,14,16,17],[8,9,11,13,18,20,22,23],[9,10,12,14,19,21,23,24]]).
all_male([[1,4,5,8],[2,5,6,9],[3,6,7,10],[8,11,12,15],[9,12,13,16],[10,13,14,17],[15,18,19,22],[16,19,20,23],[17,20,21,24]]).


/* dzia³a jak subset builtin tylko ¿e generuje te¿ rozwiazania*/
is_subset_of([],[]).
is_subset_of([H1|T1],[H1|T2]):- is_subset_of(T1,T2).
is_subset_of(T1,[_|T2]):- is_subset_of(T1,T2).

/* pod Y zapisuje wszystkie n elementowe podzbiory X */
is_subset_of_N(X,Y,N):-
    is_subset_of(X,Y),
    length(X,N).


% ile ma³ych mozliwych w liscie jednowymiarowej[]
malych_w_srodku(X,N):-
    all_male(Z),
    findall(Y,(member(Y,Z),intersection(X,Y,Y)),RES),
    length(RES,N).

srednich_w_srodku(X,N):-
    all_srednie(Z),
    findall(Y,(member(Y,Z),intersection(X,Y,Y)),RES),
    length(RES,N).

duzych_w_srodku(X,N):-
    duzy(Z),
    is_subset_of(Z,X) -> N is 1 ; N is 0.




daj_N_duzych(0,[]).
daj_N_duzych(N,RES):-
    all_duze(LIST),
    is_subset_of(T,LIST),
    length(T,N),
    union_all(T,RES).

daj_N_srednich(0,[]).
daj_N_srednich(N,RES):-
    all_srednie(LIST),
    is_subset_of(T,LIST),
    length(T,N),
    union_all(T,RES).

daj_N_malych(0,[]).
daj_N_malych(N,RES):-
    all_male(LIST),
    is_subset_of(T,LIST),
    length(T,N),
    union_all(T,RES).



union_all([H],RES):-
    RES= H.
union_all([H1,H2|T],RES):-
    union(H1,H2,H3),
    union_all([H3|T],RES).



%   WYPISYWANIE PLANSZY

first_row([1,2,3]).
second_row([8,9,10]).
third_row([15,16,17]).
fourth_row([22,23,24]).
first_col([4,5,6,7]).
second_col([11,12,13,14]).
third_col([18,19,20,21]).

% print_row(Row,Board)
print_row([],_):- write('+'),nl.
print_row([H|T],Board):-
    (member(H,Board) -> write('+---') ; write('+   ')),
    print_row(T,Board).

% print_column(Column,Board)
print_column([],_):- nl.
print_column([H|T],Board):-
    (member(H,Board) -> write('|   ') ; write('    ')),
    print_column(T,Board).

print_board(Board,N):-
    write('Rozwiazanie:'),nl,
    write('N = '),write(N),nl,
    first_row(R1), second_row(R2), third_row(R3), fourth_row(R4),
    first_col(C1), second_col(C2), third_col(C3),
    print_row(R1,Board),
    print_column(C1,Board),
    print_row(R2,Board),
    print_column(C2,Board),
    print_row(R3,Board),
    print_column(C3,Board),
    print_row(R4,Board).

