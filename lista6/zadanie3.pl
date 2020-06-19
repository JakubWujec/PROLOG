% a^n*b^n
% phrase(gram1,['a','a','b','b'])
gram1 --> aa, gram1, bb.
gram1 --> [].
aa --> [a].
bb --> [b].

% a^n*b^n*c^n
% phrase(gram2(1),X)
gram2(N) --> aas(N),bbs(N),ccs(N),!.
aas(0) --> [].
aas(N) --> [a],{N1 is N-1},aas(N1).
bbs(0) --> [].
bbs(N) --> [b],{N1 is N-1},bbs(N1).
ccs(0) --> [].
ccs(N) --> [c],{N1 is N-1},ccs(N1).


% a^n*b^(fib(n))
gram3(N) --> aas(N), {fib(N,X)}, bbs(X),!.


% extra
% phrase(p(L1),L2,L3). L2 = [L1|L3]
p([]) --> [].
p([X|Xs]) --> [X],p(Xs).


fib(0,0):-!.
fib(1,1):-!.
fib(N,X):-
	N1 is N-1,
	N2 is N-2,
	fib(N1,A),
	fib(N2,B),
	X is A+B,!.
