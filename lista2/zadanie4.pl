/* Zaproponuj regu�y upraszczaj�ce wyra�enie. Na przyk�ad regu�a 0 + X � X
pozwala usun�� lewy sk�adnik sumy r�wny zeru.
Regu�y zapisz w postaci czteroargumentowego predykatu:
regu�a(LewyArgument, Operator, PrawyArgument, Wynik).
Dla przyk�adu, regu�� 0 + X � X mo�na zapisa� w postaci klauzuli:
regu�a(X, +, Y, Y) :-
number(X),
X =:= 0, !.
Napisz predykat upro��(Wyra�enie, Wynik), kt�ry korzystaj�c z predykatu regu�a/4 upraszcza zadane wyra�enie.
Przyk�ad uruchomienia:
?- upro��(a*(b*c/c-b), X).
X = 0. */


/* 0+X lub X+0 */
regu�a(X, +, Y, Y) :-
    singleton(Y),
    number(X),
    X =:= 0, !.

regu�a(Y, +, X, Y) :-
    singleton(Y),
    number(X),
    X =:= 0, !.

/* X-X=0 */
regu�a(X, -, X, 0).

/* X-0 */
regu�a(X,-,0,X).

/* 0-X */
regu�a(0,-,X,Y):- Y is (-1)* X.

/* 0*X lub X* 0 */
regu�a(X, *, _, 0):-
    number(X),
    X =:= 0, !.
regu�a(_, *, X, 0):-
    number(X),
    X =:= 0, !.

/* X*1 lub 1*X */
regu�a(X, *, 1, X).
regu�a(1, *, X, X).

/* X/X */
regu�a(X, /, X, 1):-
    X \= 0, !.

/* x*c/c=x */
regu�a(X*C,/,C,X):-
    X \= 0, !.

/* dodawanie liczb */
regu�a(X,+,Y,Z):-
    number(X),number(Y),
    Z is X+Y.

/* default */
regu�a(X,OP,Y,RES):-
    singleton(X),singleton(OP),singleton(Y),
    RES =.. [OP,X,Y].


singleton(EXP):- number(EXP); atom(EXP); var(EXP).

upro��(X,X) :- singleton(X).

/* rozbij expresion na lewy skladnik, operator, prawy skladnik
 * upraszczaj skladniki
 * zastosuj regu�y
*/
upro��(EXP,RES) :-
    EXP =..[OP,L,R],
    upro��(L,L1),
    upro��(R,R1),
    regu�a(L1,OP,R1,RES),!.

upro��(X+Y,RES) :- (upro��(X1+Y1,RES),upro��(X,X1), upro��(Y,Y1)).
upro��(X-Y,RES) :- (upro��(X1-Y1,RES),upro��(X,X1), upro��(Y,Y1)).
upro��(X*Y,RES) :- (upro��(X1*Y1,RES),upro��(X,X1), upro��(Y,Y1)).
upro��(X/Y,RES) :- (upro��(X1/Y1,RES),upro��(X,X1), upro��(Y,Y1)).


/* Przyk�ady kt�re elegancko dzia�aj�
   a*(b*c/c-b) = 0
   a/a+b/b = 2
   0 - 2 = -2
*/














