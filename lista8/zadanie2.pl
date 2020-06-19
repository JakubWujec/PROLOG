% Dyskretny problem plecakowyczyli (0-1)
% plecak(+Wartości, +Wielkości,
% +Pojemność, -Zmienne).
%
% ex.
% ?- plecak([10,7,1,3,2],[9,12,2,7,5], 15, X).
% X = [1, 0, 0, 0, 1].
%
% labelling(max(V),[V,W,C,Q]).

:- use_module(library(clpfd)).

inner_product([],[],0).
inner_product([X|Xs],[Y|Ys],IP):-
	inner_product(Xs,Ys,IP1), IP #= X*Y+IP1.


plecak(Wartości,Wielkości,Pojemność,Zmienne):-
	length(Wartości,Len), length(Zmienne,Len),
	Zmienne ins 0..1,
	inner_product(Zmienne,Wielkości,Waga),
	Waga #=< Pojemność,
	inner_product(Zmienne,Wartości,CEL),
	% labeling([max(CEL)],Zmienne). % wszystkie rozwiązania
	once(labeling([max(CEL)], Zmienne)). % tylko dla najlepszego rozwiązania

% wersja razem z wynikiem
plecak2(Wartości, Wielkości,Pojemność,Zmienne,Score):-
	plecak(Wartości,Wielkości,Pojemność,Zmienne),
	inner_product(Zmienne,Wartości,Score).




