General
-------

Syntax & Semantics:
- If every sentence in a PL can be derived by one and only one
parse tree, then the grammar is **unambiguous**. In the case
that the grammar is **ambiguous**, we use common precedence to
decide which parse tree is the correct one.
- One can describe a PL syntax using eBNF grammar, an automata 
(state machine), or a syntax diagram (jernbanediagram).

A type is identified by:
- Its name (e.g. Person, int, float). This is *nominal* type
checking => 2 types are the same if their names are the same.
- Its structure/signatures. This is *structural* type checking =>
2 types are the same if they are nominally compatible or if 
their signatures (e.g. functions, variables, names) are the same.

A type checker is:
- **Sound** if no programs with errors are considered to be correct. '
- **Conservative** if some programs (which produce *no* error
when running) are still cosnidered to be incorrect.
=> Most type checkers are both sound and conservative.

OOP
---

Four properties of OOP:

1. Dynamic lookup: When a message is sent to an object, the
object chooses how to respond to a message based on the way
the object is implemented (not based on some static property
of the pointer or variable used to name the boject).

2. Abstraction: Implementation details are hidden inside a
program unit with a specific interface. The interface consists
of hidden data as well as public methods that manipulate these data.

3. Subtyping: If object A has all functionality of object B,
we may use A in any context that expects B.

4. Inheritence: Ability to reuse the definite of one kind of
object to define another kind of object.




(* Defining an abstract datatype for complex numbers: *)
abstype cmplx = C of real * real with
	fun cmplx(x,y: real) = C(x,y)
	fun x coord(C(x,y)) = x
	fun y coord(C(x,y)) = y
	fun add(C(x1, y1), C(x2, y2)) = C(x1+x2, y1+y2)
end

(* General structure to declare an abstract type in SML:
abstype <name> = <constructor> of <type> with
	val <pattern> = <body>
	...
	fun f(<pattern>) = <body>
	...
end *)








SML
---





```sml
(* Miscellaneous *)
fun equiv(x,y) = (x andalso y) orelse ((not x) andalso (not y));
val cell = ref 50;
cell := !cell * 2;
fn x => x*2; (* annonymous with no names*)
fun double x = it x;
val name : string = "John";
val (x,y) = (0,1);
fun convert x = case x of 0 => SOME(false) | 1 => SOME(true) | _ => NONE;
```




================== Type Checking:
- ML is STRONGLY-typed
- Members of a LIST must be of the SAME type.
- Division: ´div´ to divide integers, and ´/´ to divide reals.
- Type unit:() is like ´void´ in Java => indicate an "empty" type (ie. use for side 
effects such as the ´print´ function)
- Conversion from int to real is done by the function ´real(x)´
- Conversion from real to int is be done by functions ´floor´ (round down to a LOWER
num), ´ceil´ (round up to a HIGHER num), ´round´ (normal rounding), ´trunc´ (take
away the decimal part).





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