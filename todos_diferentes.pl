todos_sao_diferentes([]).
todos_sao_diferentes([H|T]):-
	not(meuSelect(H, T, Result)),
	todos_sao_diferentes(T).

meuSelect(Elemento, Lista, Resultado):-
	meuSelectCore(Elemento, Lista, Resultado),
	not(Resultado = Lista).

meuSelectCore(X, [],[]).
meuSelectCore(X, [X|T], Resultado):-
	meuSelectCore(X, T, Resultado),
	!.
meuSelectCore(X, [H|T], [H|Resultado]):-
	meuSelectCore(X, T, Resultado).
