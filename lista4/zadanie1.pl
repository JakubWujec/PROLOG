/* wyra¿enie(LISTA,WARTOŒÆ, WYRA¯ENIE) */


generuj_wszystkie_wyrazenia([X],X).
generuj_wszystkie_wyrazenia([H|T], WYRAZENIE):-
    generuj_wszystkie_wyrazenia(T,H,WYRAZENIE).

generuj_wszystkie_wyrazenia([X],TMPWYR,WYR):-
    sklej_wyrazenia(TMPWYR,X,WYR).
generuj_wszystkie_wyrazenia([H|T],TMPWYR,WYR):-
    sklej_wyrazenia(TMPWYR,H,WYR2),
    generuj_wszystkie_wyrazenia(T,WYR2,WYR).


% wyra¿enie(LISTA,WARTOŒÆ,WYRA¯ENIE), doklejam czynnik(X2) do wyra¿enia
% X1 z dzia³aniem ze zbioru [+,*,-,/]
sklej_wyrazenia(X1,X2,WYR):- WYR = X1 + X2.
sklej_wyrazenia(X1,X2,WYR):- WYR = X1 - X2.
sklej_wyrazenia(X1,X2,WYR):- WYR = X1 * X2.
sklej_wyrazenia(X1,X2,WYR):- \+ (0 is X2; 0.0 is X2), WYR = X1 / X2.


wyra¿enie([X],X,X).
wyra¿enie(LISTA,WARTOSC,WYRAZENIE):-
    append(L1,L2,LISTA),
    \+(length(L1,0) ; length(L2,0)),
    generuj_wszystkie_wyrazenia(L1,WYR1),
    generuj_wszystkie_wyrazenia(L2,WYR2),
    sklej_wyrazenia(WYR1,WYR2,WYRS),
    WARTOSC is WYRS,
    WYRAZENIE = WYRS.


/*
generuj¹c od lewej do prawej nie ma rozwi¹zania dla ostatniego
przyk³adu.

wyra¿enie(LISTA,WARTOŒÆ,WYRA¯ENIE):-
    generuj_wszystkie_wyra¿enia(LISTA,WYRS),
    WARTOŒÆ is WYRS,
    WYRA¯ENIE = WYRS.
*/









