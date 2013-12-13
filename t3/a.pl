% Aluno: Leonardo Wistuba de França
% GRR: 20093551

heuristica_horizontal(Lista, Total):-
	Total is 10.

heuristica_vertical(Lista, Total):-
	Total is 20.

heuristica_diagonal(Lista, Total):-
	Total is 30.

heuristica(Lista, Total):-
	heuristica_horizontal(Lista, TotalHorizontal),
	heuristica_vertical(Lista, TotalVertical),
	heuristica_diagonal(Lista, TotalDiagonal),
	Parcial is TotalHorizontal + TotalVertical,
	Total is Parcial + TotalDiagonal.
