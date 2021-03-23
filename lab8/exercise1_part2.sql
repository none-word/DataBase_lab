SELECT * FROM accounts;

ALTER TABLE accounts ADD COLUMN bank_name varchar(50);

SELECT * FROM accounts;

UPDATE accounts SET bank_name = 'SpearBank'
    WHERE name = 'Grisha';
UPDATE accounts SET bank_name = 'Tinkoff'
    WHERE name = 'Regina';
UPDATE accounts SET bank_name = 'SpearBank'
    WHERE name = 'Evgeniy';
	
SELECT * FROM accounts;

INSERT INTO accounts (name, credit, bank_name) VALUES ('Fee', 0, 'Bank');

SELECT * FROM accounts;

BEGIN;
SAVEPOINT without_transactions;
UPDATE accounts SET credit = credit - 500.00
    WHERE name = 'Grisha';
UPDATE accounts SET credit = credit + 500.00
    WHERE name = 'Evgeniy';
SAVEPOINT money_has_been_got_by_Evgeniy_500;

UPDATE accounts SET credit = credit - 730.00
    WHERE name = 'Regina';
UPDATE accounts SET credit = credit + 700.00
    WHERE name = 'Grisha';
UPDATE accounts SET credit = credit + 30.00
    WHERE name = 'Fee';
SAVEPOINT money_has_been_got_by_Grisha_700;

UPDATE accounts SET credit = credit - 130.00
    WHERE name = 'Regina';
UPDATE accounts SET credit = credit + 100.00
    WHERE name = 'Evgeniy';
UPDATE accounts SET credit = credit + 30.00
    WHERE name = 'Fee';
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