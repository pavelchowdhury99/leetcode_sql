-- Question 65
-- Table: Events

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | business_id   | int     |
-- | event_type    | varchar |
-- | occurences    | int     | 
-- +---------------+---------+
-- (business_id, event_type) is the primary key of this table.
-- Each row in the table logs the info that an event of some type occured at some business for a number of times.
 

-- Write an SQL query to find all active businesses.

-- An active business is a business that has more than one event type with occurences greater than the average occurences of that event type among all businesses.

-- The query result format is in the following example:

-- Events table:
-- +-------------+------------+------------+
-- | business_id | event_type | occurences |
-- +-------------+------------+------------+
-- | 1           | reviews    | 7          |
-- | 3           | reviews    | 3          |
-- | 1           | ads        | 11         |
-- | 2           | ads        | 7          |
-- | 3           | ads        | 6          |
-- | 1           | page views | 3          |
-- | 2           | page views | 12         |
-- +-------------+------------+------------+

-- Result table:
-- +-------------+
-- | business_id |
-- +-------------+
-- | 1           |
-- +-------------+ 
-- Average for 'reviews', 'ads' and 'page views' are (7+3)/2=5, (11+7+6)/3=8, (3+12)/2=7.5 respectively.
-- Business with id 1 has 7 'reviews' events (more than 5) and 11 'ads' events (more than 8) so it is an active business.

-- Solution
-- SQLlite

CREATE table events
(
business_id int,
event_type varchar(20),
occurences int
);

INSERT into events 
values
(1,'reviews',7),
(3,'reviews',3),
(1,'ads',11),
(2,'ads',7),
(3,'ads',6),
(1,'page views',3),
(2,'page views',12);

select event_type, AVG(occurences)
from events e
group by event_type ;

select e.business_id 
from events e 
left join 
(select event_type, AVG(occurences) as average_occurence
from events e
group by event_type) t2 on e.event_type = t2.event_type
where e.occurences > t2.average_occurence
group by e.business_id 
HAVING count(DISTINCT e.event_type)>1;
