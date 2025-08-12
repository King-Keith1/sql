CREATE TABLE profession (
    prof_id SERIAL PRIMARY KEY,
    profession VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE zip_code (
    zip_code CHAR(4) PRIMARY KEY,       -- natural key (postal code)
    city VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL,
    CHECK (zip_code ~ '^[0-9]{4}$')     -- enforces exactly 4 digits (prevents >4)
);

CREATE TABLE status (
    status_id SERIAL PRIMARY KEY,
    status VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE interests (
    interest_id SERIAL PRIMARY KEY,
    interest VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE seeking (
    seeking_id SERIAL PRIMARY KEY,
    seeking VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE my_contacts (
    contact_id SERIAL PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(200) UNIQUE,
    gender VARCHAR(20),
    birthday DATE,
    prof_id INTEGER REFERENCES profession(prof_id),
    zip_code CHAR(4) REFERENCES zip_code(zip_code),
    status_id INTEGER REFERENCES status(status_id)
);

CREATE TABLE contact_interest (
    contact_id INTEGER REFERENCES my_contacts(contact_id) ON DELETE CASCADE,
    interest_id INTEGER REFERENCES interests(interest_id) ON DELETE CASCADE,
    PRIMARY KEY (contact_id, interest_id)
);

CREATE TABLE contact_seeking (
    contact_id INTEGER REFERENCES my_contacts(contact_id) ON DELETE CASCADE,
    seeking_id INTEGER REFERENCES seeking(seeking_id) ON DELETE CASCADE,
    PRIMARY KEY (contact_id, seeking_id)
);

INSERT INTO profession (profession) VALUES
('Software Developer'),
('Data Analyst'),
('Teacher'),
('Nurse'),
('Chef'),
('Entrepreneur'),
('Mechanic'),
('Journalist'),
('Artist'),
('Financial Advisor'),
('Architect'),
('Lawyer');

INSERT INTO zip_code (zip_code, city, province) VALUES
('8000','Cape Town','Western Cape'),
('7600','Stellenbosch','Western Cape'),
('6001','Gqeberha','Eastern Cape'),
('5200','East London','Eastern Cape'),
('2000','Johannesburg','Gauteng'),
('0002','Pretoria','Gauteng'),
('4001','Durban','KwaZulu-Natal'),
('3200','Pietermaritzburg','KwaZulu-Natal'),
('9300','Bloemfontein','Free State'),
('9450','Welkom','Free State'),
('0700','Polokwane','Limpopo'),
('0850','Tzaneen','Limpopo'),
('1200','Mbombela','Mpumalanga'),
('1030','Middelburg','Mpumalanga'),
('0299','Rustenburg','North West'),
('2745','Mafikeng','North West'),
('8301','Kimberley','Northern Cape'),
('8800','Upington','Northern Cape');

INSERT INTO status (status) VALUES
('Single'),
('Married'),
('Divorced'),
('Widowed'),
('Complicated');

INSERT INTO interests (interest) VALUES
('Hiking'),
('Reading'),
('Soccer'),
('Running'),
('Cooking'),
('Gaming'),
('Photography'),
('Painting'),
('Traveling'),
('Music'),
('Gardening'),
('Coding');

INSERT INTO seeking (seeking) VALUES
('Long-term relationship'),
('Friendship'),
('Networking'),
('Mentorship'),
('Casual dating');

INSERT INTO my_contacts (last_name, first_name, phone, email, gender, birthday, prof_id, zip_code, status_id) VALUES
('Ngwenya','Sipho','+27831234567','sipho.ngwenya@example.co.za','Male','1994-03-12', 1, '8000', 1),
('Mokgadi','Lerato','+27834567890','lerato.mokgadi@example.co.za','Female','1996-07-22', 3, '7600', 1),
('van Heerden','Jaco','+27835551234','jaco.vh@example.co.za','Male','1989-11-05', 7, '9300', 2),
('Dlamini','Nokuthula','+27831230001','nokuthula.d@example.co.za','Female','1998-01-30', 4, '4001', 1),
('Naidoo','Arun','+27836660002','arun.naidoo@example.co.za','Male','1992-05-17', 2, '2000', 1),
('Smith','Emily','+27831239999','emily.smith@example.co.za','Female','1990-09-10', 9, '6001', 2),
('Mkhize','Sibusiso','+27837654321','sibusiso.m@example.co.za','Male','1997-12-02', 6, '3200', 1),
('Botha','Annelize','+27831237777','annelize.b@example.co.za','Female','1995-04-08', 11, '7600', 3),
('Khumalo','Thabo','+27831236666','thabo.k@example.co.za','Male','1993-06-16', 1, '2745', 1),
('Radebe','Zinhle','+27831235555','zinhle.r@example.co.za','Female','2000-02-20', 5, '3200', 1),
('van der Merwe','Pieter','+27831234444','pieter.vdm@example.co.za','Male','1987-08-01', 7, '2745', 4),
('Maree','Sarie','+27831233333','sarie.m@example.co.za','Female','1991-10-12', 10, '8000', 2),
('Maseko','Phindile','+27831232222','phindile.m@example.co.za','Female','1999-05-05', 4, '4001', 1),
('Kgalema','Kgosi','+27831231111','kgosi.k@example.co.za','Male','1998-11-11', 8, '2000', 1),
('Pillay','Naledi','+27831230002','naledi.p@example.co.za','Female','1996-12-24', 12, '6001', 1),
('Motshele','Kabelo','+27831230003','kabelo.m@example.co.za','Male','1995-03-03', 2, '9300', 1);

INSERT INTO contact_interest (contact_id, interest_id) VALUES
(1, 1),(1,2),(1,9),
(2,2),(2,5),(2,10),
(3,7),(3,11),(3,6),
(4,5),(4,1),(4,10),
(5,12),(5,2),(5,9),
(6,8),(6,7),(6,2),
(7,6),(7,1),(7,9),
(8,9),(8,10),(8,5),
(9,3),(9,4),(9,1),
(10,5),(10,2),(10,8),
(11,7),(11,6),(11,12),
(12,10),(12,11),(12,2),
(13,1),(13,5),(13,6),
(14,12),(14,2),(14,4),
(15,2),(15,8),(15,9),
(16,12),(16,2),(16,7);

INSERT INTO contact_seeking (contact_id, seeking_id) VALUES
(1,1),
(2,1),
(3,3),
(4,2),
(5,3),
(6,5),
(7,4),
(8,1),
(9,2),
(10,1),
(11,3),
(12,4),
(13,1),
(14,5),
(15,2),
(16,3);

CREATE OR REPLACE VIEW v_contact_overview AS
SELECT 
    c.contact_id,
    c.first_name,
    c.last_name,
    p.profession AS profession,
    z.zip_code AS postal_code,
    z.city,
    z.province,
    s.status AS status,
    COALESCE(string_agg(DISTINCT i.interest, ', '), '') AS interests,
    COALESCE(string_agg(DISTINCT sk.seeking, ', '), '') AS seeking
FROM my_contacts c
LEFT JOIN profession p ON c.prof_id = p.prof_id
LEFT JOIN zip_code z ON c.zip_code = z.zip_code
LEFT JOIN status s ON c.status_id = s.status_id
LEFT JOIN contact_interest ci ON c.contact_id = ci.contact_id
LEFT JOIN interests i ON ci.interest_id = i.interest_id
LEFT JOIN contact_seeking cs ON c.contact_id = cs.contact_id
LEFT JOIN seeking sk ON cs.seeking_id = sk.seeking_id
GROUP BY c.contact_id, c.first_name, c.last_name, p.profession, z.zip_code, z.city, z.province, s.status
ORDER BY c.contact_id;

SELECT * FROM v_contact_overview;

