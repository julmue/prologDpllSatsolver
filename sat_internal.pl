:- module(sat_internal,[vars_in_parstree/2]).

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


vars_in_parstree(Vars,ParseTree) :-
    x = x.
