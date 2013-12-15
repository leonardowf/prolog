% Aluno: Leonardo Wistuba de França
% GRR: 20093551


plausivel([EstadoJogadorA, EstadoJogadorB], Jogador, Altura, Res).

todosAdjacentes([EstadoJogadorA, EstadoJogadorB], Jogador, Resultado):-
	findall(X, adjacente([EstadoJogadorA, EstadoJogadorB], Jogador, X),Resultado).

last([Elem], Elem).
last([_|Tail], Elem) :- last(Tail, Elem).

ultimoJogado([TabuleiroJogadorA, TabuleiroJogadorB], a, UltimoJogado):-
	last(TabuleiroJogadorA, UltimoJogado).
ultimoJogado([TabuleiroJogadorA, TabuleiroJogadorB], b, UltimoJogado):-
	last(TabuleiroJogadorB, UltimoJogado).

escolheTabuleiro([JogadorA, JogadorB], a, JogadorA).
escolheTabuleiro([JogadorA, JogadorB], b, JogadorB).

respostaMinimax(Lista, Jogador, TabuleiroAnterior, Altura, Modo, Resposta):-
	todosAdjacentes(Lista, Jogador, TodosAdjacentes),
	%trace,
	minimax(Lista, Jogador, TabuleiroAnterior, Altura, Modo, 0, [Score, Indice], Simples),
	elemento(TodosAdjacentes, Indice, Resposta).

minimax(Lista, Jogador, TabuleiroAnterior, 0, Modo, IndiceAdjacente, [ValorHeuristica, IndiceAdjacente], ValorHeuristica):-
	inverteJogador(Jogador, JogadorInvertido),
	ultimoJogado(Lista, JogadorInvertido, UltimoJogado),
	escolheTabuleiro(Lista, JogadorInvertido, TabuleiroCerto),
	heuristica(UltimoJogado, TabuleiroCerto, ValorHeuristica).

minimax([EstadoJogadorA, EstadoJogadorB], Jogador, TabuleiroAnterior, Altura, Modo, IndiceAdjacente, ItemEscolhido, Simples):-
	todosAdjacentes([EstadoJogadorA, EstadoJogadorB], Jogador, TodosAdjacentes),
	%trace,
	 AlturaMenosUm is Altura - 1,
	inverteModo(Modo, ModoInvertido),
	inverteJogador(Jogador, JogadorInvertido),
 	paraCadaAdjacente(TodosAdjacentes, [EstadoJogadorA, EstadoJogadorB], JogadorInvertido, AlturaMenosUm, ModoInvertido, IndiceAdjacente, ScoresAdjacentes, SimplesScores),
 	%trace,
 	write(ScoresAdjacentes),
 	write(SimplesScores),
 	%% primeiro(ScoresAdjacentes, ItemEscolhido).
 	escolheOpcao(SimplesScores, Modo, Simples),
 	indexOf(SimplesScores, Simples, IndexEscolhido),
 	elemento(ScoresAdjacentes, IndexEscolhido, ItemEscolhido).

 primeiro([H|T], H).

paraCadaAdjacente([], [_, _], _, _, _, IndiceAdjacente, [], []).
paraCadaAdjacente([[HAdjacenteJogadorA, HAdjacenteJogadorB]|TAdjacente], [EstadoJogadorA, EstadoJogadorB], a, Altura, Modo, IndiceAdjacente, [ValorMiniMax|NotasTail], [Simples|SimplesTail]):-
	IndiceMaisUm is IndiceAdjacente + 1,
	minimax([EstadoJogadorA, HAdjacenteJogadorB], a, [EstadoJogadorA, EstadoJogadorB], Altura, Modo, IndiceAdjacente, ValorMiniMax, Simples),
	paraCadaAdjacente(TAdjacente, [EstadoJogadorA, EstadoJogadorB], a, Altura, Modo,IndiceMaisUm, NotasTail, SimplesTail).
paraCadaAdjacente([[HAdjacenteJogadorA, HAdjacenteJogadorB]|TAdjacente], [EstadoJogadorA, EstadoJogadorB], b, Altura, Modo,IndiceAdjacente, [ValorMiniMax|NotasTail], [Simples|SimplesTail]):-
	IndiceMaisUm is IndiceAdjacente + 1,
	minimax([HAdjacenteJogadorA, EstadoJogadorB], b, [EstadoJogadorA, EstadoJogadorB], Altura, Modo, IndiceAdjacente, ValorMiniMax, Simples),
	paraCadaAdjacente(TAdjacente, [EstadoJogadorA, EstadoJogadorB], b, Altura, Modo, IndiceMaisUm, NotasTail, SimplesTail).

escolheOpcao(ScoresAdjacentes, maior, Maior):-
	biggest(ScoresAdjacentes, Maior).

escolheOpcao(ScoresAdjacentes, menor, Menor):-
	smallest(ScoresAdjacentes, Menor).

smaller(X, Y, X):-
  (X =< Y).
smaller(X, Y, Y):-
  (Y < X).
smallest([Head|[]], Head).
smallest([Head|Tail], Answer):-
  smallest(Tail, What),
  smaller(What, Head, Answer).

bigger(X, Y, X):-
  (X > Y).
bigger(X, Y, Y):-
  (Y >= X).
biggest([Head|[]], Head).
biggest([Head|Tail], Answer):-
  biggest(Tail, What),
  bigger(What, Head, Answer).


inverteModo(maior, menor).
inverteModo(menor, maior).

inverteJogador(a, b).
inverteJogador(b, a).

elemento([H|T], 0, H).
elemento([H|T], Indice, Elemento):-
	NovoIndice is Indice - 1,
	elemento(T, NovoIndice, Elemento).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%Heurística%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

heuristica_horizontal(Lista, [Linha, Coluna],  Total):-
	% meuAppend([Linha, Coluna], Lista, ComProvavelNovoEle),
	overlapHorizontal([Linha, Coluna], Overlaps),
	%trace,
	paraTodosOverlaps(Overlaps, Lista, Total),
	!.

meuAppend(Ele, Lista, [Ele|Lista]).

paraTodosOverlaps([], _, 0).
paraTodosOverlaps([UmOverlap|TailOverlaps], Lista, Total):-
	paraTodosOverlaps(TailOverlaps, Lista, TotalContado),
	contaOverlap(UmOverlap, Lista, ContagemOverLap),
	score(ContagemOverLap, Pontuacao),
	Total is Pontuacao + TotalContado.

contaOverlap([], _, 0):- !.
contaOverlap([HOverlap|TOverlap], Lista, Aparicoes):-
	% Se HeadOverlap Pertence a Lista, aumenta aparicoes
	member(HOverlap, Lista),
	contaOverlap(TOverlap, Lista, DentroAparicoes),
	Aparicoes is DentroAparicoes + 1,
	!.
contaOverlap([_|TOverlap], Lista, Aparicoes):-
	contaOverlap(TOverlap, Lista, Aparicoes),
	!.

contains(_, []).
contains(L1, [X | L2]) :-
    member(X, L1),
    contains(L1, L2).

heuristica_vertical(Lista, [Linha, Coluna],  Pontuacao):-
	contaColuna(Lista, [Linha, Coluna], Contado),
	score(Contado, Pontuacao).

contaColuna([], _, 0).
contaColuna([[ListaLinha, ListaColuna]|T], [Linha, Coluna], Total):-
	contaColuna(T, [Linha, Coluna], TotalDentro),
	Coluna is ListaColuna,
	Total is TotalDentro + 1.
contaColuna([[ListaLinha, ListaColuna]|T], [Linha, Coluna], Total):-
	contaColuna(T, [Linha, Coluna], Total).

heuristica_diagonal(Lista, [Linha, Coluna],  Total):-
	Total is 0.

heuristica([Linha, Coluna], Lista, Total):-
	heuristica_horizontal(Lista, [Linha, Coluna], TotalHorizontal),
	heuristica_vertical(Lista, [Linha, Coluna], TotalVertical),
	heuristica_diagonal(Lista, [Linha, Coluna], TotalDiagonal),
	Parcial is TotalHorizontal + TotalVertical,
	Total is Parcial + TotalDiagonal.

delMember(_, [], []) :- !.
delMember(X, [X|Xs], Y) :- !, delMember(X, Xs, Y).
delMember(X, [T|Xs], Y) :- !, delMember(X, Xs, Y2), append([T], Y2, Y).

overlapHorizontal([Linha, Coluna], Resultado):-
	teste(-4, [Linha, Coluna], ResultadoComErro),
	delMember(errado, ResultadoComErro, Resultado).
	
teste(4, [_, _], []):-
	!.
teste(QuantidadeShift, [Linha, Coluna], [H|T]):-
	MaisUm is QuantidadeShift + 1,
	NovaColuna is Coluna + QuantidadeShift,
	NovaColuna =< Coluna,
	shift(QuantidadeShift, [Linha, Coluna], H),
	teste(MaisUm, [Linha, Coluna], T),
	!.

teste(_, [_, _], []):-
	!.
	
shift(QuantidadeShift, [_, Coluna], errado):-
	NovaColuna is Coluna + QuantidadeShift,
	NovaColuna < 1,
	!.
shift(QuantidadeShift, [_, Coluna], errado):-
	NovaColuna is Coluna + QuantidadeShift,
	NovaColuna > 7,
	!.
shift(QuantidadeShift, [_, Coluna], errado):-
	NovaColuna is Coluna + QuantidadeShift,
	LimiteInferior is Coluna - 4,
	NovaColuna =< LimiteInferior,
	!.
shift(QuantidadeShift, [_, Coluna], errado):-
	NovaColuna is Coluna + QuantidadeShift,
	Ultimo is NovaColuna + 3,
	Ultimo > 7,
	!.

shift(QuantidadeShift, [Linha, Coluna], Resultado):-
	NovaColuna is Coluna + QuantidadeShift,
	montaDeslocamento(0, [Linha, NovaColuna], Resultado),
	!.

montaDeslocamento(4, [_, _], []):-
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%Trabalho 1%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

topo([LINHA, COLUNA], TOPO):-
	SOMALINHA is LINHA + 1,
	TOPO = [SOMALINHA, COLUNA].
 
subset([ ],_).
subset([H|T],List) :-
    member(H,List),
    subset(T,List).
 
posicoesZeradas(Zeradas):-
	Zeradas = [[1,1],[1,2],[1,3],[1,4],[1,5],[1, 6], [1,7]].
 
adjacente([], Jogador, Proximo):-
	adjacenteCore([], [], Jogador, Proximo).
adjacente([ListaJogador1, ListaJogador2], Jogador, Proximo):-
	adjacenteCore(ListaJogador1, ListaJogador2, Jogador, Proximo).
 
adjacenteCore(Lista1, Lista2, JOGADOR, Proximo):-
	posicoesZeradas(Zeradas),
	praCada(Zeradas, Atual),
	not(vazia(Atual)),
	not(subset([Atual], Lista1)),
	not(subset([Atual], Lista2)),
	adicionaNaListaCerta(Lista1, Lista2, JOGADOR, Atual, Proximo).
 
adjacenteCore(Lista1, Lista2, JOGADOR, Proximo):-
        praCada(Lista1, Atual),
	not(vazia(Atual)),
        topo(Atual, TOPO),
        valido(TOPO),
        not(subset([TOPO], Lista1)),
        not(subset([TOPO], Lista2)),
        adicionaNaListaCerta(Lista1, Lista2, JOGADOR, TOPO, Proximo).
 
adjacenteCore(Lista1, Lista2, JOGADOR, Proximo):-
        praCada(Lista2, Atual),
        not(vazia(Atual)),
        topo(Atual, TOPO),
        valido(TOPO),
        not(subset([TOPO], Lista1)),
        not(subset([TOPO], Lista2)),
        adicionaNaListaCerta(Lista1, Lista2, JOGADOR, TOPO, Proximo).
 
escolheListaJogador(a, Lista1, _, ListaEscolhida):-
	ListaEscolhida = Lista1.
escolheListaJogador(b, _, Lista2, ListaEscolhida):-
        ListaEscolhida = Lista2.
	       
valido([LINHA, COLUNA]):-
	LINHA < 7,
	COLUNA < 8. 
 
vazia(Lista):-
	Lista = []. 
	
adicionaNaListaCerta(Lista1, Lista2, a, Atual, Proximo):-
	append(Lista1, [Atual], ComNovaPos),
	append([], [ComNovaPos], Temp),
	append(Temp, [Lista2], Proximo).
	
adicionaNaListaCerta(Lista1, Lista2, b, Atual, Proximo):-
	append(Lista2, [Atual], ComNovaPos),
    append([], [Lista1], Temp),
    append(Temp, [ComNovaPos], Proximo).	
 
praCada([H|_], Atual):-
	Atual = H.
praCada([_|T], Atual):-
	praCada(T, Atual).
praCada([], _).
	 
append([X|Y],Z,[X|W]):-
	append(Y,Z,W).  
append([],X,X).

indexOf([Element|_], Element, 0). % We found the element
indexOf([_|Tail], Element, Index):-
  indexOf(Tail, Element, Index1), % Check in the tail of the list
  Index is Index1+1.  % and increment the resulting index

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%Trabalho 1%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
