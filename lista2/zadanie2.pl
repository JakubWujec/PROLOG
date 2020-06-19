/*
1. Napisz predykat jednokrotnie(X, L), który jest spe³niony, jeœli X wystêpuje dok³adnie jeden raz na liœcie L.
2. Napisz predykat dwukrotnie(X, L), który jest spe³niony, jeœli X wystêpuje
dok³adnie dwa razy na liœcie L.
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
