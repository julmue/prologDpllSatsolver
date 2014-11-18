:- module(parser_internal,[ rec_expr/1,
                            parse_expr/2,
                            expr/3,
                            expr_rest/4,
                            v/3,
                            ver/3,
                            fal/3,
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
rec_expr(Expr) :-
    expr(_,Expr,[]).

parse_expr(ParseTree,Expr) :-
    expr(ParseTree,Expr,[]).

%%% production rules
%
%%%% logical variables
expr(v(X))          --> v(X), expr_rest(end,_).
expr(and(v(X),Y))   --> v(X), expr_rest(and,Y).
expr(or(v(X),Y))    --> v(X), expr_rest(or,Y).

%%%% junctors of arity 0
expr(ver(X))        --> ver(X), expr_rest(end,_).
expr(and(ver(X),Y)) --> ver(X), expr_rest(and).
expr(or(ver(X),Y))  --> ver(X), expr_rest(or).

expr(fal(X))        --> fal(X), expr_rest(end,_).
expr(and(fal(X),Y)) --> fal(X), expr_rest(and,Y).
expr(or(fal(X),Y))  --> fal(X), expr_rest(or,Y).

%%%% junctors of arity 1
expr(neg(X))        --> neg, expr(X), expr_rest(end,_).
expr(and(neg(X),Y)) --> neg, expr(X), expr_rest(and,Y).
expr(or(neg(X),Y))  --> neg, expr(X), expr_rest(or,Y).

%%%%% parentheses
expr(X)             --> l_par, expr(X), r_par, expr_rest(end,_).
expr(and(X,Y))      --> l_par, expr(X), r_par, expr_rest(and,Y).
expr(or(X,Y))       --> l_par, expr(X), r_par, expr_rest(or,Y).

%%% junctors of arity 2
expr_rest(end,[])      --> [].
expr_rest(and,Y)      --> and, expr(Y), expr_rest(_,_).
expr_rest(or,Y)       --> or, expr(Y), expr_rest(_,_).

%%% alphabet
v(X) --> [X].

ver(['T']) --> ['T'].
fal(['F']) --> ['F'].

neg --> ['~'].

and --> ['&&'].
or --> ['||'].

l_par --> ['('].
r_par --> [')'].




