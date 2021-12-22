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