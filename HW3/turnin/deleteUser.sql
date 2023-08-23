-- Noah Cantrell, nbc@iastate.edu
-- Q4
delimiter //
CREATE PROCEDURE deleteUser (IN screen_name VARCHAR(80), OUT SUCCESS INTEGER)

BEGIN
	IF NOT EXISTS (SELECT * FROM practice.users u WHERE u.screen_name = screen_name)
		THEN
			SET success = -1;
		ELSE IF EXISTS
			(SELECT * FROM practice.users u
            LEFT JOIN practice.tweets t ON u.screen_name = t.posting_user
			LEFT JOIN practice.mentions m ON u.screen_name = m.mentioned_user_scr
			WHERE u.screen_name = screen_name)
		THEN
            DELETE h FROM practice.hashtags h
            INNER JOIN tweets t ON h.tid = t.tid
            WHERE t.posting_user = screen_name;
            
            DELETE url FROM practice.urls url
            INNER JOIN tweets t ON url.tid = t.tid
            WHERE t.posting_user = screen_name;
            
			DELETE m FROM practice.mentions m
            INNER JOIN tweets t ON m.tid = t.tid
            WHERE t.posting_user = screen_name;
            
			DELETE t FROM practice.tweets t
            INNER JOIN users u ON t.posting_user = u.screen_name
            WHERE u.screen_name = screen_name;
            
			DELETE u FROM practice.users u
            WHERE u.screen_name = screen_name;
        
			SET success = 0;
		ELSE
			SET success = 1;
		END IF;
    END IF;
END
//