CREATE TABLE char_data_types (
    varchar_column varchar(10),
    char_column char(10),
    text_column text
);

INSERT INTO char_data_types
VALUES
    ('abc', 'abc', 'abc'),
    ('defghi', 'defghi', 'defghi');

COPY char_data_types TO 'C:\Bootcamp2025\SQL\sql\Chapter 3\typetest.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');

INSERT INTO char_data_types
VALUES 
	('12345678', '123456', 'this is text 2')

CREATE TABLE people (
 id serial,
 person_name varchar(100)
);

INSERT INTO people (id, person_name)
VALUES (1234567890, 'Pierre Kahunda');

CREATE TABLE date_time_types (
    timestamp_column timestamp with time zone,
    interval_column interval
);

INSERT INTO date_time_types
VALUES
    ('2018-12-31 01:00 EST','2 days'),
    ('2018-12-31 01:00 PST','1 month'),
    ('2018-12-31 01:00 Australia/Melbourne','1 century'),
    (now(),'1 week');