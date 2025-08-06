-- 🧱 Create the table
CREATE TABLE char_data_types (
  varchar_column VARCHAR(100)
);

-- 📥 Insert sample data
INSERT INTO char_data_types (varchar_column)
VALUES 
  ('abc'),
  ('ABC'),
  ('Abc'),
  ('hello there'),
  ('hi over there');

-- 🔄 Update rows where varchar_column matches 'ABC' (case-insensitive)
UPDATE char_data_types
SET varchar_column = upper('abc')
WHERE varchar_column ILIKE 'ABC';

-- ✂️ Trim 'C' from the string 'abc' for matching rows
SELECT trim('C' FROM 'abc')
FROM char_data_types
WHERE varchar_column ILIKE 'ABC';

-- 🔍 Find position of substring 'llo ' in 'hello there'
SELECT position('llo ' IN 'hello there');

-- ↪️ Get 0 characters from the right of 'hi over there'
SELECT right('hi over there', 0);

-- 🔢 Extract the 4-digit year using regex
SELECT substring('The game starts at 7 p.m. on May 2, 2019.' FROM '[0-9]{4}');

CREATE TABLE subs (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,

--constraints
CONSTRAINT username_check
	CHECK (username ~ '^[A-Z][a-zA-Z0-9_]*'),
CONSTRAINT password_check
    CHECK (password ~ '^[0-9]+$'),
CONSTRAINT email_check
    CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

DROP TABLE subs

INSERT INTO subs (username, password, email)
VALUES
    ('Pierre', '4444', 'pierrefect.code@bonjour.dev'),      
    ('Cadee', '9876543210', 'codee.withcadee@byte.com'), 
    ('Tom', '123456789', 'tom.tornado@scriptstorm.dev');     

SELECT * FROM subs;

INSERT INTO subscribers (username, password, email)
VALUES ('Joshua, '123456', 'newuser@example*com');



