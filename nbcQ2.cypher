// Author - Noah Cantrell


// Q2 A

match (t:Tweet)-[:POSTED]-(u:User) 
where t.post_year = 2016 
and t.post_month = 2 
return u.screen_name as screenname, 
u.sub_category as party, 
t.retweet_count as retweetCount 
order by t.retweet_count 
desc limit 5;

// Q2 B

match (h:Hashtag)-[:TAGGED]-(t:Tweet)-[:POSTED]-(u:User) 
where u.location = 'Ohio' 
or u.location = 'Alaska' 
return distinct h.name as hashtagName
order by h.name 
asc limit 5;

// Q2 C

match (u:User) 
where u.sub_category = "democrat" 
return u.screen_name as screenname, 
u.sub_category as party, 
u.followers as numFollowers 
order by u.followers 
desc limit 5;

// Q2 D

match(u:User)-[p:POSTED]->(t:Tweet)-[m:MENTIONED]->(u2:User)
where u.sub_category = "GOP" 
with count(u.screen_name) as cnt, 
collect(distinct u.screen_name) as listMentioningUsers, 
u2.screen_name as mentionedUser 
return mentionedUser, listMentioningUsers 
order by cnt 
desc limit 5;

// Q2 E

match(h:Hashtag)-[:TAGGED]-(t:Tweet)-[:POSTED]-(u:User) 
where u.location <> "na" 
with h, 
h.name as hashtag, 
count(distinct u.location) as numstates, 
collect(distinct u.location) as statelist 
return hashtag, numstates, statelist 
order by numstates 
desc limit 3;
