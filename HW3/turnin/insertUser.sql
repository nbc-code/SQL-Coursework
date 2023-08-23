-- Noah Cantrell, nbc@iastate.edu
-- Q3
delimiter //
CREATE PROCEDURE insertUser (
	IN screen_name VARCHAR(80),
    IN user_name VARCHAR(80),
    IN category VARCHAR(80),
    IN subcategory VARCHAR(80),
    IN state varchar(80),
    IN numFollowers INTEGER,
    IN numFollowing INTEGER,
    OUT success INTEGER
)

BEGIN
	IF NOT EXISTS (SELECT * FROM practice.users u WHERE u.screen_name = screen_name)
	THEN 
		INSERT INTO practice.users VALUES (screen_name, user_name, category, subcategory, state, numFollowers, numFollowing);
        SET success = 1;
	ELSE
		SET success = 0;
	END IF;
END
//