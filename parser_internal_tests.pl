:- use_module(parser_internal).


:- begin_tests(recogniser).

test(var_1) :-
    rec_expr(['x']).

/*
test(expr_rest_1) :-
    rec_expr(end,[],[]).

test(expr_rest_2) :-
    rec_expr(and,['&&','v'],[]).

test(expr_rest_3) :-
    rec_expr(or,['||','v'],[]).

test(expr_1) :-
    rec_expr(['x'],[]).
*/

test(expr_2) :-
    rec_expr(['~','x']).

test(expr_3) :-
    rec_expr(['x','&&','x']).

test(expr_4) :-
    rec_expr(['x','||','x']).

test(expr_5) :-
    rec_expr(['(','x',')']).

test(expr_6) :-
    rec_expr(['(','x',')','&&','x']).

:- end_tests(recogniser).


/*

test(recogniser_var_2) :-
    expr(v('x'),['x'],[]).

test(parser_neg_2) :-
    expr(neg(v('x')),['~','x'],[]).


*/


