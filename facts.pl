boss(anne, eva).
boss(atle, eva).
boss(eva, lars).

ls(1, ole).
ls(2, dole).
ls(3, ole).
rs(1, ole).
rs(2, dole).
rs(3, doffen).
rs(5, dolly).

find(K,V) :- ls(K,V).
find(K,V) :- rs(K,V).
error(K) :- ls(K,V1), rs(K,V2), V1 \== V2.
multi(V) :- ls(K1,V), ls(K2,V), K1 \== K2.
multi(V) :- rs(K1,V), rs(K2,V), K1 \== K2.
multi(V) :- ls(K1,V), rs(K2,V), K1 \== K2.



sup(Sup, Sub) :- boss(Sub, Sup).
sup(Sup, Sub) :- boss(Sub, X), sup(Sup, X).
multBoss(X) :- boss(X, B1), boss(X, B2), B1 \== B2.
ok(X) :- \+sup(X,X), \+multBoss(X).


