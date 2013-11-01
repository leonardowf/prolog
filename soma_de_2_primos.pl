e_primo(1).
e_primo(2).
e_primo(3).
e_primo(5).
e_primo(7).
e_primo(11).
% ...

soma_de_2_naturais(X, [T1,T2]):-
	X is T1 + T2.

soma_de_2_primos(Total, [T1, T2]):-
	e_primo(T1),
	e_primo(T2),
	soma_de_2_naturais(Total, [T1, T2]).

