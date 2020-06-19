/* L3Z3 */
/*
Napisz program dla even_permutation(Xs, Ys) i odd_permutation(Xs, Ys), cwiczenie
ktory znajduje liste Ys bedaca, odpowiednio, parzysta i nieparzysta
permutacja listy Xs.
*/

perm([], []).
perm(L1, [X | L3]):-
    select(X, L1, L2),
    perm(L2, L3).

/* L-permutacja R-liczba transpozycji*/
trans(L,R):-
    trans(L,0,R).

trans([],X,X).
trans([X|Xs],ActualRes,Res):-
    less_on_right(X,Xs,R1),
    R2 is ActualRes+R1,
    trans(Xs,R2,Res).

/* ile jest elementow mniejszych od Elem w List */
less_on_right(Elem,List,RES):-
    less_on_right(Elem,List,0,RES).

less_on_right(_,[],X,X).
less_on_right(Elem,[X|Xs],ActualScore,Score):-
    Elem > X ->
        NewActualScore is ActualScore + 1, less_on_right(Elem,Xs,NewActualScore,Score)
        ;
        less_on_right(Elem,Xs,ActualScore,Score).

even_permutation(Xs,Ys):-
    perm(Xs,Ys),
    trans(Ys,R),
    R mod 2 =:= 0.

odd_permutation(Xs,Ys):-
    perm(Xs,Ys),
    trans(Ys,R),
    R mod 2 =:= 1.



