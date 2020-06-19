/* Napisz predykat œrodkowy(L, X), który jest prawdziwy jeœli X jest œrodkowym elementem listy L. Jeœli lista L ma parzyst¹ liczbê elementów, to warunek
œrodkowy(L, X) powinien zawieœæ */

/* zwraca ogon listy */
tail([_|T],T).

/* zwraca liste bez krancowych elementow */
inner_list(L1,L2) :-
    tail(L1,X1), reverse(X1,X2), tail(X2,X3), reverse(X3,L2).

/* singleton jest elementem srodkowym */
œrodkowy([X|[]],X).
œrodkowy(L,X):-
    length(L,LEN),((LEN mod 2) =:= 1),
    inner_list(L,L2), œrodkowy(L2,X).

/* dzia³a te¿ bez sprawdzania dlugoœci,
    jednak dla list parzystych dlugosci potrzebuje wiekszej liczby wnioskowan*/
œrodkowy2([X|[]],X).
œrodkowy2(L,X):-
    inner_list(L,L2), œrodkowy2(L2,X).






