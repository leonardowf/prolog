% Aluno: Leonardo Wistuba de França
% GRR: 20093551

% [[[1, 4], [1, 5], [1, 6], [1, 7]]].
heuristica_horizontal(Lista, [Linha, Coluna],  Total):-
	meuAppend([Linha, Coluna], Lista, ComProvavelNovoEle),
	overlapHorizontal([Linha, Coluna], Overlaps),
	paraTodosOverlaps(Overlaps, ComProvavelNovoEle, Total),
	!.

meuAppend(Ele, Lista, [Ele|Lista]).

paraTodosOverlaps([], Lista, 0).
paraTodosOverlaps([UmOverlap|TailOverlaps], Lista, Total):-
	paraTodosOverlaps(TailOverlaps, Lista, TotalContado),
	contaOverlap(UmOverlap, Lista, ContagemOverLap),
	score(ContagemOverLap, Pontuacao),
	Total is Pontuacao + TotalContado.

contaOverlap([], Lista, 0):- !.
contaOverlap([HOverlap|TOverlap], Lista, Aparicoes):-
	% Se HeadOverlap Pertence a Lista, aumenta aparicoes
	member(HOverlap, Lista),
	contaOverlap(TOverlap, Lista, DentroAparicoes),
	Aparicoes is DentroAparicoes + 1,
	!.
contaOverlap([HOverlap|TOverlap], Lista, Aparicoes):-
	contaOverlap(TOverlap, Lista, Aparicoes),
	!.

contains(_, []).
contains(L1, [X | L2]) :-
    member(X, L1),
    contains(L1, L2).

heuristica_vertical(Lista, [Linha, Coluna],  Total):-
	Total is 0.

heuristica_diagonal(Lista, [Linha, Coluna],  Total):-
	Total is 0.

heuristica([Linha, Coluna], Lista, Total):-
	heuristica_horizontal(Lista, [Linha, Coluna], TotalHorizontal),
	heuristica_vertical(Lista, [Linha, Coluna], TotalVertical),
	heuristica_diagonal(Lista, [Linha, Coluna], TotalDiagonal),
	Parcial is TotalHorizontal + TotalVertical,
	Total is Parcial + TotalDiagonal.

delMember(X, [], []) :- !.
delMember(X, [X|Xs], Y) :- !, delMember(X, Xs, Y).
delMember(X, [T|Xs], Y) :- !, delMember(X, Xs, Y2), append([T], Y2, Y).

overlapHorizontal([Linha, Coluna], Resultado):-
	teste(-4, [Linha, Coluna], ResultadoComErro),
	delMember(errado, ResultadoComErro, Resultado).
	
teste(4, [Linha, Coluna], []):-
	!.
teste(QuantidadeShift, [Linha, Coluna], [H|T]):-
	MaisUm is QuantidadeShift + 1,
	NovaColuna is Coluna + QuantidadeShift,
	NovaColuna =< Coluna,
	shift(QuantidadeShift, [Linha, Coluna], H),
	teste(MaisUm, [Linha, Coluna], T),
	!.

teste(QuantidadeShift, [Linha, Coluna], []):-
	!.

	
shift(QuantidadeShift, [Linha, Coluna], errado):-
	NovaColuna is Coluna + QuantidadeShift,
	NovaColuna < 1,
	!.
shift(QuantidadeShift, [Linha, Coluna], errado):-
	NovaColuna is Coluna + QuantidadeShift,
	NovaColuna > 7,
	!.
shift(QuantidadeShift, [Linha, Coluna], errado):-
	NovaColuna is Coluna + QuantidadeShift,
	LimiteInferior is Coluna - 4,
	NovaColuna =< LimiteInferior,
	!.
shift(QuantidadeShift, [Linha, Coluna], errado):-
	NovaColuna is Coluna + QuantidadeShift,
	Ultimo is NovaColuna + 3,
	Ultimo > 7,
	!.

shift(QuantidadeShift, [Linha, Coluna], Resultado):-
	NovaColuna is Coluna + QuantidadeShift,
	montaDeslocamento(0, [Linha, NovaColuna], Resultado),
	!.

montaDeslocamento(4, [Linha, Coluna], []):-
	!.
montaDeslocamento(Adicionados, [Linha, Coluna], [[Linha, NovaColuna]|T]):-
	NovoAdicionados is Adicionados + 1,
	NovaColuna is Coluna + Adicionados,
	montaDeslocamento(NovoAdicionados, [Linha, Coluna], T),
	!.

score(1, 1).
score(2, 4).
score(3, 32).
score(4, 10000).


	





	