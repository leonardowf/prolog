% Aluno: Leonardo Wistuba de França
% GRR: 20093551

heuristica_horizontal(Lista, [Linha, Coluna],  Total):-
	Total is 10.

heuristica_vertical(Lista, [Linha, Coluna],  Total):-
	Total is 20.

heuristica_diagonal(Lista, [Linha, Coluna],  Total):-
	Total is 30.

heuristica(Lista, Total):-
	heuristica_horizontal(Lista, [1, 1], TotalHorizontal),
	heuristica_vertical(Lista, [1, 1], TotalVertical),
	heuristica_diagonal(Lista, [1, 1], TotalDiagonal),
	Parcial is TotalHorizontal + TotalVertical,
	Total is Parcial + TotalDiagonal.

pegaQuatro([Linha, Coluna], Resultado):-
	Coluna is 3,
	pegaEsquerda(1, [Linha, Coluna], ResultadoEsquerda),
	pegaDireita(2, [Linha, Coluna], ResultadoDireita),
	append(ResultadoEsquerda, ResultadoDireita, Resultado).

pegaQuatro([Linha, Coluna], Resultado):-
	Coluna is 2,
	pegaEsquerda(1, [Linha, Coluna], ResultadoEsquerda),
	pegaDireita(2, [Linha, Coluna], ResultadoDireita),
	append(ResultadoEsquerda, ResultadoDireita, Resultado).

pegaQuatro([Linha, Coluna], Resultado):-
	QuantidadeDireita is 4 - Coluna,
	QuantidadeEsquerda is 3 - QuantidadeDireita,
	pegaDireita(QuantidadeDireita, [Linha, Coluna], Resultado).

pegaDireita(0, [Linha, Coluna], []).
pegaDireita(Quantidade, [Linha, Coluna], [[Linha, NovaColuna]|T]):-
	NovaColuna is Coluna + 1,
	MenosUm is Quantidade - 1,
	pegaDireita(MenosUm, [Linha, NovaColuna], T).

pegaEsquerda(0, [Linha, Coluna], []).
pegaEsquerda(Quantidade, [Linha, Coluna], [[Linha, NovaColuna]|T]):-
	NovaColuna is Coluna - 1,
	MenosUm is Quantidade - 1,
	pegaEsquerda(MenosUm, [Linha, NovaColuna], T).

regraColuna(Coluna, Esquerda, Direita):-
	Coluna is 1,
	Esquerda is 0,
	Direita is 3.

regraColuna(Coluna, Esquerda, Direita):-
	Coluna is 2,
	Esquerda is 1,
	Direita is 2.

regraColuna(Coluna, Esquerda, Direita):-
	Coluna is 3,
	Esquerda is 2,
	Direita is 1.


	





	