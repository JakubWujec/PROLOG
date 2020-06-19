/* Napisz predykat �rodkowy(L, X), kt�ry jest prawdziwy je�li X jest �rodkowym elementem listy L. Je�li lista L ma parzyst� liczb� element�w, to warunek
�rodkowy(L, X) powinien zawie�� */

/* zwraca ogon listy */
tail([_|T],T).

/* zwraca liste bez krancowych elementow */
inner_list(L1,L2) :-
    tail(L1,X1), reverse(X1,X2), tail(X2,X3), reverse(X3,L2).

/* singleton jest elementem srodkowym */
�rodkowy([X|[]],X).
�rodkowy(L,X):-
    length(L,LEN),((LEN mod 2) =:= 1),
    inner_list(L,L2), �rodkowy(L2,X).

/* dzia�a te� bez sprawdzania dlugo�ci,
    jednak dla list parzystych dlugosci potrzebuje wiekszej liczby wnioskowan*/
�rodkowy2([X|[]],X).
�rodkowy2(L,X):-
    inner_list(L,L2), �rodkowy2(L2,X).






