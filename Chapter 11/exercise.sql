CREATE TABLE department (
	department_id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	facility VARCHAR(100)
);

CREATE TABLE employees (
	employee_id SERIAL PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL,
	email VARCHAR (100) UNIQUE,
	is_active BOOLEAN DEFAULT TRUE
);


INSERT INTO department (name, facility)
VALUES
    ('SQL', 'Home'),
    ('MERN', 'Office');

ALTER TABLE employees
ADD COLUMN department_id INTEGER REFERENCES department(department_id);

INSERT INTO employees (full_name, email, department_id) VALUES
('Alexander Badenhorst', 'alex@example.com', 1),
('Courtney Cook', 'courtsey_of_courtney@funmail.io', 2),
('Cadee Rousseau', 'codee.withcadee@byte.com', 1),
('David Koen', 'teachinator.david@brainboost.edu', 1),
('Ethan Hurwitz', 'ethanator@hackmail.com', 1),
('Lindokuhle Yende', 'lindo.logic@neuralhub.org', 1),
('Marvelous Kahundahunda', 'absolutely.marvelous@wow.com', 1),
('Pierre Kahundahunda', 'pierrefect.code@bonjour.dev', 1),
('Ronny Mputla', 'run.run.ronny@speedmail.net', 1),
('Sibusiso Makhiwane', 'sibu.saves@galaxymail.com', 1),
('Tom Vuma', 'tom.tornado@scriptstorm.dev', 1),
('Ulrich Snyman', 'ultimatecoding@master.com', 1);

SELECT * FROM department
SELECT * FROM employees

COPY (
    SELECT 
        e.full_name, 
        e.email, 
        d.name AS department_name
    FROM employees e
    JOIN department d ON e.department_id = d.department_id
) TO 'C:\Bootcamp2025\SQL\sql\Chapter 11\joined_employees_departments.csv' CSV HEADER;

ALTER TABLE employees
ADD COLUMN score INTEGER;

UPDATE employees SET score = 88 WHERE full_name = 'Alexander Badenhorst';
UPDATE employees SET score = 91 WHERE full_name = 'Cadee Rousseau';
UPDATE employees SET score = 85 WHERE full_name = 'David Koen';
UPDATE employees SET score = 76 WHERE full_name = 'Ethan Hurwitz';
UPDATE employees SET score = 94 WHERE full_name = 'Lindokuhle Yende';
UPDATE employees SET score = 89 WHERE full_name = 'Marvelous Kahundahunda';
UPDATE employees SET score = 92 WHERE full_name = 'Pierre Kahundahunda';
UPDATE employees SET score = 74 WHERE full_name = 'Ronny Mputla';
UPDATE employees SET score = 95 WHERE full_name = 'Sibusiso Makhiwane';
UPDATE employees SET score = 80 WHERE full_name = 'Tom Vuma';
UPDATE employees SET score = 87 WHERE full_name = 'Ulrich Snyman';
UPDATE employees SET score = 65 WHERE full_name = 'Courtney Cook';

ALTER TABLE employees
ADD COLUMN low_scores INTEGER;

UPDATE employees SET low_scores = 49 WHERE full_name = 'Alexander Badenhorst';
UPDATE employees SET low_scores = 48 WHERE full_name = 'Cadee Rousseau';
UPDATE employees SET low_scores = 0 WHERE full_name = 'David Koen';
UPDATE employees SET low_scores = 36 WHERE full_name = 'Ethan Hurwitz';
UPDATE employees SET low_scores = 60 WHERE full_name = 'Lindokuhle Yende';
UPDATE employees SET low_scores = 20 WHERE full_name = 'Marvelous Kahundahunda';
UPDATE employees SET low_scores = 44 WHERE full_name = 'Pierre Kahundahunda';
UPDATE employees SET low_scores = 15 WHERE full_name = 'Ronny Mputla';
UPDATE employees SET low_scores = 25 WHERE full_name = 'Sibusiso Makhiwane';
UPDATE employees SET low_scores = 21 WHERE full_name = 'Tom Vuma';
UPDATE employees SET low_scores = 45 WHERE full_name = 'Ulrich Snyman';
UPDATE employees SET low_scores = 36 WHERE full_name = 'Courtney Cook';

SELECT full_name, score, low_scores
FROM employees
WHERE (score > 50) AND (low_scores < 20);

SELECT 
  full_name,
  score,
  low_scores,
  ROUND((score - (SELECT AVG(score) FROM employees)), 1) AS difference_from_avg
FROM employees;

SELECT * FROM employees



