SELECT * FROM country WHERE country_id >= 12 AND country_id <= 17 ORDER BY country_id ASC;
SELECT * FROM address WHERE city_id IN (SELECT city_id FROM city WHERE UPPER(city.city) LIKE 'A%';
SELECT first_name, last_name, city FROM customer 
	INNER JOIN address ON address.address_id = customer.address_id
	INNER JOIN city ON city.city_id = address.city_id;
SELECT * FROM customer WHERE customer_id IN (SELECT customer_id FROM payment WHERE amount > 11);
SELECT first_name FROM customer GROUP BY first_name HAVING COUNT(first_name) > 1;
	
CREATE VIEW location AS
	SELECT address, city, country FROM address 
	INNER JOIN city ON address.city_id = city.city_id
	INNER JOIN country ON country.country_id = city.country_id;
SELECT * FROM location;

CREATE VIEW film_A AS
	SELECT * FROM film 
	WHERE UPPER(film.title) LIKE 'A%';
SELECT * FROM film_A;

CREATE OR REPLACE FUNCTION public.paymant_rub()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
$$
BEGIN
	NEW.payment_rub = NEW.payment * 75;

	RETURN NEW;
END;
$$

CREATE TRIGGER in_rub
	BEFORE INSERT
	ON public.payment
	FOR EACH ROW 
	EXECUTE PROCEDURE paymant_rub();
