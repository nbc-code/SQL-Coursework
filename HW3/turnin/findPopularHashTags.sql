-- Noah Cantrell, nbc@iastate.edu
-- Q1
CREATE PROCEDURE findPopularHashTags (IN tag_limit INTEGER, IN post_year INTEGER)

SELECT count(DISTINCT u.state) AS statenum, group_concat(DISTINCT u.state) AS states, h.name AS hashtagname
	FROM practice.users u
	JOIN practice.tweets t ON u.screen_name = t.posting_user
	JOIN practice.hashtags h ON t.tid = h.tid
	WHERE t.post_year = post_year
	AND u.state IS NOT NULL
	AND u.state <> 'na'
	GROUP BY (hashtagname)
	ORDER BY(statenum)
	DESC
	LIMIT tag_limit;
    
    
    