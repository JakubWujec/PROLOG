% odcinek(Lista).
% Lista =:= 16 elementów ins 0..1
% w zawiera 'odcinek' składajacy sie z 8 sasiednich jedynek
%  odcinek(X), label(X), writeln(X), fail.

% można zastąpić sum(Vars,#=,N).
%sumlist([],0).
%sumlist([H|T],Sum):- sumlist(T,Sum2), Sum #= Sum2 + H.

% #\/ OR
% #\ exclusive OR
% P #==> Q  P implies Q

:- use_module(library(clpfd)).

odcinek([X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16]):-
	Vars = [X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16],
	Vars ins 0..1,
	sum(Vars,#=,8),
        X8+X9 #>=1,
        X7+X10 #>=1,
        X6+X11 #>=1,
        X5+X12 #>=1,
        X4+X13 #=<1,
        X3+X14 #=<1,
        X2+X15 #=<1,
        X1+X16 #=<1,

        X1+X9 #=1,
        X2+X10 #=1,
        X3+X11 #=1,
        X4+X12 #=1,
        X5+X13 #=1,
        X6+X14 #=1,
        X7+X15 #=1,
        X8+X16 #=1,

        4 * X1 + X10+X11+X12+X15 #=< 4,
        3 * X2 + X10+X11+X12 #=< 3,
        3 * X3 + X11+X12+X15 #=< 3,
        4 * X15 + X4+X5+X6+X7 #=< 4,
        1 * X14 + X5 #=<1,
        6 * X16 + X2+X3+X4+X5+X6+X7 #=< 6.

        %label(Vars).


odcinek2([X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16]):-
	Vars = [X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16],
	Vars ins 0..1,
        %sumlist(Vars,8)
	sum(Vars,#=,8),
	(X16#=1) #==> (X15+X14+X13+X12+X11+X10+X9 #=7),
	(X15#=1) #==> (X14+X13+X12+X11+X10+X9 #=6),
	(X14#=1) #==> (X13+X12+X11+X10+X9 #=5),
	(X13#=1) #==> (X12+X11+X10+X9 #= 4),
	(X12#=1) #==> (X11+X10+X9 #= 3),
	(X11#=1) #==> (X10+X9 #= 2),
	(X10#=1) #==> (X9 #= 1),
        (X1#=1) #==> (X2+X3+X4+X5+X6+X7+X8 #= 7),
	(X2#=1) #==> (X3+X4+X5+X6+X7+X8 #= 6),
	(X3#=1) #==> (X4+X5+X6+X7+X8 #= 5),
	(X4#=1) #==> (X5+X6+X7+X8 #= 4),
	(X5#=1) #==> (X6+X7+X8 #= 3),
	(X6#=1) #==> (X7+X8 #= 2),
	(X7#=1) #==> (X8 #= 1).

	%label(Vars).

