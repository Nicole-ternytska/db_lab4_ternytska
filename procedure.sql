
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