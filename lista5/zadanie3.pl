% Program konczy wykonywanie przez wybranie opcji "o" będąc w korzeniu %
%
% browse(Term) obchodzenie drzewa term%
% • in – przejście z bieżącego wierzchołka do pierwszego jego syna,
% • out – powrót do ojca bieżącego wierzchołka,
% • next – przejście do następnego brata,
% • prev – przejście do poprzedniego brata.
%   curr - zostajesz w tym samym
% Term =.. [Funktor | ListaArgumentów]
% browse(f1(f2(a2, a3), a1, f3(a4))).
% browse(f1(f2(a2, a3), a1, 'F3'('A4'))).

% f1(f2(a2,a3),a1,f3(a4)).

browse(Term):-
	append([],[Term],Memory),
        browse2(Memory).

browse2([]).
browse2(Memory):-
	Memory = [Current|_],
	write_current(Current),
        take_input(Option2),
	do_option(Memory,Option2).


do_option(Memory, Option):-
        (
	  (Option = 'i') ->
	    Memory = [Current|_],
	    Current =.. [_|Children],
            % jesli nie ma dzieci to zostan w tym samym
            (length(Children,0) ->
	      NewMemory = Memory
	    ;
              Children = [Son|_],
              NewMemory = [Son|Memory]),
	    !
	  ;
          (Option = 'o') ->
	    Memory = [_|Older],
	    (length(Older,0) ->
	      NewMemory = []
	    ;
	      NewMemory = Older),
	    !
	  ;
	  (Option = 'n') ->
	    % jeśli |Memory|=1 to jest w korzeniu, zatem tam zostaje
	    (length(Memory,1)->
	      NewMemory=Memory
	      ;
	      (
	        Memory = [Current,Parent|Rest],
	        Parent =.. [_|Children],
                % jesli nie ma żadnego po nim to zostan w tym samym
                (append(_,[Current,X|_],Children)
		;
		X=Current),!,
                NewMemory = [X,Parent|Rest],
                !
	      )
	    )
	  ;
	  (Option = 'p') ->
            (length(Memory,1)->
	      NewMemory = Memory
	      ;
	      (
                Memory = [Current,Parent|Rest],
	        Parent =.. [_|Children],
                (append(_,[X,Current|_],Children)
		;
		X=Current),!,
                NewMemory = [X,Parent|Rest],
	        !
	      )
	    )
          ;
	  (Option = _) ->
	    NewMemory = Memory,
	    !
	),
	browse2(NewMemory).


write_current(Current):-
	write('current: '),
	writeq(Current),nl.
take_input(X):-
	write('command: '),
	read(X).





