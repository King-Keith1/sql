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







