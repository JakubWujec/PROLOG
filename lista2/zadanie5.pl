/*
    lista(N,X) spełnia wszystkie założenia predykatu:
    • ma długość 2*N,
    • każda liczba od 1 do N występuję na niej dokładnie dwa razy,
    • między dwoma kolejnymi wystąpieniami tej samej liczby jest parzysta liczba innych liczb.

    Rozwiązań spełniających tylko te założenia (nie biorąc pod uwagę
    uwagi 0) jest n! * n!
 */

/* permutacja listy */
perm([],[]).
perm(L1, [X | L3]) :-
    select(X, L1, L2),
    perm(L2,L3).

/* składanie dwóch list w jedną, elementy układane na przemian */
zip([],[],[]).
zip([L1|L1s], [L2|L2s], [L1,L2|L3s]) :- zip(L1s,L2s,L3s).

/* stworz spermutowana liste dlugosci N */
do_perm_list(N, L):-
    numlist(1,N,NUMS),
    perm(NUMS,L).

lista(N,X):-
    Y is 2*N, length(X,Y),
    do_perm_list(N,L1),
    do_perm_list(N,L2),
    zip(L1,L2,X).


/* wersja z uwaga0 jeśli na liście X pojawia się po
raz pierwszy liczba k  {1, 2, . . . , n}, to na wcześniejszych pozycjach listy X
pojawiły się już wszystkie liczby 1, 2, . . . , k − 1 (jeden lub dwa razy).*/
lista2(N,X) :-
    Y is 2*N,length(X,Y),
    numlist(1,N,Ns),
    pairs(Ns,X).

/* */
pairs([N|Ns],L) :- first(N,L,R),even_offset(N,R),pairs(Ns,L).
pairs([],_).

/* R = elementy po pierwszym wystapieniu N na liscie */
first(N,[N|R],R) :- !.
first(N,[_|R],S) :- first(N,R,S).

/* jest w headzie, albo na jakiejs nieparzystej pozycji listy R
to zapewnie parzysta liczbe elementow pomiedzy*/
even_offset(N,[N|_]).
even_offset(N,[_,_|R]) :- even_offset(N,R).
















