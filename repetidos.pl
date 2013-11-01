repetidos([], []).
repetidos([H1|T1], [H1|Resultado]):-
	pertenceCerto(H1, T1),
	deleteall(T1,H1,Removidos),
	repetidos(Removidos, Resultado).
repetidos([H1|T1], Resultado):-
	not(pertenceCerto(H1, T1)),
	repetidos(T1, Resultado).

deleteall([],_,[]).
deleteall([A|T], A, Result):-
	deleteall(T, A, Result).
deleteall([H|T], A, [H|Result]):-
	deleteall(T, A, Result).