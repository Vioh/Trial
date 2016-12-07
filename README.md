General
-------

Syntax & Semantics:
- If every sentence in a PL can be derived by one and only one
parse tree, then the grammar is **unambiguous**. In the case
that the grammar is **ambiguous**, we use common precedence to
decide which parse tree is the correct one.
- One can describe a PL syntax using eBNF grammar, an automata 
(state machine), or a syntax diagram (jernbanediagram).

Two ways to identify a type:
- By its name (e.g. Person, Stack, int, float, etc.) => nominal type checking.
- By its structure (e.g. fields, operations, etc.) => structural type checking.

```sml
(* Miscellaneous *)
val cell = ref 50;
cell := !cell * 2;
fn x => x*2; (* annonymous with no names*)
fun double x = it x;
val name : string = "John";
val (x,y) = (0,1);
fun convert x = case x of 0 => SOME(false) | 1 => SOME(true) | _ => NONE;
```






PROLOG NOTES
============

Principles when programming with PROLOG:
----------------------------------------
(1) FACTS (predicates) are clauses representing basic truths in the world.
(2) RULES are clauses representing rules associated with the facts.
(3) QUERIES are questions to be answered by PROLOG (with the help of clauses).
--> PROLOG works in a closed world (a query is true if it's in the database).
--> There are NO functions in PROLOG, just relations.
	E.g. relation(a,b) may be understood as f(a)=b
--> For recursive case, non-recursive rules first, recursive rules at the end.
--> Arithmetic operations are functional not relational, destroying PROLOG's
	declarative style of programming. This is solved by constraint logic prog.
--> The rule "A :- B" means "if B then A".
--> The unification/assignment to a variable should happen on the LHS of a rule.

PROLOG syntax:
--------------
$$$ Symbol _ can be used to begin an unused variable (e.g: _A, _B, _, _C).
$$$ Symbol \== means not equal.
$$$ Comma represents the logical 'and'.
$$$ Semicolon represents the logical 'or'.
$$$ Variable is a word starting with upper-case letters or with symbol '_'.
$$$ Constants (e.g. "sofia", 1, 1.2) must start with lower-case letters.
$$$ Relations (e.g. isEqualTo, person) must start with lower-case letters.
$$$ Lists are constructed with cons [head | tail]. Equivalent syntax for lists:
	[1,2,3,4,5]
	[1|[2|[3|[4|[5|[]]]]]]
	[1,2|X] --> x = [3,4,5]
	Note that [1,2,X] will NOT unify and will return NO.

PROLOG search tree:
-------------------
$$$ Conjunctions (logical 'and') should grow on the same branch.
$$$ Logical 'or' should be on different branches.

Miscellaneous:
--------------
$$$ Run GNU-Prolog compiler with: gprolog
$$$ [file]. --> import file.pl into the interactive compiler
%% boss(X,Y) --> X is a boss of Y
%% sup(X,Y) --> X is superior to Y
sup(X,Y) :- boss(X,Y).
sup(X,Y) :- boss(X,Z), sup(Z,Y).
multBoss(X) :- boss(B1,X), boss(B2,X), B1 \== B2.
ok(X) :- \+sup(X,X), \+multBoss(X).