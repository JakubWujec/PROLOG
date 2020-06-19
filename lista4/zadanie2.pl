
/* Dom = (Numer,Mieszkaniec,Kolor,Papieroy,Napoj,Zwierze) */

/* po_lewej(X,Y) X po lewej od Y */
po_lewej(1,2).
po_lewej(2,3).
po_lewej(3,4).
po_lewej(4,5).

po_prawej(X,Y):- po_lewej(Y,X).
obok(X,Y):- po_lewej(X,Y); po_prawej(X,Y).


rybki(Kto):-
    Domy = [[1,_,_,_,_,_],[2,_,_,_,_,_],[3,_,_,_,_,_],[4,_,_,_,_,_],[5,_,_,_,_,_]],
    member([1,norweg,_,_,_,_],Domy),
    member([_,anglik,czerwony,_,_,_],Domy),
    po_lewej(ZielonyNumer,BialyNumer),member([ZielonyNumer,_,zielony,_,_,_],Domy), member([BialyNumer,_,bialy,_,_,_],Domy),
    member([_,dunczyk,_,_,herbatka,_],Domy),
    obok(LightNumer,KotNumer),member([LightNumer,_,_,light,_,_],Domy),member([KotNumer,_,_,_,_,kot],Domy),
    member([_,_,zolty,cygaro,_,_],Domy),
    member([_,niemiec,_,fajka,_,_],Domy),
    member([3,_,_,_,mleko,_],Domy),
    obok(LightNumer,WodaNumer),member([LightNumer,_,_,light,_,_],Domy),member([WodaNumer,_,_,_,woda,_],Domy),
    member([_,_,_,nofilter,_,ptaki],Domy),
    member([_,szwed,_,_,_,pies],Domy),
    obok(NorwegNumer,NiebieskiNumer),member([NorwegNumer,norweg,_,_,_,_],Domy),member([NiebieskiNumer,_,niebieski,_,_,_],Domy),
    obok(KonNumer,ZoltyNumer),member([KonNumer,_,_,_,_,kon],Domy),member([ZoltyNumer,_,zolty,_,_,_],Domy),
    member([_,_,_,mentolowe,piwo,_],Domy),
    member([_,_,zielony,_,kawa,_],Domy),
    member([_,Kto,_,_,_,rybki],Domy),!.
    %member(Kto,Domy).











