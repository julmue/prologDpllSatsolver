:- use_module(parser_internal).



:- begin_tests(alphabet).

test(var_1) :-
    v(['x'],[]).


:- end_tests(alphabet).


:- begin_tests(expr_rest).

test(expr_rest_1) :-
    expr_rest(end,[],[]).

test(expr_rest_2) :-
    expr_rest(and,['&&','v'],[]).

test(expr_rest_3) :-
    expr_rest(or,['||','v'],[]).

:- end_tests(expr_rest).



:- begin_tests(expr).

test(expr_1) :-
    expr(['x'],[]).

test(expr_2) :-
    expr(['~','x'],[]).

test(expr_3) :-
    expr(['x','&&','x'],[]).

test(expr_4) :-
    expr(['x','||','x'],[]).

test(expr_5) :-
    expr(['(','x',')'],[]).

test(expr_6) :-
    expr(['(','x',')','&&','x'],[]).

:- end_tests(expr).

/*
:- begin_tests(recogniser).

test(recogniser_var_1) :-
    rec_expr(_,['x'],[]).

test(parser_neg_1) :-
    rec_expr(_,['~','x'],[]).

test(parser_and_1) :-
    rec_expr(_,['x','&&','x']).


:- end_tests(recogniser).
*/

/*

test(recogniser_var_2) :-
    expr(v('x'),['x'],[]).

test(parser_neg_2) :-
    expr(neg(v('x')),['~','x'],[]).


*/


