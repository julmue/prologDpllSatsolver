:- use_module(sat_internal).

:- begin_tests(vars_in_parsetree).

test(vars_in_parsetree_1) :-
    vars_in_parsetree(Vars,v(x)),
    member(v(x),Vars),
    length(Vars,1).

test(vars_in_parsetree_2, nondet) :-
    vars_in_parsetree(Vars,and(v(x),v(y))),
    member(v(x),Vars),
    member(v(y),Vars),
    length(Vars,2).
    % attention: seems like lenght leaves choice point if N > 0 ...
    % this has to be fixed: test should finish w/o choicepoints..

test(vars_in_parsetree_3, nondet) :-
    vars_in_parsetree(Vars,and(or(v(x),v(y)),v(z))),
    member(v(x),Vars),
    member(v(y),Vars),
    member(v(z),Vars),
    length(Vars,3).

test(vars_in_parsetree_4) :-
    vars_in_parsetree(Vars,'T'),
    Vars = [].

test(vars_in_parsetree_5) :-
    vars_in_parsetree(Vars,'F'),
    Vars = [].

test(vars_in_parsetree_6) :-
    vars_in_parsetree(Vars,and(v(x),v(x))),
    member(v(x),Vars),
    length(Vars,1).


test(vars_in_parsetreelist_1) :-
    vars_in_parsetreelist(Vars,[v(x)]),
    member(v(x),Vars),
    length(Vars,1).

test(vars_in_parsetreelist_2, nondet) :-
    vars_in_parsetreelist(Vars,[v(x),v(y)]),
    member(v(x),Vars),
    member(v(y),Vars),
    length(Vars,2).

:- end_tests(vars_in_parsetree).


:- begin_tests(dpll).

test(dpll_1) :-
    dpll(['T']).

test(dpll_2,fail) :-
    dpll(['F']).

test(dpll_3,fail) :-
    dpll(['F','&&','T']).

test(dpll_4) :-
    dpll(['F','||','T']).

test(dpll_5) :-
    dpll([v(x)]).

test(dpll_6) :-
    dpll([v(x),'&&','T']).

test(dpll_7,fail) :-
    dpll([v(x),'&&','F']).

test(dpll_8) :-
    dpll([x,'||','F']).

test(dpll_9,fail) :-
    dpll([x,'&&','(','~',x,')']).

test(dpll_10) :-
    dpll([x,'&&',x]).



:- end_tests(dpll).
