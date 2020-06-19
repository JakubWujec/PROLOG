/*
Dany jest graf skierowany w postaci faktów arc(X, Y), wyra¿aj¹cych, ¿e jest
³uk od wêz³a X do wêz³a Y.
Napisz predykat osi¹galny(X, Y), który jest spe³niony gdy wêze³ Y jest
osi¹galny z wêz³a X (tzn. jest œcie¿ka od X do Y). */


arc(a, b).
arc(b, a).
arc(b, c).
arc(c, d).

/*  path3(FROM,TO,USED)
 *  FROM - wierzcholek z ktorego wychodzimy
 *  TO - wierzcholek do ktorego wchodzimy
 *  USED - odwiedzone wierzcholki
 */
path3(X,X,[]).
path3(X,Z,USED):-
    arc(X, Y), \+ member(Y,USED), (Y = Z ; path3(Y,Z,[X|USED])).


/* jest osiagalny jesli istnieje sciezka z X do Y */
osi¹galny(X,Y):- path3(X,Y,[]).
