% ===============================================================================
% Author: Dante Pérez
%         Manuel Villalpando
% Date: 14/04/2023
% Descripción: Actividad 5.1 - Prolog
% ===============================================================================



% 1 lasto
lasto([X], X). % Caso base
lasto([_|T], X) :- lasto(T, X). % Caso recursivo

% lasto([1, 2, 3, 4], X).  X = 4

% 2 butlasto
butlasto([X], []). % Caso base
butlasto([H|T], [H|T1]) :- butlasto(T, T1). % Caso recursivo

% butlasto([1, 2, 3, 4], X).  X = [1, 2, 3]

% 3 enlisto
enlisto([], []). 
enlisto([H|T], [[H]|T1]) :- enlisto(T, T1).

% enlisto([1, 2, 3, 4], X).  X = [1, 2, 3, 4]

% 4 duplicateo
duplicateo([], []).
duplicateo([H|T], [H, H|T1]) :- duplicateo(T, T1).

% duplicateo([1, 2, 3, 4], X).  X = [1, 1, 2, 2, 3, 3, 4, 4]

% 5 removeo
removeo(X, [X|T], T).
removeo(X, [H|T], [H|T1]) :- removeo(X, T, T1).


% removeo(1, [1, 2, 3, 4], X).  X = [2, 3, 4]

% 6 reverseo
reverseo([], []).
reverseo([H|T], R) :- reverseo(T, TR), append(TR, [H], R).

% reverseo([1, 2, 3, 4], X).  X = [4, 3, 2, 1]

% 7 palindromeo
palindromeo(L) :- reverseo(L, L).

% palindromeo([1, 2, 3, 2, 1]).  true

% 8 ratateo
rotateo([H|T], Result) :- append(T, [H], Result). % El primer elemento se mueve al final

% rotateo([1, 2, 3, 4], X).  X = [2, 3, 4, 1]

% 9 evensizeo
evensizeo([]). 
evensizeo([_|T]) :- oddsizet(T). 

oddsizeo([_|T]) :- evensizet(T).

% evensizeo([1, 2, 3, 4]).  true

% 10 splito
splito([], [], []).
splito([X], [X], []).
splito([X, Y], [X], [Y]).
splito([X, Y|T], [X|L1], [Y|L2]) :- splito(T, L1, L2).

% splito([1, 2, 3, 4], X, Y).  X = [1, 3], Y = [2, 4]

% 11 swappero
% swappero([], []).
% swappero([X], [X]).
% swappero([X, Y|T], [Y, X|T1]) :- swappero(T, T1).

swappero(_, _, [], []).
swappero(A, B, [A|T], [B|R]) :- swappero(A, B, T, R).
swappero(A, B, [B|T], [A|R]) :- swappero(A, B, T, R).
swappero(A, B, [H|T], [H|R]) :- dif(H, A), dif(H, B), swappero(A, B, T, R).

% swappero(a, b, [a, b, a, b, b, b, a], Result).  Result = [b, a, b, a, a, a, b]

% 14 compresso
compresso([], []).
compresso([X], [X]).
compresso([X, X|T], R) :- compresso([X|T], R).
compresso([X, Y|T], [X|R]) :- dif(X, Y), compresso([Y|T], R).

% compresso([a, a, a, a, b, c, c, a, a, d, e, e, e, e], X).  X = [a, b, c, a, d, e]


