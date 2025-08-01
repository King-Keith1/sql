SELECT * FROM us_counties_2010;

SELECT geo_name,
       state_us_abbreviation,
       p0010001
FROM us_counties_2010;

SELECT geo_name,
       state_us_abbreviation,
       p0010001
FROM us_counties_2010
WHERE p0010001 >= (
    SELECT percentile_cont(.9) WITHIN GROUP (ORDER BY p0010001)
    FROM us_counties_2010
    )
ORDER BY p0010001 DESC;

CREATE TABLE us_counties_2010_top10 AS
SELECT * FROM us_counties_2010;

DELETE FROM us_counties_2010_top10
WHERE p0010001 < (
    SELECT percentile_cont(.9) WITHIN GROUP (ORDER BY p0010001)
    FROM us_counties_2010_top10
    );

ALTER TABLE us_counties_2010
ADD COLUMN us_median numeric;

WITH median_cte AS (
  SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY p0010001) AS median
  FROM us_counties_2010
)
UPDATE us_counties_2010
SET us_median = (SELECT median FROM median_cte);

SELECT * FROM us_counties_2010

CREATE TABLE retirees (
    id int,
    first_name varchar(50),
    last_name varchar(50)
);

INSERT INTO retirees 
VALUES (2, 'Lee', 'Smith'),
       (4, 'Janet', 'King');

SELECT first_name, last_name
FROM employeez
WHERE emp_id IN (
    SELECT id
    FROM retirees);

CREATE TABLE roles (
    roloy_id SERIAL PRIMARY KEY,
    role_name VARCHAR(100) UNIQUE,
    job_description VARCHAR(100),
    base_salary INTEGER
);

CREATE TABLE employeez (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    birth_date DATE,
    num_sales INTEGER,
    roloy_id INTEGER REFERENCES roles(roloy_id)
);

INSERT INTO roles (role_name, job_description, base_salary) 
VALUES
    ('Graphic Designer', 'Helps with video editing, photo editing and market advertisement designs', 35000),
    ('Videographer', 'Helps with all digital media productions', 18000),
    ('Social Marketer', 'Helps with social media strategies and social data', 26000),
    ('Sales Rep', 'Helps promote and sign clients', 20000);

INSERT INTO employeez (name, birth_date, num_sales, roloy_id) 
VALUES
    ('Aragorn', '1994-08-24', 22, 4),
    ('Gandalf', '1982-05-11', 0, 1),
    ('Frodo', '1999-01-18', 0, 2),
    ('Legolas', '1998-04-22', 0, 3),
    ('Gimli', '2000-11-08', 10, 4),
    ('Samwise', '2001-01-01', 9, 4),
    ('Pippin', '1999-09-26', 18, 4),
    ('Merry', '2005-08-07', 0, 3);

ALTER TABLE employeez ADD COLUMN salary INTEGER;

UPDATE employeez SET salary = 22400 WHERE name = 'Aragorn';
UPDATE employeez SET salary = 35000 WHERE name = 'Gandalf';
UPDATE employeez SET salary = 18000 WHERE name = 'Frodo';
UPDATE employeez SET salary = 26000 WHERE name = 'Legolas';
UPDATE employeez SET salary = 20000 WHERE name = 'Gimli';
UPDATE employeez SET salary = 20000 WHERE name = 'Samwise';
UPDATE employeez SET salary = 21600 WHERE name = 'Pippin';
UPDATE employeez SET salary = 26000 WHERE name = 'Merry';

COPY (
  SELECT 
      e.name,
      e.birth_date,
      e.num_sales,
      e.salary,
      r.role_name,
      r.job_description,
      r.base_salary
  FROM employeez e
  JOIN roles r ON e.roloy_id = r.roloy_id
) TO 'C:\Bootcamp2025\SQL\sql\Chapter 12\employee_report.csv' WITH CSV HEADER;

SELECT name, birth_date
FROM employeez
WHERE AGE('2025-08-01', birth_date) > INTERVAL '27 years';


