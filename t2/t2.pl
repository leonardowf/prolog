% Aluno: Leonardo Wistuba de França
% GRR: 20093551
custo(CidadeA, CidadeB, [H|_], Custo):-
	splitCusto(H, CidadeA, CidadeB, Custo),
	!.
custo(CidadeA, CidadeB, [_|T], Custo):-
	custo(CidadeA, CidadeB, T, Custo).

splitCusto([CidadeA, CidadeB, Custo], CidadeA, CidadeB, Custo).
splitCusto([CidadeA, CidadeB, Custo], CidadeB, CidadeA, Custo).

aleatorio(Maximo, R):-
	R is random(Maximo) + 1.

criaListaInicial(_, 0, []):-
	!.
criaListaInicial(NumCidades, CidadeAtual, [CidadeAtual|Tail]):-
	Elemento is CidadeAtual - 1,
	criaListaInicial(NumCidades, Elemento, Tail).

custoSolucao([X], _, 0, X):-
	!.
custoSolucao([PrimeiraCidade, SegundaCidade|TailSolucao], CidadesECustos, Custo, UltimaCidade):-
	custoSolucao([SegundaCidade|TailSolucao], CidadesECustos, CustoResto, UltimaCidade),
	custo(PrimeiraCidade, SegundaCidade, CidadesECustos, MeuCusto),
	Custo is MeuCusto + CustoResto.
custoTotal([PrimeiraCidade|TailSolucao], CidadesECustos, Custo):-
	custoSolucao([PrimeiraCidade|TailSolucao], CidadesECustos, CustoResto, UltimaCidade),
	custo(UltimaCidade, PrimeiraCidade, CidadesECustos, CustoPrimeiraUltima),
	Custo is CustoResto + CustoPrimeiraUltima.

replace([_|T], 0, X, [X|T]):-
	!.
replace([H|T], I, X, [H|R]):-
	I > 0, I1 is I-1, 
	replace(T, I1, X, R).

caixeiro(NumCidades, CidadesECustos):-
	get_time(Inicio),
	criaListaInicial(NumCidades, NumCidades, PossivelSolucao),
	custoTotal(PossivelSolucao, CidadesECustos, CustoPossivelSolucao),
	agita(NumCidades,CidadesECustos, PossivelSolucao, CustoPossivelSolucao, _, 0, Inicio).

agita(NumCidades, CidadesECustos, PossivelSolucao, CustoPossivelSolucao, MelhorSolucao, _, Inicio):-
	%trace,
	aleatorio(NumCidades, CidadeASerTrocada),
	aleatorio(NumCidades, CidadeASerTrocadaPor),
	indexOf(PossivelSolucao, CidadeASerTrocada, IndexCidadeASerTrocada),
	indexOf(PossivelSolucao, CidadeASerTrocadaPor, IndexCidadeASerTrocadaPor),
	replace(PossivelSolucao, IndexCidadeASerTrocada, CidadeASerTrocadaPor, TrocaParcial),
	replace(TrocaParcial, IndexCidadeASerTrocadaPor, CidadeASerTrocada, TrocaCompleta),
	custoTotal(TrocaCompleta, CidadesECustos, CustoSolucaoTrocada),
	%trace,
	CustoSolucaoTrocada < CustoPossivelSolucao,
	agita(NumCidades, CidadesECustos, TrocaCompleta, CustoSolucaoTrocada, MelhorSolucao, 0, Inicio).

agita(NumCidades, _, [PrimeiraCidade|PossivelSolucao], CustoPossivelSolucao, MelhorSolucao, VezesSemOutraSolucao, Inicio):-
	VezesSemOutraSolucao > NumCidades * 10,
	get_time(Fim),
	Total is Fim - Inicio,

	append([PrimeiraCidade|PossivelSolucao], [PrimeiraCidade] , MelhorSolucao),
	write('Ciclo = '),
	write(MelhorSolucao),
	write('\n'),
	write('Custo = '),
	write(CustoPossivelSolucao),
	write('\n'),
	write('Tempo = '),
	write(Total),
	write(' segundo(s)\n'),
	Produto is CustoPossivelSolucao * Total,
	write('Produto = '),
	write(Produto),
	write('\n'),
	!.

agita(NumCidades, CidadesECustos, PossivelSolucao, CustoPossivelSolucao, MelhorSolucao, VezesSemOutraSolucao, Inicio):-
	MaisUm is VezesSemOutraSolucao + 1,
	agita(NumCidades, CidadesECustos, PossivelSolucao, CustoPossivelSolucao, MelhorSolucao, MaisUm, Inicio).

indexOf([Element|_], Element, 0):- !.
indexOf([_|Tail], Element, Index):-
  indexOf(Tail, Element, Index1),
  !,
  Index is Index1+1.