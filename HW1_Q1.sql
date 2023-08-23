-- Author: Tavanapong
-- Updated: Fall 2022

-- remove this database, HW1_Q1, if it exists
drop database if exists HW1_Q1;

-- create the database called HW1_Q1
create database HW1_Q1;

-- Tell DBMS to use HW1_Q1 as the default database to query against
use HW1_Q1;

-- create a relation to store data about different venues
create table venues (
venue_id int,
name varchar(200) not null unique,
description varchar(500),
primary key(venue_id));

-- create a relation to store data about people
create table persons (
pid int,
pname varchar(100) not null unique,
primary key(pid)
);

-- create a relation to store events associated with venues for venues with events
create table events (
vid int,
sched_date date,
location varchar(50),
primary key(vid, sched_date),
foreign key(vid) references venues(venue_id) on delete cascade on update cascade
);

-- create a relation to store who participates in which events
create table participates (
pid int,
vid int,
sched_date date,
primary key (pid, vid, sched_date),
foreign key(pid) references persons(pid),
foreign key(vid, sched_date) references events(vid, sched_date)
);

-- insert data 
insert into venues values (1, 'Grace Hopper Conference', 'Conference for Celebration of Women in Computing');
insert into venues values (2, 'Science Bound', 'ISU program to empower Iowa students of color to pursue degrees and careers in ASTEM');
insert into venues values (3, 'Go Further', 'Program for Women in Engineering');
insert into venues values (4, 'Computer Cyence', 'Computer science for high school students');
insert into venues values (5, 'Iowa 4H Summer Workshop', 'Iowa 4H Youth Conference');
insert into venues values (6, 'Computational Thinking Competition', 'K-12 outreach program offered by ComS');

insert into events values (1, '2017-10-20', 'Houston, TX');
insert into events values (2, '2020-02-19', 'ISU Campus');
insert into events values (4, '2022-08-05', 'Principal head quarter, Des Moines');
insert into events values (4, '2021-08-02', 'Virtual');
insert into events values (6, '2019-04-21', 'ISU Campus');

-- persons
insert into persons VALUES 
(100,'John'),
(101,'Mary'),
(102,'Dean'),
(103,'Jane'),
(104,'Pak'),
(105, 'James');

insert into participates values (100, 6, '2019-04-21');
insert into participates values (101, 6, '2019-04-21');
insert into participates values (103, 6, '2019-04-21');
insert into participates values (103, 1, '2017-10-20');
insert into participates values (102, 2, '2020-02-19');
insert into participates values (101, 2, '2020-02-19');
insert into participates values (104, 4, '2021-08-02');
insert into participates values (104, 4, '2022-08-05');

-- Q1_A
SELECT COUNT(vid) AS num_events FROM events;


-- Q1_B

SELECT vid, sched_date FROM events
WHERE NOT location='ISU Campus';


-- Q1_C

SELECT events.vid, events.sched_date, events.location
FROM events
JOIN participates
ON events.vid = participates.vid
JOIN persons
ON participates.pid = persons.pid
WHERE persons.pname = 'Pak'
GROUP BY events.location;


-- Q1_D

SELECT events.vid, events.sched_date, events.location
FROM events
JOIN participates
ON events.vid = participates.vid
JOIN persons
ON participates.pid = persons.pid
WHERE persons.pname = 'Pak'
OR persons.pname = 'john'
GROUP BY events.location
ORDER BY events.sched_date DESC;


-- Q1_E

SELECT distinct events.vid
FROM events, participates, persons
WHERE events.vid = participates.vid
AND participates.pid = persons.pid
AND persons.pname = 'John'
AND events.vid IN 
	(SELECT distinct events.vid
		FROM events, participates, persons
		WHERE events.vid = participates.vid
		AND participates.pid = persons.pid
		AND persons.pname = 'Jane'
		AND events.vid IN 
			(SELECT distinct events.vid
				FROM events, participates, persons
				WHERE events.vid = participates.vid
				AND participates.pid = persons.pid
				AND persons.pname = 'Mary')
	);


-- Q1_F

SELECT persons.pname
FROM participates
RIGHT JOIN persons ON participates.pid = persons.pid
WHERE participates.pid IS NULL
ORDER BY participates.pid DESC;


-- Q1_G

SELECT persons.pid, persons.pname
FROM persons
INNER JOIN participates ON persons.pid = participates.pid
GROUP BY participates.pid
HAVING (COUNT(*) > 1)
ORDER BY persons.pid;


-- Q1_H

SELECT venues.venue_id, venues.name
FROM venues
WHERE NOT EXISTS
	(SELECT events.vid FROM events 
    WHERE events.vid = venues.venue_id);


-- Q1_I

SELECT venues.venue_id, venues.name
FROM venues
WHERE venues.venue_id NOT IN 
(SELECT events.vid FROM events);


-- Q1_J
-- Noah Cantrell