-- Question 60
-- In social network like Facebook or Twitter, people send friend requests and accept others' requests as well.

-- Table request_accepted

-- +--------------+-------------+------------+
-- | requester_id | accepter_id | accept_date|
-- |--------------|-------------|------------|
-- | 1            | 2           | 2016_06-03 |
-- | 1            | 3           | 2016-06-08 |
-- | 2            | 3           | 2016-06-08 |
-- | 3            | 4           | 2016-06-09 |
-- +--------------+-------------+------------+
-- This table holds the data of friend acceptance, while requester_id and accepter_id both are the id of a person.
 

-- Write a query to find the the people who has most friends and the most friends number under the following rules:

-- It is guaranteed there is only 1 people having the most friends.
-- The friend request could only been accepted once, which mean there is no multiple records with the same requester_id and accepter_id value.
-- For the sample data above, the result is:

-- Result table:
-- +------+------+
-- | id   | num  |
-- |------|------|
-- | 3    | 3    |
-- +------+------+
-- The person with id '3' is a friend of people '1', '2' and '4', so he has 3 friends in total, which is the most number than any others.

-- Solution
-- SQLlite

CREATE table request_accepted
(
requester_id int,
accepter_id int,
accept_date date
);

INSERT into request_accepted 
values
(1,2,'2016_06-03'),
(1,3,'2016-06-08'),
(2,3,'2016-06-08'),
(3,4,'2016-06-09')
;

with t1 as 
(select requester_id,count(accepter_id) as friends_count
from 
request_accepted
group by requester_id

UNION all 

select accepter_id as requester_id,count(accepter_id) as friends_count
from 
request_accepted
group by accepter_id),

t2 as (select requester_id as id,sum(friends_count) as num from t1
group by requester_id)

select * from t2
where t2.num in (select max(num) from t2)
;

