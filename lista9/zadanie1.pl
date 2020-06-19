:- use_module(library(clpfd)).
tasks([
    %Duration R1 R2
    [2, 1, 3],
    [3, 2, 1],
    [4, 2, 2],
    [3, 3, 2],
    [3, 1, 1],
    [3, 4, 2],
    [5, 2, 1]]).

% R1,R2
resources(5,5).

schedule(Horizon,Starts,MakeSpan):-
    tasks(L),
    tasks_divisor(L,L1,L2),
    resources(R1,R2),
    MakeSpan in 0..Horizon,
    mt(L1,Horizon,T1,Starts,MakeSpan),
    mt(L2,Horizon,T2,Starts,MakeSpan),
    cumulative(T1, [limit(R1)]),
    cumulative(T2, [limit(R2)]),
    once(labeling([min(MakeSpan), ff], [MakeSpan | Starts])).

tasks_divisor([],[],[]).
tasks_divisor([[D,R1,R2]|T],[[D,R1]|T1],[[D,R2]|T2]):-
    tasks_divisor(T,T1,T2).

% mt(TASKS_IN,HORIZON_IN,TASKS_OUT,STARTS_IN,MS_IN)
mt([], _, [], [], _).
mt([[D, R] | L1], H, [task(S, D, E, R, _) | L2],
   [S | L3], MS) :-
    S in 0..H,
    E #= S + D, MS #>= E,
    mt(L1, H, L2, L3, MS).





