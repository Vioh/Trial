italian(pizza).
italian(spaghetti).
indian(tandoori).
indian(curry).
indian(tikkaMasala).
hot(tikkaMasala).
mild(tandoori). 

likes(ola, Dish) :- italian(Dish).
likes(ola, Dish) :- indian(Dish), mild(Dish).
