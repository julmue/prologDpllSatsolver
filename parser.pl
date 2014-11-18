:- module(parser,[  exp/3,
                    exp/4,
                    exp_rest/4
                 ]).

% ----------------------------------------------------------------------

% grammar

/*
	% logical variables
	exp --> v

	% junctors of arity 0
	exp --> ver
	exp --> fal

	% junctors of arity 1
	exp --> not exp
	exp --> exp and exp
	exp --> exp or exp

	% parentheses
	exp --> l_left_par exp l_right_par

*/

%% parser

/* get rid of left recursion

    A --> Aa1 | ... | Aan | b1 | ... | bn

    where
    * A is a left-recursive non-terminal
    * a is a sequence of terminals and non-terminals that is not null
    * b is a sequence of terminals and non-terminals that does not start with A

    I. repalce the A-production by the production
    A --> b1A' | ... | bnA'
    II. create a new non-terminal
    A' --> null | a1A' | ... | anA'

*/

%%% production rules

%%%% logical variables
exp(v(X)) --> v(X), exp_rest(end,_).
exp(and(v(X),Y),R) -->v(X), exp_rest(and(Y), R).
exp(or(v(X),Y),R) -->v(X), exp_rest(or(Y), R).

%%%% junctors of arity 0
exp(X) --> ver(X), exp_rest(end,_).
exp(and(X,Y), R) --> ver(X), exp_rest(and(Y),R).
exp(or(X,Y), R) --> ver(X), exp_rest(or(Y),R).

exp(X) --> fal(X), exp_rest(end,_).
exp(and(X,Y), R) --> fal(X), exp_rest(and(Y),R).
exp(or(X,Y), R) --> fal(X), exp_rest(or(Y),R).

%%%% junctors of arity 1
exp(l_not(X)) --> l_not, exp(X), exp_rest(end,_).
exp(and(l_not(X),Y),R) --> l_not, exp(X), exp_rest(and(Y),R).
exp(or(l_not(X),Y),R) --> l_not, exp(X), exp_rest(or(Y),R).

%%%%% parentheses
exp(X) --> l_left_par, exp(X), l_right_par, exp_rest(end,_).
exp(and(X,Y), R) --> l_left_par, exp(X), l_right_par, exp_rest(and(Y), R).
exp(or(X,Y), R) --> l_left_par, exp(X), l_right_par, exp_rest(or(Y), R).

%%% junctors of arity 2
exp_rest(end, []) --> [].
exp_rest(and(Y), R) --> and, exp(Y), exp_rest(R).
exp_rest(or(Y), R) --> or, exp(Y), exp_rest(R).

%%% alphabet
v(v(X)) --> [X].

ver('T') --> ['T'].
fal('F') --> ['F'].

l_not --> ['~'].

and --> ['&&'].
or --> ['||'].

l_left_par --> ['('].
l_right_par --> [')'].

