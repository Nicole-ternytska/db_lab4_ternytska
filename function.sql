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