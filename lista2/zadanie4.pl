/* Zaproponuj regu³y upraszczaj¹ce wyra¿enie. Na przyk³ad regu³a 0 + X › X
pozwala usun¹æ lewy sk³adnik sumy równy zeru.
Regu³y zapisz w postaci czteroargumentowego predykatu:
regu³a(LewyArgument, Operator, PrawyArgument, Wynik).
Dla przyk³adu, regu³ê 0 + X › X mo¿na zapisaæ w postaci klauzuli:
regu³a(X, +, Y, Y) :-
number(X),
X =:= 0, !.
Napisz predykat uproœæ(Wyra¿enie, Wynik), który korzystaj¹c z predykatu regu³a/4 upraszcza zadane wyra¿enie.
Przyk³ad uruchomienia:
?- uproœæ(a*(b*c/c-b), X).
X = 0. */


/* 0+X lub X+0 */
regu³a(X, +, Y, Y) :-
    singleton(Y),
    number(X),
    X =:= 0, !.

regu³a(Y, +, X, Y) :-
    singleton(Y),
    number(X),
    X =:= 0, !.

/* X-X=0 */
regu³a(X, -, X, 0).

/* X-0 */
regu³a(X,-,0,X).

/* 0-X */
regu³a(0,-,X,Y):- Y is (-1)* X.

/* 0*X lub X* 0 */
regu³a(X, *, _, 0):-
    number(X),
    X =:= 0, !.
regu³a(_, *, X, 0):-
    number(X),
    X =:= 0, !.

/* X*1 lub 1*X */
regu³a(X, *, 1, X).
regu³a(1, *, X, X).

/* X/X */
regu³a(X, /, X, 1):-
    X \= 0, !.

/* x*c/c=x */
regu³a(X*C,/,C,X):-
    X \= 0, !.

/* dodawanie liczb */
regu³a(X,+,Y,Z):-
    number(X),number(Y),
    Z is X+Y.

/* default */
regu³a(X,OP,Y,RES):-
    singleton(X),singleton(OP),singleton(Y),
    RES =.. [OP,X,Y].


singleton(EXP):- number(EXP); atom(EXP); var(EXP).

uproœæ(X,X) :- singleton(X).

/* rozbij expresion na lewy skladnik, operator, prawy skladnik
 * upraszczaj skladniki
 * zastosuj regu³y
*/
uproœæ(EXP,RES) :-
    EXP =..[OP,L,R],
    uproœæ(L,L1),
    uproœæ(R,R1),
    regu³a(L1,OP,R1,RES),!.

uproœæ(X+Y,RES) :- (uproœæ(X1+Y1,RES),uproœæ(X,X1), uproœæ(Y,Y1)).
uproœæ(X-Y,RES) :- (uproœæ(X1-Y1,RES),uproœæ(X,X1), uproœæ(Y,Y1)).
uproœæ(X*Y,RES) :- (uproœæ(X1*Y1,RES),uproœæ(X,X1), uproœæ(Y,Y1)).
uproœæ(X/Y,RES) :- (uproœæ(X1/Y1,RES),uproœæ(X,X1), uproœæ(Y,Y1)).


/* Przyk³ady które elegancko dzia³aj¹
   a*(b*c/c-b) = 0
   a/a+b/b = 2
   0 - 2 = -2
*/














