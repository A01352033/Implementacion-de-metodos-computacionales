/* 1.  */
lasto([X], X).
lasto([_|T], X) :- lasto(T, X).

/* 8. Rotateo */
rotateo([], []).
rotateo([H|T], R) :- append(T, [H], R).

/* 7. Palindromeo */ 
reverseo([], []).
reverseo([H|T], R) :- reverseo(T, TR), append(TR, [H], R).

palindromeo(L) :- reverseo(L, L).

/* 9. evensizeo y oddsizeo */
sizeo([], 0).
sizeo([_|T], N) :- sizeo(T, N1), N is N1 + 1.

evensizeo(L) :- sizeo(L, N), N mod 2 =:= 0.
oddsizeo(L) :- sizeo(L, N), N mod 2 =:= 1.

/* 10. Splito */
splito_aux([], [], []).
splito_aux([H|T], [H|A], B) :- splito_aux(T, B, A).

splito(L, A, B) :- splito_aux(L, A, B), length(A, NA), length(B, NB), NA =:= NB.
