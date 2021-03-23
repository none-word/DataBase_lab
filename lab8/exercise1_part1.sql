CREATE TABLE accounts (
	id serial,
	name varchar(50),
	credit float,
	PRIMARY KEY (id)
);

INSERT INTO accounts (name, credit) VALUES ('Grisha', 1000);
INSERT INTO accounts (name, credit) VALUES ('Regina', 1000);
INSERT INTO accounts (name, credit) VALUES ('Evgeniy', 1000);

SELECT * FROM accounts;

BEGIN;
SAVEPOINT without_transactions;
UPDATE accounts SET credit = credit - 500.00
    WHERE name = 'Grisha';
SAVEPOINT money_has_been_sent_from_Grisha_500;
UPDATE accounts SET credit = credit + 500.00
    WHERE name = 'Evgeniy';
SAVEPOINT money_has_been_got_by_Evgeniy_500;

UPDATE accounts SET credit = credit - 700.00
    WHERE name = 'Regina';
SAVEPOINT money_has_been_sent_from_Regina_700;
UPDATE accounts SET credit = credit + 700.00
    WHERE name = 'Grisha';
SAVEPOINT money_has_been_got_by_Grisha_700;

UPDATE accounts SET credit = credit - 100.00
    WHERE name = 'Regina';
SAVEPOINT money_has_been_sent_from_Regina_100;
UPDATE accounts SET credit = credit + 100.00
    WHERE name = 'Evgeniy';
SAVEPOINT money_has_been_got_by_Evgeniy_100;

SELECT * FROM accounts;

ROLLBACK TO money_has_been_got_by_Evgeniy_100;
              
SELECT * FROM accounts;

ROLLBACK TO money_has_been_got_by_Grisha_700;
              
SELECT * FROM accounts;

ROLLBACK TO money_has_been_got_by_Evgeniy_500;
              
SELECT * FROM accounts;

ROLLBACK TO without_transactions;
              
SELECT * FROM accounts;
COMMIT;

SELECT * FROM accounts;