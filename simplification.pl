:- module(simplification,[simpl/2]).

% simplification of formula

%% determined simplification

simpl(or('T',_), 'T') :- !.
simpl(or(_,'T'), 'T') :- !.
simpl(or('F','F'), 'F') :- !.

simpl(and('T','T'), 'T') :- !.
simpl(and('F',_), 'F') :-!.
simpl(and(_,'F'), 'F') :-!.

simpl(not('F'),'T') :-!.
simpl(not('T'),'F') :-!.


%% non-determined simplification
simpl(or(X,'F'), X1) :- simpl(or('F',X), X1), !.
simpl(or('F',X), X1) :-
    dif(X,'T'),
    dif(X,'F'),
    !,
    simpl(X,IX),
    ( (IX = 'T' ; IX = 'F') ->
        simpl(or('F',IX),X1)
    ;
        X1 = or('F',IX)
    ).

simpl(and(X,'T'), X1) :- simpl(and('T',X), X1), !.
simpl(and('T',X), X1) :-
    dif(X,'T'),
    dif(X,'F'),
    !,
    simpl(X,IX),
    ( (IX = 'T' ; IX = 'F') ->
        simpl(and('T',IX),X1)
    ;
        X1 = and('T', IX)
    ).

simpl(not(X),X1) :-
	dif(X,'T'),
	dif(X,'F'),
	simpl(X,IX),

    ( (IX = 'T' ; IX = 'F') ->
        simpl(not(IX),X1)
	;
		X1 = IX
	).


simpl(v(X),v(X)) :- !.
simpl('T','T') :- !.
simpl('F','F') :- !.
