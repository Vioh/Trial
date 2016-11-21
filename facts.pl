%% Runtime weakness of Prolog (can be fixed by "cut")
%% Suppose that X and Y have the same parents A and B.
%% Calling rsibling(X,Y) gives 2 results that are exactly the same.
%% This is because the 2 results are on different branches of search tree,
%% and PROLOG doesn't memorize any results that it has found.
%% So: in the 1st branch, we have A=Parent1 and B=Parent2,
%% and in the 2nd branch, we have A=Parent2 and B=Parent1.
%% Concrete example: rsibling(anne,X)

% Facts/Predicates-------------
% person(name, mom, dad, birth)
person(anne, sofia, martin, 1960).
person(john, sofia, george, 1965).
person(paul, sofia, martin, 1962).
person(maria, anne, mike, 1989).

% Rules
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

%% Usage1 (Append a list): 
%%  |?- myAppend([1,2,3], [4,5], Result).
%%  -->   myAppend([1|[2,3]], [4,5], [1,_]).
%%  -->     myAppend([2|[3]], [4,5], [2,_]).
%%  -->       myAppend([3|[]], [4,5], [3,_]).
%%  -->         myAppend([], [4,5], [4,5]).
%%  -->       myAppend([3|[]], [4,5], [3,4,5]). True
%%  -->     myAppend([2|[3]], [4,5], [2,3,4,5]). True
%%  -->   myAppend([1|[2,3]], [4,5], [1,2,3,4,5]). True
%%  --> Result = [1,2,3,4,5]
%% Usage2 (Split a list):
%%  |?- myAppend(Xs, Ys, [1,2,3,4,5]).
%%  --> Xs = []
%%      Ys = [1,2,3,4,5] ? ;
%%  --> Xs = [1]
%%      Ys = [2,3,4,5] ? ;
%%  --> Xs = [1,2]
%%      Ys = [3,4,5] ? ;
%%  --> Xs = [1,2,3]
%%      Ys = [4,5] ? ;
%%  --> Xs = [1,2,3,4]
%%      Ys = [5] ? ;
%%  --> Xs = [1,2,3,4,5]
%%      Ys = [] ? ;
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

%% Usage1: len([1,2], Res).
%% Usage2: len(X,2).
%% {{ Case2: X/[_|Xs], N/2 }}
%% len(X,2).
%%     len(Xs,M).
%%         {{ Case1: Xs/[], M/0 }}
%%         N is M+1.
%%             --> Fail! {{ (N=2) != (M+1=0+1=1) }}
%%         {{ Case2: Xs/[_|Xs1]}}
%%         N is M+1.
%%             len(Xs1,M1).
%%                 {{ Case1: Xs1/[], M1/0 }}
%%                 M is M1+1.
%%                     --> Succeed! (See below)
%% *Succeed* because:
%% {{ (N=2) = (M+1=M1+1+1=0+1+1=2) }}
%% {{ Xs1/[], Xs/([_|Xs1]=[_|[]]=[_]), X/([_|Xs]=[_|[_]]=[_,_])}}
len([],0).        %Case1
len([_|Xs],N) :-  %Case2
    len(Xs,N1), 
    N is N1+1.