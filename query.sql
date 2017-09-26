select * from actor 
where actor_id in (1,5,7,9,45) 
order by actor_id;

select * from film;

select * from film_actor;

select a.*, fa.film_id, f.title, f.description
from actor a
left join film_actor fa
on a.actor_id=fa.actor_id
left join film f
on fa.film_id=f.film_id;