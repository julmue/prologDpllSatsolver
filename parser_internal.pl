:- module(parser_internal,[ rec_expr/1,
                            expr/2,
                            expr_rest/3,
                            v/2,
                            ver/2,
                            fal/2,
                            neg/2,
                            and/2,
                            or/2,
                            l_par/2,
                            r_par/2]).

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

%% expresion recogniser
rec_expr(E) :-
    expr(E,[]).

%%% production rules
%
%%%% logical variables
expr --> v, expr_rest(end).
expr --> v, expr_rest(and).
expr --> v, expr_rest(or).

%%%% junctors of arity 0
expr --> ver, expr_rest(end).
expr --> ver, expr_rest(and).
expr --> ver, expr_rest(or).

expr --> fal, expr_rest(end).
expr --> fal, expr_rest(and).
expr --> fal, expr_rest(or).

%%%% junctors of arity 1
expr --> neg, expr, expr_rest(end).
expr --> neg, expr, expr_rest(and).
expr --> neg, expr, expr_rest(or).

%%%%% parentheses
expr --> l_par, expr, r_par, expr_rest(end).
expr --> l_par, expr, r_par, expr_rest(and).
expr --> l_par, expr, r_par, expr_rest(or).

%%% junctors of arity 2
expr_rest(end) --> [].
expr_rest(and) --> and, expr, expr_rest(_).
expr_rest(or) --> or, expr, expr_rest(_).

%%% alphabet
v --> [X].

ver --> ['T'].
fal --> ['F'].

neg --> ['~'].

and --> ['&&'].
or --> ['||'].

l_par --> ['('].
r_par --> [')'].




