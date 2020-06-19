/*
Dany jest graf skierowany w postaci fakt�w arc(X, Y), wyra�aj�cych, �e jest
�uk od w�z�a X do w�z�a Y.
Napisz predykat osi�galny(X, Y), kt�ry jest spe�niony gdy w�ze� Y jest
osi�galny z w�z�a X (tzn. jest �cie�ka od X do Y). */


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
osi�galny(X,Y):- path3(X,Y,[]).
