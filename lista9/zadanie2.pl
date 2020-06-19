:- use_module(library(clpfd)).

% kwadraty([1,1,1,1,2,2,2,2,3,3], 7, 6, X), write(X).
kwadraty(Rozmiar,Szerokość,Wysokość,Współrzędne):-
	square_list(Rozmiar,Pola),
	Duże_Pole is Szerokość * Wysokość,
	sum_list(Pola,Suma_Pól),
	Suma_Pól #=< Duże_Pole,
	sides_to_squares(Rozmiar,Szerokość,Wysokość,Kwadraty,Współrzędne),
	disjoint2(Kwadraty),
	labeling([max],Współrzędne).

% Zamienia listę boków (Side) na listę funktorów prostokąta
% f(X,Side,Y,Side)
sides_to_squares([],_,_,[],[]).
sides_to_squares([Side|T1],W,H,[f(X,Side,Y,Side)|T2],[X,Y|Współrzędne_Tail]):-
	Limited_W is W - Side,
	Limited_H is H - Side,
	X in 0..Limited_W,
	Y in 0..Limited_H,
	sides_to_squares(T1,W,H,T2,Współrzędne_Tail).


square_list([], []).
square_list([X|Xs], [Y|Ys]):-
  Y is X ^ 2,
  square_list(Xs, Ys).




