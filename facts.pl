nationality(ola, norway).
nationality(eyvind, norway).
nationality(raji, india).
nationality(rajesh, india).
likes(Name, Dish) :- nationality(Name,norway), italian(Dish).
likes(Name, Dish) :- nationality(Name,norway), indian(Dish), mild(Dish).
likes(Name, Dish) :- nationality(Name,india), indian(Dish).