% Aluno: Leonardo Wistuba de França
% GRR: 20093551
conexoesCom(CidadeA, [], []).
conexoesCom(CidadeA, [[WO, WD, WC]|T], [[WO, WD, WC]|Conexoes]):-
	conexoesCom(CidadeA, T, Conexoes),
	WO is CidadeA,
	!.
conexoesCom(CidadeA, [[WO, WD, WC]|T], [[WO, WD, WC]|Conexoes]):-
	conexoesCom(CidadeA, T, Conexoes),
	WD is CidadeA,
	!.

conexoesCom(CidadeA, [[WO, WD, WC]|T], Conexoes):-
	conexoesCom(CidadeA, T, Conexoes).
	

vizinhoMaisProximo(CidadeA, [H|T], ListaVisitados, MaisProximo, Custo).







custo(CidadeA, CidadeB, [H|_], Custo):-
	splitCusto(H, CidadeA, CidadeB, Custo),
	!.
custo(CidadeA, CidadeB, [_|T], Custo):-
	custo(CidadeA, CidadeB, T, Custo).

splitCusto([CidadeA, CidadeB, Custo], CidadeA, CidadeB, Custo).
splitCusto([CidadeA, CidadeB, Custo], CidadeB, CidadeA, Custo).

aleatorio(R):-
	R is random(60) + 1.
	
