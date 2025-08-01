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