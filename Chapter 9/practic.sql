CREATE TABLE jozi (
	aeras varchar(25),
    sites varchar(50)
);

INSERT INTO jozi (aeras, sites)
VALUES ('Sandon', 'Eastgate' )

SELECT * FROM jozi;

ALTER TABLE jozi ADD COLUMN street varchar(100);

UPDATE jozi
SET aeras = 'Sandton'
WHERE aeras = 'Sandon' AND sites = 'Eastgate';
