sucessor(a, b).
sucessor(b, c).
sucessor(c, d).
sucessor(d, e).
sucessor(e, f).
sucessor(f, g).

codificada([], _, []).
codificada([H|T], NumeroShifts, [Encontrado|Resultado]):-
	buscaLetra(H, NumeroShifts, Encontrado),
	codificada(T, NumeroShifts, Resultado).
	
buscaLetra(Letra, 0, Letra):-
	!.
buscaLetra(Letra, 1, Resultado):-
	sucessor(Letra, Resultado),
	!.
buscaLetra(Letra, Vezes, Resultado):-
	TempVezes is Vezes - 1,
	sucessor(Letra, TempLetra),
	buscaLetra(TempLetra, TempVezes, Resultado).