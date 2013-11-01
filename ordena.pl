menor([X], X).
menor([H|T], Menor):-
	menor(T, UmPossivelMenor),
	UmPossivelMenor < H,
	Menor = UmPossivelMenor,
	!.

menor([H|T], Menor):-
	menor(T, UmPossivelMenor),
	UmPossivelMenor >= H,
	Menor = H,
	!.

ordena([], []):-
	!.
ordena(Lista, [Menor|Resultado]):-
	menor(Lista, Menor),
	select(Menor, Lista, ListaSemMenor),
	ordena(ListaSemMenor, Resultado),
	!.