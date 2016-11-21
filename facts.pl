reindeerLine(northpole,oslo). 
reindeerLine(oslo,london). 
reindeerLine(oslo,copenhagen). 
reindeerLine(copenhagen,berlin). 
reindeerLine(northpole,stockholm). 
reindeerLine(stockholm,moscow).
reindeerLine(helsinki,moscow).





line(X,Y) :- reindeerLine(X,Y).
line(X,Y) :- reindeerLine(X,Z), line(Z,Y).





