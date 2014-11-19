:- use_module(substitution).


:- begin_tests(substitution).

test(substitution_1) :-
    substitution(var(x1),'T',var(x1),'T').

:- end_tests(substitution).
