EXPLAIN 
SELECT cust.first_name, cust.last_name, title FROM customer cust
CROSS JOIN film
WHERE title IN (
	SELECT title FROM film f
	WHERE EXISTS (SELECT * FROM film_category 
			WHERE film.film_id = film_category.film_id AND
			EXISTS (SELECT * FROM category 
					WHERE film_category.category_id = category.category_id AND
				   	(category.name = 'Horror' OR category.name = 'Sci-Fi'))) AND
	(f.rating = 'R' OR f.rating = 'PG-13')
)
EXCEPT (
	SELECT first_name, last_name, title FROM customer
	JOIN film ON (EXISTS (SELECT customer_id, inventory_id FROM rental 
						  WHERE customer.customer_id = rental.customer_id AND 
						  EXISTS (SELECT inventory_id, film_id FROM inventory
								 WHERE rental.inventory_id = inventory.inventory_id AND
								 inventory.film_id = film.film_id)))
);


CREATE INDEX idx_film_id ON film(film_id);
CREATE INDEX idx_customer_id ON customer(customer_id);
CREATE INDEX idx_category_name ON category(name);
CREATE INDEX idx_inventory_id ON inventory(inventory_id);



EXPLAIN 
SELECT c.city, s.store_id, SUM(amount) sales FROM store s
JOIN city c ON (EXISTS (SELECT * FROM address a 
						WHERE s.address_id = a.address_id AND 
							c.city_id = a.city_id))

JOIN payment p ON (p.payment_date > To_date('01-05-2007','DD-MM-YYYY') AND
				   EXISTS (SELECT * FROM staff WHERE s.store_id = store_id AND 
						   staff_id = p.staff_id))

GROUP BY c.city, s.store_id
ORDER BY sales DESC;

CREATE INDEX idx_city ON city(city);
CREATE INDEX idx_store_id ON staff(store_id);