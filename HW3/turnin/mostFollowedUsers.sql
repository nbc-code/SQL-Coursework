-- Noah Cantrell, nbc@iastate.edu
-- Q2
CREATE PROCEDURE mostFollowedUsers(IN num_users INTEGER, IN political_party VARCHAR(80))

SELECT u.screen_name, u.subcategory, u.numFollowers
	FROM practice.users u
	WHERE u.subcategory = political_party
	GROUP BY(u.numfollowers)
	ORDER BY(numfollowers)
	DESC
	LIMIT num_users;