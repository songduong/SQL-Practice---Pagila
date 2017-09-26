#1a. A list of all the actors' first name and last name

select first_name, last_name from actor;

#1b. Display the first and last name of each actor in a single column in upper case letters. Name the column 'Actor Name'.

select concat(first_name, ' ', last_name) "Actor Name" 
from actor;

#2a. Find the id, first name, and last name of an actor, of whom the first name is only known as 'Joe.' What is one query would you use to obtain this information?

select actor_id, first_name, last_name 
from actor
where first_name ilike 'joe';

#2b.Find all actors whose last name contain the letters GEN. Make this case insensitive.

select actor_id, first_name, last_name 
from actor
where last_name ilike '%GEN%';

#2c. Find all actors whose last names contain the letters LI. This time, order the row by last anem and first name, in that order. Make this case insensitive.

select actor_id, first_name, last_name 
from actor
where last_name ilike '%LI%'
order by last_name, first_name;

#2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China.

select country_id, country from country
where country in ('Afghanistan', 'Bangladesh', 'China')

#3a. Add a middle_name column to the table actor. Specify the appropriate column type.

alter table actor add column middle_name varchar (45);

#3b. Change the data type of the middle_name column to something that can hold more than varchar.

alter table actor alter column middle_name type text;

#3c. Now write a query that would remove the middle_name column.

alter table actor drop column middle_name;

#4a. List the last names of actors, as well as how many actors have that last name.

select last_name, count(*) from actor
group by last_name;

#4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors 

select last_name, count(*) from actor
group by last_name
having count(*) > 1

#4c. Change GROUCHO WILLIAMS's first name to HARPO
update actor set first_name = 'HARPO'
where first_name = 'GROUCHO' and last_name = 'WILLIAMS'

#4d. In a single query,
	#if the first name of the actor is currently HARPO, change it to GROUCHO.
	
	#Otherwise, change the first name to MUCHO GROUCHO, as that is exactly what the actor will be with the grievous error.

	#Be careful not to change the first name of every actor to MUCHO GROUCHO (like I did). Update the record using a unique identifier.

update actor set first_name = (
case when first_name = 'HARPO' then 'GROUCHO'
else 'MUCHO GROUCHO' end) 
where actor_id = 172

#5a.

#What is the difference between a left join and a right join?
Left join grabs everything from the left table and the corresponding records from the right table. And vice versa.

#What about an inner join and an outer join?
Inner join only grabs what two tables have in common. Outer join grabs either everything from the left table or the right table, depending on whether it is a left join or a right join.

#When would you use rank? What about dense_rank?
We can use rank when we want to see how each row rank amongst the other rows. Ties or grouped rows within a partition are assigned the same rank, with the next ranks skipped until a new group. Dense_rank is similar to rank, but the ranks assigned are consecutive.

#When would you use a subquery in a select?
Use subquery in a select for when you only want the query to return rows or values that meet multiple conditions.

#When would you use a right join?
Use a right join when you’ve done many left joins, and you’d like to start matching eveything in the right table with the left table.

#When would you use an inner join over an outer join?
Inner join returns only what two items have in common. So if that’s what you’re looking for, use inner join.

#What is the difference between a left outer and a left join?
There is no difference between a left outer join and a left join.

#When would you use a group by?
Use group by when you want an aggregate of of each group.

#Describe how you would do data reformatting?
One example I can think of for data reformatting is concatenation, where you can join two values from two cells together.

#When would you use a with clause?
Using a WITH clause you can assign your subquery a name to refer to within the main query.

#When would you use a self join?
Use self join when you want to compare values within the same table.


#6a. Use a JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:

select s.first_name, s.last_name, a.address, a.address2, a.district, a.city_id, a.postal_code
from staff s
left join address a
on a.address_id = s.address_id


#6b. Use a JOIN to display the total amount rung up by each staff member in January of 2007. Use tables staff and payment.

select s.staff_id, s.first_name, s.last_name, count(p.payment_id) 
from staff s
left join payment p
on s.staff_id = p.staff_id
where extract(year from payment_date) = 2007
and extract(month from payment_date) = 1
group by s.staff_id

#6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.

select f.title, count(fa.actor_id) 
from film_actor fa
left join film f
on fa.film_id = f.film_id
group by f.title


#6d. How many copies of the film HUNCHBACK IMPOSSIBLE exist in the inventory system?

select count(*) 
from film f left join inventory i
on f.film_id = i.film_id
group by f.film_id
having f.film_id = 439

#6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:

select c.customer_id, c.first_name, c.last_name, sum(p.amount)
from customer c
left join payment p
on c.customer_id = p.customer_id
group by c.customer_id
order by c.last_name

#7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Display the titles of movies starting with the letters K and Q whose language is English.

select f.title 
from film f
left join language l
on f.language_id = l.language_id
where f.title ilike 'K%' or f.title ilike 'Q%'
and l.name = 'English'

#7b. Use subqueries to display all actors who appear in the film Alone Trip.

select fafa.first_name, fafa.last_name from 
(select f.title, fa.actor_id, a.first_name, a.last_name
from film_actor fa
left join actor a
on fa.actor_id = a.actor_id
left join film f
on fa.film_id = f.film_id) fafa
where fafa.title = 'ALONE TRIP'

#7c. Use joins to retrieve the names and email addresses of all Canadian customers.

select cu.first_name, cu.last_name, cu.email 
from customer cu
left join address ad
on cu.address_id = ad.address_id
left join city ci
on ad.city_id = ci.city_id
left join country co
on co.country_id = ci.country_id
where co.country = 'Canada'

#7d. Identify all movies categorised as a family film.

select f.title
from film f
left join film_category fc
on f.film_id = fc.film_id
left join category c
on fc.category_id = c.category_id
where c.name = 'Family'


#7e. Display the most frequently rented movies in descending order.

select f.title, count(r.rental_id)
from film f
left join inventory i
on f.film_id = i.film_id
left join rental r
on i.inventory_id = r.inventory_id
group by f.title


#7f. Write a query to display how much business, in dollars, each store brought in. 

select st.store_id, sum(p.amount) from payment p
left join staff s
on p.staff_id = s.staff_id
left join store st
on st.store_id = s.store_id
group by st.store_id


#7g. Write a query to display for each store its store ID, city, and country.

select st.store_id, ci.city, co.country
from store st
left join address ad
on st.address_id = ad.address_id
left join city ci
on ci.city_id = ad.address_id
left join country co
on co.country_id = ci.country_id

#7h. List the top five genres in gross revenue in descending order.

select c.name, sum(p.amount) from payment p
left join rental r
on p.rental_id = r.rental_id
left join inventory i
on r.inventory_id = i.inventory_id
left join film f
on f.film_id = i.film_id
left join film_category fc
on f.film_id = fc.film_id
left join category c
on c.category_id = fc.category_id
group by c.name
order by sum(p.amount) desc
limit 5


#8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. 

create or replace view top_5_category as
select c.name, sum(p.amount) from payment p
left join rental r
on p.rental_id = r.rental_id
left join inventory i
on r.inventory_id = i.inventory_id
left join film f
on f.film_id = i.film_id
left join film_category fc
on f.film_id = fc.film_id
left join category c
on c.category_id = fc.category_id
group by c.name
order by sum(p.amount) desc
limit 5


#8b. Display the view that you created in 8a.

select * from top_5_category

#8c. Delete the view you created in 8a.

drop view top_5_category






