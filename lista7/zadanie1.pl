% Wykorzystując korutyny napisz predykat merge(IN1, IN2, OUT) scalający
% dwa niemalejące strumienie liczb IN1 i IN2 w jeden niemalejący strumień
% liczb OUT2


merge(IN1,IN2,OUT):-
	freeze(IN1,
	       freeze(IN2,
		      (
			  (   IN1 = [H1|T1]
			  ->  ( IN2 = [H2|T2] % oba niepuste
			      -> (H1 < H2
				 -> (
					   OUT = [H1|OUT2],
					   merge(T1,IN2,OUT2)
				    )
				 ;
				    (
					   OUT = [H2|OUT2],
					   merge(IN1,T2,OUT2)
				    )
				 )
			      ;	 % jeśli IN2 jest puste
			         (OUT=IN1)
			      )
			  ;   % jeśli IN1 jest puste
			      ( IN2=[H2|T2]
			      ->  OUT = IN2
			      ;
				  OUT = [] % IN1 i IN2 puste
			      )
			  )
		      )
		     )

	      ).


/*
 * pierwsza wersja bez freeze
merge([],IN2,OUT,TMPOUT):-
	append(TMPOUT,IN2,OUT).
merge(IN1,[],OUT,TMPOUT):-
	append(TMPOUT,IN1,OUT).
merge(IN1,IN2,OUT,TMPOUT):-
	IN1 = [H1|T1],
	IN2 = [H2|T2],
	(   H1 < H2
	->  append(TMPOUT,[H1],TMPOUT_),
	    merge(T1,IN2,OUT,TMPOUT_)
	;   append(TMPOUT,[H2],TMPOUT_),
	    merge(IN1,T2,OUT,TMPOUT_)).
merge(IN1,IN2,OUT):-
	merge(IN1,IN2,OUT,[]).
*/










