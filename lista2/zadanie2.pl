/*
1. Napisz predykat jednokrotnie(X, L), kt�ry jest spe�niony, je�li X wyst�puje dok�adnie jeden raz na li�cie L.
2. Napisz predykat dwukrotnie(X, L), kt�ry jest spe�niony, je�li X wyst�puje
dok�adnie dwa razy na li�cie L.
*/

/* select zwraca false jak nie ma tego elementu ktory chcemy usunac */

jednokrotnie(X,L):-
    select(X,L,NEW), \+ (member(X,NEW)).


/* obie wersje dzialaja */
dwukrotnie(X,L):-
    select(X,L,NEW), jednokrotnie(X,NEW).

/* dwukrotnie2 wykonuje jednak mniej wnioskowan */
dwukrotnie2(X,L):-
    select(X,L,NEW1),
    select(X,NEW1,NEW2),
    \+ (member(X,NEW2)).
