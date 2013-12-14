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
 
escolheListaJogador(a, Lista1, Lista2, ListaEscolhida):-
	ListaEscolhida = Lista1.
escolheListaJogador(b, Lista1, Lista2, ListaEscolhida):-
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
 
praCada([H|T], Atual):-
	Atual = H.
praCada([H|T], Atual):-
	praCada(T, Atual).
praCada([], Atual).
	 
append([X|Y],Z,[X|W]):-
	append(Y,Z,W).  
append([],X,X).