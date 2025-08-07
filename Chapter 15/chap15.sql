CREATE TABLE us_counties_2000 (
    geo_name varchar(90),              -- County/state name,
    state_us_abbreviation varchar(2),  -- State/U.S. abbreviation
    state_fips varchar(2),             -- State FIPS code
    county_fips varchar(3),            -- County code
    p0010001 integer,                  -- Total population
    p0010002 integer,                  -- Population of one race:
    p0010003 integer,                      -- White Alone
    p0010004 integer,                      -- Black or African American alone
    p0010005 integer,                      -- American Indian and Alaska Native alone
    p0010006 integer,                      -- Asian alone
    p0010007 integer,                      -- Native Hawaiian and Other Pacific Islander alone
    p0010008 integer,                      -- Some Other Race alone
    p0010009 integer,                  -- Population of two or more races
    p0010010 integer,                  -- Population of two races
    p0020002 integer,                  -- Hispanic or Latino
    p0020003 integer                   -- Not Hispanic or Latino:
);

COPY us_counties_2000
FROM 'C:\Bootcamp2025\SQL\practical-sql-main\Chapter_06\us_counties_2000.csv'
WITH (FORMAT CSV, HEADER);

CREATE OR REPLACE VIEW nevada_counties_pop_2010 AS
 SELECT geo_name,
 state_fips,
 county_fips,
 p0010001 AS pop_2010
 FROM us_counties_2010
 WHERE state_us_abbreviation = 'NV'
 ORDER BY county_fips;

SELECT * FROM us_counties_2010

SELECT *
FROM nevada_counties_pop_2010
LIMIT 5

CREATE OR REPLACE VIEW county_pop_change_2010_2000 AS
    SELECT c2010.geo_name,
           c2010.state_us_abbreviation AS st,
           c2010.state_fips,
           c2010.county_fips,
           c2010.p0010001 AS pop_2010,
           c2000.p0010001 AS pop_2000,
           ROUND(
               (CAST(c2010.p0010001 AS numeric(8,1)) - c2000.p0010001)
               / NULLIF(c2000.p0010001, 0) * 100, 1
           ) AS pct_change_2010_2000
    FROM us_counties_2010 c2010
    INNER JOIN us_counties_2000 c2000
        ON c2010.state_fips = c2000.state_fips
        AND c2010.county_fips = c2000.county_fips;

SELECT * FROM county_pop_change_2010_2000;

SELECT geo_name,
       st,
       pop_2010,
       pct_change_2010_2000
FROM county_pop_change_2010_2000
WHERE st = 'NV'
LIMIT 5;

CREATE OR REPLACE VIEW employees_tax_dept AS
     SELECT employee_id,
            full_name,
            department_id
     FROM employees
     WHERE department_id = 1
     ORDER BY employee_id
     WITH LOCAL CHECK OPTION;

SELECT * FROM employees_tax_dept 

INSERT INTO employees_tax_dept (full_name, department_id, employee_id)
VALUES ('Jamil White', 1, 13);

CREATE OR REPLACE FUNCTION print_name(person_name text)
RETURNS text AS $$
BEGIN
	RETURN person_name;
END;
$$	LANGUAGE plpgsql;

SELECT print_name('My name is Pierre.')

CREATE OR REPLACE FUNCTION addition(num1 numeric, num2 numeric)
RETURNS numeric AS $$
BEGIN	
	RETURN (num1 +  num2);
END;
$$ LANGUAGE plpgsql;

SELECT (6 + 4)

CREATE OR REPLACE FUNCTION power_level(base_power NUMERIC)
RETURNS NUMERIC AS $$
BEGIN
    RETURN ROUND(base_power * (0.5 + RANDOM() * 1.5)); -- Random multiplier between 0.5 and 2.0
END;
$$ LANGUAGE plpgsql;

SELECT power_level(10) AS randomized_power;

CREATE OR REPLACE FUNCTION update_personal_days()
RETURNS void AS $$
BEGIN
    UPDATE teachers
    SET personal_days =
        CASE WHEN (now() - hire_date) BETWEEN '5 years'::interval
                                      AND '10 years'::interval THEN 4
             WHEN (now() - hire_date) > '10 years'::interval THEN 5
             ELSE 3
        END;
    RAISE NOTICE 'personal_days updated!';
END;
$$ LANGUAGE plpgsql;

-- To run the function:
SELECT update_personal_days();

--Python

CREATE EXTENSION plpythonu;
