% mamy bloki R1..R9
% Każde sąsiednie mają mieć inny kolor
% kolory oznaczone numerami 1,2,3


:- use_module(library(clpfd)).


kolorowanie([R1,R2,R3,R4,R5,R6,R7,R8,R9]):-
	Vars = [R1,R2,R3,R4,R5,R6,R7,R8,R9],
	Vars ins 1..3,
	R1 #\= R2, R1 #\= R4, R1 #\= R5, R1 #\= R6,
	R2 #\= R3, R2 #\= R4, R1 #\= R9,
	R3 #\= R4, R3 #\= R5, R3 #\= R9,
	R4 #\= R5,
	R5 #\= R6, R5 #\= R7, R5 #\= R9,
	R6 #\= R7, R6 #\= R8,
	R7 #\= R8, R7 #\= R9,
	R8 #\= R9.
        %label(X).
