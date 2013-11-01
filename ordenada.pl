ordenada(X, [], [X]):-
	!.

ordenada(X, [H|T], [X|[H|T]]):-
	X < H,
	!.

ordenada(X, [H|T], [H|Resposta]):-
	ordenada(X, T, Resposta).