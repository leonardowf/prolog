intercalada(Lista1, Lista2, Intercalada):-
	a(Lista1, Lista2, Intercalada, 1).

a([],[],[],_).
a([H|T], [], [H|Resultado], _):-
	a(T, [], Resultado, 1).
a([], [H|T], [H|Resultado], _):-
	a([], T, Resultado, 2).
a([H1|T1], Lista2, [H1|Resultado], 1):-
	a(T1, Lista2, Resultado, 2).
a(Lista1, [H2|T2], [H2|Resultado], 2):-
	a(Lista1, T2, Resultado, 1).