star(sun).
star(sirius).
star(vega).
orbits(mercury, sun). 
orbits(venus, sun).
orbits(earth, sun). 
orbits(mars, sun). 
orbits(moon, earth).
orbits(deimos, mars).

planet(B) :- orbits(B,sun).
satellite(B) :- orbits(B,P), planet(P).
solar(B) :- sun.
solar(B) :- planet(B). 
solar(B) :- satellite(B).