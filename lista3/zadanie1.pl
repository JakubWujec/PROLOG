/* L3Z1
Napisz predykat wariancja(L, D),
    ktory dla danej listy liczb L wylicza wartosc wariancji D.

wariancja(x1,x2,x3,..,xn) = ( (x1-X)^2 + (x2-X)^2 + ... + (xn-X)^2 ) / n
gdzie X to srednia arytmetyczna */

wariancja(L,D):-
    length(L,LEN),
    sum_list(L,SUM),
    AVG is SUM/LEN,
    sub_X_from_all_and_square(AVG,L,L2),
    sum_list(L2,SUM2),
    D is SUM2/LEN.


/* map(lambda x: (x-X)^2,Y) */
sub_X_from_all_and_square(_,[],[]).
sub_X_from_all_and_square(X,[Y|Ys],[Z|Zs]):-
    Z is (Y-X)^2,
    sub_X_from_all_and_square(X,Ys,Zs).




