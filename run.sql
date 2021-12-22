-- FUNCTION
SELECT * FROM board_game;
CREATE OR REPLACE FUNCTION game_count(name text) RETURNS int AS
$$
	DECLARE
		res integer;
	BEGIN
		SELECT COUNT(*) INTO res
		FROM collection
		INNER JOIN board_game USING(game_id)
		WHERE game_name = name;
		
		RETURN res;
	END;
$$ LANGUAGE 'plpgsql';

SELECT * FROM game_count('Gloomhaven');


-- PROCEDURE

CREATE OR REPLACE PROCEDURE games_by_time(time_1 text)
LANGUAGE plpgsql AS
$$
	DECLARE
		game_rec record;
	BEGIN
		FOR game_rec IN
			SELECT board_game.game_name
			FROM board_game
			INNER JOIN play_time USING(play_time_id)
			WHERE play_time.play_time_id = play_time_id
		LOOP
			RAISE INFO 'Name: %', game_rec.game_name;
		END LOOP;
	END;
$$

CALL  games_by_time('120');


-- -- TRIGGER

CREATE TRIGGER geek_insert
AFTER INSERT ON geek
FOR EACH ROW
EXECUTE FUNCTION ins_geek();


CREATE OR REPLACE FUNCTION ins_geek() RETURNS trigger AS
$$
	BEGIN
		UPDATE geek
		SET geek_name = geek_name
		WHERE geek.geek_id = NEW.geek_id;
		RETURN NULL;
	END;
$$ LANGUAGE 'plpgsql';

SELECT * FROM geek;
INSERT INTO geek (geek_name) VALUES ('Paul Holl');
SELECT * FROM geek

