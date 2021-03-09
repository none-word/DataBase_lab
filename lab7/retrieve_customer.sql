CREATE OR REPLACE FUNCTION retrieve_customers(start_id integer, end_id integer)
RETURNS TABLE
(
    customer_id integer,
    store_id smallint,
    first_name character varying(45),
    last_name character varying(45),
    email character varying(50),
    address_id smallint,
    activebool boolean,
    create_date date,
    last_update timestamp without time zone,
    active integer
)
LANGUAGE plpgsql
AS 
$$
BEGIN
	IF start_id < 0 OR start_id >= 600 THEN
		RAISE EXCEPTION 'incorrect start_id';
	END IF;

	IF end_id < 0 OR end_id >= 600 THEN
		RAISE EXCEPTION 'incorrect end_id';
	END IF;
	
	IF end_id < start_id THEN
		RAISE EXCEPTION 'end_id is less than start_id';
	END IF;

	RETURN QUERY
	SELECT * FROM customer c
	WHERE c.address_id >= start_id AND c.address_id <= end_id
	ORDER BY c.address_id;
END;
$$