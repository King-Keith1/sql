CREATE TABLE departments (
    dept_id bigserial,
    dept varchar(100),
    city varchar(100),
    CONSTRAINT dept_key PRIMARY KEY (dept_id),
    CONSTRAINT dept_city_unique UNIQUE (dept, city)
);

CREATE TABLE employees (
    emp_id bigserial,
    first_name varchar(100),
    last_name varchar(100),
    salary integer,
    dept_id integer REFERENCES departments (dept_id),
    CONSTRAINT emp_key PRIMARY KEY (emp_id),
    CONSTRAINT emp_dept_unique UNIQUE (emp_id, dept_id)
);

INSERT INTO departments (dept, city)
VALUES
    ('Tax', 'Atlanta'),
    ('IT', 'Boston');

INSERT INTO employees (first_name, last_name, salary, dept_id)
VALUES
    ('Nancy', 'Jones', 62500, 1),
    ('Lee', 'Smith', 59300, 1),
    ('Soo', 'Nguyen', 83000, 2),
    ('Janet', 'King', 95000, 2);

SELECT * FROM departments
SELECT * FROM employees

SELECT *
FROM employees JOIN departments
ON employees.dept_id = departments.dept_id;

CREATE TABLE teams (
	team_id bigserial,
	team varchar(100),
	home varchar(100),
	CONSTRAINT team_key PRIMARY KEY (team_id),
	CONSTRAINT team_home_unique UNIQUE (team, home)
);

INSERT INTO teams (team, home)
VALUES
	('Real Madrid', 'Santiago Bernabeu'),
	('Barcelona', 'Spotify Camp Nou')

SELECT * FROM teams
DROP TABLE teams;

ALTER TABLE players
ALTER COLUMN salary TYPE varchar(100);

CREATE TABLE players (
	ply_id bigserial,
	first_name varchar(100),
	last_name varchar(100),
	salary integer,
	pos varchar(100),
	team_id integer REFERENCES teams (team_id),
	CONSTRAINT ply_key PRIMARY KEY (ply_id),
    CONSTRAINT ply_team_unique UNIQUE (ply_id, team_id)
);

INSERT INTO players (first_name, last_name, salary, pos, team_id)
VALUES 
	('Kylian', 'Mbappé', '31,25 milion per anm', 'Forward', 1),
	('Vinicius', 'Vinicius Junior', '20,83 million per anm', 'Forward', 1),
	('Jude', 'Bellingham', '20,83 million per anm', 'Forward', 1),
	('Lamine', 'Yamal', '15 million per anm', 'Forward', 2),
	('Pablo', 'Gavira', '9,38 million per anm', 'Midfielder', 2),
	('Robert', 'Lewandowski', '33,33 million per anm', 'Forward', 2);

SELECT *
FROM players
JOIN teams
ON players.team_id = teams.team_id;

	
