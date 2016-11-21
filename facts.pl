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


































/*
Weekly exercises for INF3110
       	                     Prolog I

							 swipl -s "file"
							 consult("file").

Exercise 1
----------
Represent the following statements in Prolog:

1. Ivar studies Informatics 
2. The population of Norway is 4,5 million 
3. Norway is a rich country 
4. 2 is a prime number 
5. Someone wrote Hamlet 
6. All humans are mortal 
7. All rich people pay taxes 
8. Ivar takes his umbrella if it rains 
9. Firebrigade employees are men over six feet tall.


1. studies(ivar, informatics).
2. population(norway, 4500000).
3. rich(norway).
4. prime(2).
5. author(hamlet, someone).
6. mortal(X) :- human(X).
7. paytax(X) :- rich(X), human(X).
8. takes_umbrella(ivar) :- rains.
9. man(X) :- firebrigade(X).
9.1. taller_than_six_feet(X) :- firebrigade(X).




Exercise 2
----------
 
Given the following facts: 
*/
biography(bashir,saddams_fortrolige,2004). 
biography(moen,jensStoltenberg,2002). 
biography(halvorsen,rett_fra_hjertet,2004). 
biography(isaksen, dronningen_vi_ikke_fikk,2003). 
biography(hasted,eminem,2003). 
biography(næss,munch,2004). 
biography(willoch,utfordringer,2004). 
/*
Make a question where the answer is the author and title 
of biographies published in 2003. 

biography(Author, Title, 2003).
*/

   

/*
Exercise 3
----------

Define a relation "likes", so that ola likes both Italian and mild Indian food.
 
These are Italian dishes: pizza, spaghetti. 

These are Indian dishes: tandoori, curry, tikkaMasala. Of these, 
curry and tikkaMasala are hot, while tandoori is mild. 
-----
*/
italian(pizza).
italian(spaghetti).

indian(tandoori).
indian(curry).
indian(tikkaMasala).

mild(tandoori).
spicy(curry).
spicy(tikkaMasala).
/*
likes(ola, X) :- mild(X), indian(X).
likes(ola, X) :- italian(X).
*/
/*
Exercise 4 
----------

Extend the above with nationality, so that Norwegians (as ola) like 
Italian food and mild Indian food, while Indians like both mild and hot 
Indian dishes, but not Italian food. 
*/
nationality(ola, norwegian).
nationality(eyvind, norwegian).
nationality(volker, indian).

likes(Person, Food) :- italian(Food), nationality(Person, norwegian).
likes(Person, Food) :- indian(Food), mild(Food), nationality(Person, norwegian).
likes(Person, Food) :- indian(Food), nationality(Person, indian).


/*
Exercise 5 
----------

Define the fact that each of sun, sirius and vega is a star. Define the fact "orbits", so that each of mercury, venus, earth, and mars orbits the sun, while moon orbits earth and deimos orbits mars.
*/
orbits(mercury, sun). 
orbits(venus, sun).
orbits(earth, sun). 
orbits(mars, sun). 
orbits(moon, earth). 
orbits(deimos, mars). 
/*
Given this, define the relation "planet(B)" as those Bs that are 
orbiting the sun.
*/
planet(X) :- orbits(X, sun).
/*
Define the relation "satellite(B)" giving those that orbits a planet.
*/
satellite(X) :- orbits(X,Y), planet(Y).
/*
Define the solar system "solar" to be either the sun, a planet or a satellite.
*/
solar(sun).
solar(X) :- planet(X).
solar(X) :- satellite(X).
/*
Exercise 6 
----------

The relation tel(county,person,number) expresses that a "person"
(represented by name) in a given "county" has a certain telephone "number". 

1. Make a question that ask for the telephone number of ole_brumm 
in hundre_meter_skogen 
2. Make a question that gives all counties and all persons with the number 123 
3. Make rules so that local(N1,N2) expresses that N1 and N2 are numbers
within the same county 
4. Make a question (with rules) to test that there is not two different 
persons (either in different counties or with different names) with the 
same number. 

tel(hundre_meter_skogen, ole_brumm, Nr).
tel(X, Y, 123).
local(N1, N2) :- tel(X, Y1, N1), tel(X, Y2, N2), N1 \== N2.
*/
same() :- tel(Y1, X, N), tel(Y2, X, N), Y1 \== Y2.
same() :- tel(X, Y1, N), tel(X, Y2, N), Y1 \== Y2.
   
/*
Exercise 7 
----------

Santa has outsourced the reindeer traveling. Reindeer Line Inc. has decided not to travel from the North Pole to any major city, but has set up some pre-scheduled lines. Here are some of them. 
*/
reindeerLine(northpole,oslo). 
reindeerLine(oslo,london). 
reindeerLine(oslo,copenhagen). 
reindeerLine(copehagen,berlin). 
reindeerLine(northpole,stockholm). 
reindeerLine(stockholm,moscow). 
/*
a) As part of the deal, Santa has got a SWI-prolog and a two-hours introduction to Prolog. So, instead of calling Reindeer Line Inc. in order to find out if there is a connection between north pole and a given city, Santa just has to make a Prolog rule that tells if this is the case. Can you help him? 
*/
connection(X, Y) :- reindeerLine(X,Y).
connection(X, Y) :- reindeerLine(X, Z), connection(Z, Y).
santa(X) :- connection(northpole, X).
/*
b) If Santa wants to know if there is just one stop between the north pole
and a city, what kind of question should be asked?

reindeerLine(northpole, X), reindeerLine(X, moscow).
*/

/*
Exercise 8
----------

Natural numbers may be defined as follows in Prolog:

natural_number(0).
natural_number(s(X)) :- natural_number(X).

The first fact asserts that "0" is a natural number while the second one says that if X is a natural number, then the s(X) is also a natural number.

a) Define an operation "plus(X,Y,Z)" where the first two arguments are two natural numbers to be added and the result is given in the third argument.
*/
plus(X, Y, Z) :- Z is X+Y.
/*
b) Define an operation "mult(X,Y,Z)" which makes the product of the first two arguments giving the result in the third.
*/
mult(X, Y, Z) :- Z is X*Y.


