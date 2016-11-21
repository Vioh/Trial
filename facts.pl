p(anne, aase, aale, 1960).
p(arne, aase, aale, 1962).
p(beate, anne, lars, 1989).
p(bjorn, lise, arne, 1990).
p(ginny, ida, hans, 1984).

child(X,Y) :- p(X,_,Y,_).
child(X,Y) :- p(X,Y,_,_).
gc(X,Y) :- child(X,Z), child(Z,Y).

descendant(X,Y) :- child(X,Y).
descendant(X,Y) :- child(X,Z), cd(Z,Y).
cd(X,Y) :- X \== Y, descendant(X,D1), descendant(Y,D2), D1 == D2.
