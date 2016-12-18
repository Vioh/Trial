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
- Most type checkers are both sound and conservative.

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

There are 2 kinds of overloading of functions/operators:
- Context-independent: overloading is done **only** on the param types.
- Context-dependent: overloading is done on **both** param types and return type.

SML
---

General SML programming:
- SML is **strongly** typed => members of a list must have the same type.
- Division: `div` to divide integers, and `/` to divide reals, and `mod` for modulo of int.
- Type `unit()` is used for side effects (like for print function).
- Conversion from `int` to `real` is done by `real(x)`.
- Conversion from `real` to `int` is done by `floor`, `ceil`, `trunc`, or `round`
- Exceptions should be *dynamically* scoped (in order to trace the call-stack)

Miscellaneous SML syntax:
```sml
fun equiv(x,y) = (x andalso y) orelse ((not x) andalso (not y));
val cell = ref 50;
cell := !cell * 2;
fn x => x*2; (* annonymous with no names*)
fun double x = it x;
val name : string = "John";
val (x,y) = (0,1);
fun convert x = case x of 0 => SOME(false) | 1 => SOME(true) | _ => NONE;
```

Recursions in SML:
```sml
fun fac1 n = (* vanlig rekursjon *)
    if n = 0 then 1 else n*fac1(n-1);
fun fac2 n = (* halerekursjon *)
  let fun iter (n, res) = if n = 0 then res else iter(n-1, n*res)
  in iter (n, 1) end;  
fun len (nil) = 0
|   len (x::xs) = 1 + len xs;
fun rev1 ([]) = [] (* vanlig rekursjon *)
|   rev1 (x::xs) = reverse(xs)@[x];
fun rev2 (lst) =   (* halerkursjon *)
  let fun iter([], ys) = ys
      |   iter(x::xs, ys) = iter(xs, x::ys)
  in iter(lst, []) end;
fun append ([], ys) = ys
|   append (x::xs, ys) = x::append(xs, ys);
fun insert (e, []) = [x]
|   insert (e, x::xs) = if e<x then e::x::xs else x::insert(e,xs);
```

Higher-order functions in SML:
```sml
fun square lst = map (fn x => x*x) lst; (* inbuilt map *)
fun map1 f [] = []
|   map1 f (x::xs) = (f x)::(map1 f xs)
fun filter p [] = []
|   filter p (x::xs) = if (p x) then x::(filter p xs) else filter p xs;
```

Example SML: Rational numbers addition
```sml
type frac = {numer : int, denom : int};
fun add(a : frac, b : frac) = 
	{numer = (#numer(a) * #denom(b) + #numer(b) * #denom(a)),
	 denom = (#denom(a) * #denom(b))};
add({numer=1,denom=2}, {numer=3,denom=4});

Example SML: Given the function `repeat(f,d,l)`, where `d` designates a default
value. If we have a function `fun minus(x,y) = x-y;`, then the following call
`repeat(minus, 0, [1,2,3]);` will compute `(((1-2)-3)-0)`, giving the result -4.
```sml
fun repeat(f,d,l) =
	case l of []         => d
	|         x::[]      => f(x,d)
	|         x::y::rest => repeat(f, d, f(x,y)::rest);
fun minus(x,y) = x-y;
repeat(minus, 0, [1,2,3]);
```

PROLOG
------

Principles when programming with PROLOG:
- FACTS (predicates) are clauses representing basic truths in the world.
- RULES are clauses representing rules associated with the facts.
- QUERIES are questions to be answered by PROLOG (with the help of clauses).
- Conjunctions (logical 'and') should grow on the same branch of the search tree.
- Logical 'or' should be on different branches of the search tree.
- For recursive case, non-recursive rules first, recursive rules at the end.
- The rule "A :- B" means "if B then A".
- The unification/assignment to a variable should happen on the LHS of a rule.

PROLOG syntax:
- Symbol `_` can be used to begin an unused variable (e.g: _A, _B, _, _C).
- Symbol `\==` means not equal.
- Variable is a word starting with uppercase letters or with symbol `_`.
- Constants (e.g. "sofia", 1, 1.2) must start with lowercase letters.
- Relations (e.g. isEqualTo, person) must start with lower-case letters.
- Lists are constructed with `cons [head | tail]`. Equivalent syntax for lists:
```prolog
[1,2,3,4,5]
[1|[2|[3|[4|[5|[]]]]]]
[1,2|X] %% result is X = [3,4,5]
%% Note that [1,2,X] will NOT unify and will return NO.
```	

From Ukesoppgaver:
```prolog
%% cd is common descendent
p(anne, aase, aale, 1960).
p(arne, aase, aale, 1962).
p(beate, anne, lars, 1989).
p(bjorn, lise, arne, 1990).
child(X,Y) :- p(X,_,Y,_).
child(X,Y) :- p(X,Y,_,_).
gc(X,Y) :- child(X,Z), child(Z,Y).
descendant(X,Y) :- child(X,Y).
descendant(X,Y) :- child(X,Z), child(Z,Y).
cd(X,Y) :- descendant(X,D1), descendant(Y,D2), X \== Y, D1 == D2.

%% recursion
connection(X,Y) :- directLine(X,Y).
connection(X,Y) :- directLine(X,Z), connection(Z,Y).

%% addToEnd(List1, Obj, List2) appends Obj to List1 and assign new list to List2
addToEnd([], Obj, [Obj]).
addToEnd([X | L1], Obj, [X | L2) :- addToEnd[L1, Obj, L2].

%% reverse a list
reverse([], []).
reverse([X], [X]).
reverse([X|Xs], Ys) :- reverse(Xs,Zs), addToEnd(Zs,X,Ys).

%% boss(X,Y) --> X is a boss of Y
%% sup(X,Y) --> X is superior to Y
sup(X,Y) :- boss(X,Y).
sup(X,Y) :- boss(X,Z), sup(Z,Y).
multBoss(X) :- boss(B1,X), boss(B2,X), B1 \== B2.
ok(X) :- \+sup(X,X), \+multBoss(X).
```

From the lecture:
```prolog
%% Facts/Predicates
%% person(name, mom, dad, birth)
person(anne, sofia, martin, 1960).
person(john, sofia, george, 1965).
person(paul, sofia, martin, 1962).
person(maria, anne, mike, 1989).

%% Rules
child(X,Y) :- person(X,_,Y,_).
child(X,Y) :- person(X,Y,_A,_B).
sibling(X,Y) :- child(X,Z), child(Y,Z), X \== Y.

%% Real sibling, assuming this never happens:
%! person(bill, molly, arthur, 1970).
%! person(fred, arthur, molly, 1978).
rsibling(X,Y) :- 
    child(X,Parent1),
    child(Y,Parent1),
    X \== Y,
    child(X,Parent2),	
    child(Y,Parent2),
    Parent1 \== Parent2.
    
%% Half sibling, assuming this never happens:
%! person(bill, molly, vioh1, 1970).
%! person(fred, vioh2, molly, 1978).
hsibling(X,Y) :- 
    child(X,Parent),
    child(Y,Parent),
    X \== Y,
    child(X,Parent1),
    child(Y,Parent2),
    Parent \== Parent1,
    Parent \== Parent2,
    Parent1 \== Parent2.

%% Recursive rules
descendant(X,Y) :- child(X,Y).
descendant(X,Y) :- child(X,Z), descendent(Z,Y).

%% Usage: ismember(2, [1,2,3]).
isMember(X,[X|_]).
isMember(X,[_|Rest]) :- isMember(X,Rest).

% Usage1 (Append a list): 
%  |?- myAppend([1,2,3], [4,5], Result).
%  -->   myAppend([1|[2,3]], [4,5], [1,_]).
%  -->     myAppend([2|[3]], [4,5], [2,_]).
%  -->       myAppend([3|[]], [4,5], [3,_]).
%  -->         myAppend([], [4,5], [4,5]).
%  -->       myAppend([3|[]], [4,5], [3,4,5]). True
%  -->     myAppend([2|[3]], [4,5], [2,3,4,5]). True
%  -->   myAppend([1|[2,3]], [4,5], [1,2,3,4,5]). True
%  --> Result = [1,2,3,4,5]
% Usage2 (Split a list):
%  |?- myAppend(Xs, Ys, [1,2,3,4,5]).
%  --> Xs = []
%      Ys = [1,2,3,4,5] ? ;
%  --> Xs = [1]
%      Ys = [2,3,4,5] ? ;
%  --> Xs = [1,2]
%      Ys = [3,4,5] ? ;
%  --> Xs = [1,2,3]
%      Ys = [4,5] ? ;
%  --> Xs = [1,2,3,4]
%      Ys = [5] ? ;
%  --> Xs = [1,2,3,4,5]
%      Ys = [] ? ;
myAppend([],Ys,Ys).
myAppend([X|Xs],Ys,[X|Zs]) :- myAppend(Xs,Ys,Zs).

%% Usage: isSorted([-1,0,1]).
isSorted([]).
isSorted([_]).
isSorted([X,Y|Ys]) :- X =< Y, isSorted([Y|Ys]).

%% Usage: factorial(5,F).
%% Instantiation error (X>0) for this: factorial(X,120).
factorial(0,1).
factorial(N,F) :-
    N>0, N1 is N-1,
    factorial(N1,F1),
    F is N*F1.

%% Usage: revList([1,2,3,4,5])
addToEnd([], Obj, [Obj]).
addToEnd([X | L1], Obj, [X | L2) :-	addToEnd[L1, Obj, L2].
revList([], []).
revList([X], [X]).
revList([X|Xs], Ys) :- revList(Xs,Zs), addToEnd(Zs,X,Ys).
    
% Usage1: len([1,2], Res).
% Usage2: len(X,2).
% {{ Case2: X/[_|Xs], N/2 }}
% len(X,2).
%     len(Xs,M).
%         {{ Case1: Xs/[], M/0 }}
%         N is M+1.
%             --> Fail! {{ (N=2) != (M+1=0+1=1) }}
%         {{ Case2: Xs/[_|Xs1]}}
%         N is M+1.
%             len(Xs1,M1).
%                 {{ Case1: Xs1/[], M1/0 }}
%                 M is M1+1.
%                     --> Succeed! (See below)
% *Succeed* because:
% {{ (N=2) = (M+1=M1+1+1=0+1+1=2) }}
% {{ Xs1/[], Xs/([_|Xs1]=[_|[]]=[_]), X/([_|Xs]=[_|[_]]=[_,_])}}
len([],0).        %Case1
len([_|Xs],N) :-  %Case2
    len(Xs,N1), 
    N is N1+1.
```