:- use_module(sat_internal).

:- begin_tests(vars_in_parsetree).

test(vars_in_parsetree_1) :-
    vars_in_parsetree(var(x),Vars),
    Vars = [var(x)].


:- end_tests(vars_in_parsetree).
