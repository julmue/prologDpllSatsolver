:- module(sat_internal,[    vars_in_parsetree/2,
                            vars_in_parsetreelist/2
                        ]).

:- use_module(parser_internal).
:- use_module(simplification).
:- use_module(substitution).

/*

algorithm DPLL
  input: a set of clauses Φ.
  output: a Truth Value.

function DPLL(Φ)
   if Φ is a consistent set of literals
       then return true;
   if Φ contains an empty clause
       then return false;
   for every unit clause l in Φ
      Φ ← unit-propagate(l, Φ);
   for every literal l that occurs pure in Φ
      Φ ← pure-literal-assign(l, Φ);
   l ← choose-literal(Φ);
   return DPLL(Φ ∧ l) or DPLL(Φ ∧ not(l));

*/


vars_in_parsetree(Vars,v(X)) :-
    Vars = [v(X)], !.
vars_in_parsetree(Vars,ParseTree) :-
    ParseTree =.. [ Functor | Args ],
    dif(Functor,v),
    vars_in_parsetreelist(IVars,Args),
    list_to_set(IVars,Vars).


vars_in_parsetreelist([],[]) :- !.
vars_in_parsetreelist(Vars,[ParseTree1 | Rem ]) :-
    !,
    vars_in_parsetree(Vars1,ParseTree1),
    vars_in_parsetreelist(VarsRem, Rem),
    flatten([Vars1 | VarsRem], IVars),
    list_to_set(IVars,Vars).

