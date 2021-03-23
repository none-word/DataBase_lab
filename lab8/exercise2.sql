CREATE TABLE ledger (
	id serial NOT NULL,
	from_id int NOT NULL,
	to_id int NOT NULL,
	fee float NOT NULL,
	amount float NOT NULL,
	transaction_date_time timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM ledger;
SELECT * FROM accounts;

BEGIN;
SAVEPOINT without_transactions;
UPDATE accounts SET credit = credit - 500.00
    WHERE name = 'Grisha';
UPDATE accounts SET credit = credit + 500.00
    WHERE name = 'Evgeniy';
INSERT INTO ledger (from_id, to_id, fee, amount)
	VALUES (
		(SELECT id FROM accounts WHERE name = 'Grisha'),
		(SELECT id FROM accounts WHERE name = 'Evgeniy'),
		0,
		500
	);
SAVEPOINT money_has_been_got_by_Evgeniy_500;

SELECT * FROM ledger;

UPDATE accounts SET credit = credit - 730.00
    WHERE name = 'Regina';
UPDATE accounts SET credit = credit + 700.00
    WHERE name = 'Grisha';
UPDATE accounts SET credit = credit + 30.00
    WHERE name = 'Fee';
INSERT INTO ledger (from_id, to_id, fee, amount)
	VALUES (
		(SELECT id FROM accounts WHERE name = 'Regina'),
		(SELECT id FROM accounts WHERE name = 'Grisha'),
		30,
		700
	);
SAVEPOINT money_has_been_got_by_Grisha_700;

SELECT * FROM ledger;

UPDATE accounts SET credit = credit - 130.00
    WHERE name = 'Regina';
UPDATE accounts SET credit = credit + 100.00
    WHERE name = 'Evgeniy';
UPDATE accounts SET credit = credit + 30.00
    WHERE name = 'Fee';
INSERT INTO ledger (from_id, to_id, fee, amount)
	VALUES (
		(SELECT id FROM accounts WHERE name = 'Regina'),
		(SELECT id FROM accounts WHERE name = 'Evgeniy'),
		30,
		100
	);
SAVEPOINT money_has_been_got_by_Evgeniy_100;

SELECT * FROM accounts;
SELECT * FROM ledger;

ROLLBACK TO money_has_been_got_by_Evgeniy_100;
              
SELECT * FROM accounts;
SELECT * FROM ledger;

ROLLBACK TO money_has_been_got_by_Grisha_700;
              
SELECT * FROM accounts;
SELECT * FROM ledger;

ROLLBACK TO money_has_been_got_by_Evgeniy_500;
              
SELECT * FROM accounts;
SELECT * FROM ledger;

ROLLBACK TO without_transactions;
              
SELECT * FROM accounts;
SELECT * FROM ledger;
COMMIT;

SELECT * FROM accounts;
SELECT * FROM ledger;