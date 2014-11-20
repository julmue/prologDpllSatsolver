main:

test:
	swipl -g "run_tests,halt" parser_internal_tests.pl
	swipl -g "run_tests,halt" simplification_tests.pl
	swipl -g "run_tests,halt" substitution_tests.pl
	swipl -g "run_tests,halt" sat_tests.pl
