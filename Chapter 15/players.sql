DROP TABLE players

CREATE TABLE players (
    player_id BIGINT PRIMARY KEY,
    game_username VARCHAR(50),
    level INT DEFAULT 1,
    password VARCHAR(50) NOT NULL
);


CREATE TABLE username_history (
    player_id BIGINT,
    old_username VARCHAR(50),
    new_username VARCHAR(50),
    change_date DATE DEFAULT CURRENT_DATE
);

CREATE OR REPLACE FUNCTION generate_game_username()
RETURNS trigger AS
$$
DECLARE
    adjectives TEXT[] := ARRAY['Swift', 'Shadow', 'Mighty', 'Silent', 'Fierce', 'Brave', 'Lucky', 'Clever'];
    creatures  TEXT[] := ARRAY['Dragon', 'Wolf', 'Falcon', 'Tiger', 'Raven', 'Shark', 'Eagle', 'Bear'];
    adj TEXT;
    creature TEXT;
    num INT;
BEGIN
    -- If no username is provided, make one
    IF NEW.game_username IS NULL OR NEW.game_username = '' THEN
        adj := adjectives[1 + FLOOR(RANDOM() * ARRAY_LENGTH(adjectives, 1))];
        creature := creatures[1 + FLOOR(RANDOM() * ARRAY_LENGTH(creatures, 1))];
        num := FLOOR(RANDOM() * 900) + 100; -- random 3-digit number
        NEW.game_username := LOWER(adj || creature || num);
    END IF;

    -- Log the creation in username_history
    INSERT INTO username_history (player_id, old_username, new_username)
    VALUES (NEW.player_id, NULL, NEW.game_username);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_player_insert
BEFORE INSERT
ON players
FOR EACH ROW
EXECUTE FUNCTION generate_game_username();

INSERT INTO players (player_id, password) VALUES (1, 'secret1');
INSERT INTO players (player_id, password) VALUES (2, 'secret2');

INSERT INTO players (player_id, game_username, password) 
VALUES (3, 'customhero', 'secret3');

SELECT * FROM players;

SELECT * FROM username_history;



