% split(IN,OUT1,OUT2)

split(IN,OUT1,OUT2):-
	split(IN,OUT1,OUT2,1).
split(IN,OUT1,OUT2,WHERE):-
	freeze(IN,(
		    (	IN=[H1|T1]
		    ->
			(   WHERE is 1
			->
			    OUT1=[H1|OUTX],
			    split(T1,OUTX,OUT2,2)
			;
			    OUT2=[H1|OUTX],
			    split(T1,OUT1,OUTX,1)
			)
		    ;
		        OUT1=[],
		        OUT2=[]
		    )
	          )
	      ).

% z nazwą merge były problemy bo przesłaniała wbudowaną już metodę merge
% zatem zmieniłem na mergex
mergex(IN1,IN2,OUT):-
	freeze(IN1,
	       freeze(IN2,
		      (
			  (   IN1 = [H1|T1]
			  ->  ( IN2 = [H2|T2]
			      -> (H1 < H2
				 -> (
					   OUT = [H1|OUT2],
					   mergex(T1,IN2,OUT2)
				    )
				 ;
				    (
					   OUT = [H2|OUT2],
					   mergex(IN1,T2,OUT2)
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

merge_sort(IN,OUT):-
	freeze(IN,
	       (
		   IN=[H1|T1]
		   -> freeze(T1,
			(   T1=[] % jednoelementowa lista
			->  (
			        OUT=[H1]
			    )
			;
			    (
			        split(IN,OUT1,OUT2),
				merge_sort(OUT1,R1),
				merge_sort(OUT2,R2),
				mergex(R1,R2,OUT)
			    )
			)


		   )
		   ;
		   % pusta lista
		   OUT = []
	       )
	      ).




/* bez korutyn
merge_sort([],[]).
merge_sort([X],[X]).
merge_sort([X,Y],[X,Y]):- X =< Y,!.
merge_sort([X,Y],[Y,X]):- Y =< X,!.
merge_sort(IN,OUT):-
	split(IN,OUT1,OUT2),
	merge_sort(OUT1,R1),
	merge_sort(OUT2,R2),
	mergex(R1,R2,OUT),!.

*/













