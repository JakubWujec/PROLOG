/* L3Z2 */
/*Dana jest lista liczb całkowitych L = [a0, . . . , an−1]. Przez sekcję a[i : j], gdzie 0 ≤ i ≤ j < n, rozumiemy fragment listy złożony z elementów ai, ai+1, . . . , aj .
Suma sekcji a[i : j] jest równa Pjk=i ak. Przyjmij, że sumą pustej
sekcji jest wartość 0. Napisz predykat max_sum(L, S), który dla danej
listy L znajduje najwieksza wartosc S sposrod wszystkich sum po
wszystkich mozliwych sekcjach.

*/

max_sum(L,S):-
    max_sum(L,0,0,S).

/* max_sum(list, tmp_max, tmp_value, result) */
max_sum([X|Xs],TMP_MAX,TMP,RES):-
    NEWTMP is TMP+X,
    NEWTMP > 0 ->
        (NEWTMP > TMP_MAX ->
            max_sum(Xs,NEWTMP,NEWTMP,RES)
            ;
            max_sum(Xs,TMP_MAX,NEWTMP,RES))
        ;
        max_sum(Xs,TMP_MAX,0,RES).
max_sum([],A,_,A).



