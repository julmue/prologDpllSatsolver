% ----------------------------------------------------------------------

% grammar

/*
	% logical variables
	l_expression --> l_var

	% junctors of arity 0
	l_expression --> l_verum
	l_expression --> l_falsum

	% junctors of arity 1
	l_expression --> not l_expression
	l_expression --> l_expression and l_expression
	l_expression --> l_expression or l_expression

	% parentheses
	l_expression --> l_left_par l_expression l_right_par

	%% überprüfen: stimmt so die assoziativität?

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
l_expression --> l_var, l_expression_rest.

%%%% junctors of arity 0
l_expression --> l_verum, l_expression_rest.
l_expression --> l_falsum, l_expression_rest.

%%%% junctors of arity 1
l_expression --> l_not, l_expression, l_expression_rest.

%%%%% parentheses
l_expression --> l_left_par, l_expression, l_right_par, l_expression_rest.

%%% junctors of arity 2
l_expression_rest --> [].
l_expression_rest --> l_and, l_expression, l_expression_rest.
l_expression_rest --> l_or, l_expression, l_expression_rest.

%%% alphabet
l_var --> [X].	% wie kann man alle v1, v2, v3 ... erkennen?

l_verum --> ['T'].
l_falsum --> ['F'].

l_not --> ['~'].

l_and --> ['&&'].
l_or --> ['||'].

l_left_par --> ['('].
l_right_par --> [')'].

