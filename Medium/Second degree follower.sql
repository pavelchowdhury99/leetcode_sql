-- Question 70
-- In facebook, there is a follow table with two columns: followee, follower.

-- Please write a sql query to get the amount of each follower’s follower if he/she has one.

-- For example:

-- +-------------+------------+
-- | followee    | follower   |
-- +-------------+------------+
-- |     A       |     B      |
-- |     B       |     C      |
-- |     B       |     D      |
-- |     D       |     E      |
-- +-------------+------------+
-- should output:
-- +-------------+------------+
-- | follower    | num        |
-- +-------------+------------+
-- |     B       |  2         |
-- |     D       |  1         |
-- +-------------+------------+
-- Explaination:
-- Both B and D exist in the follower list, when as a followee, B's follower is C and D, and D's follower is E. A does not exist in follower list.
 

-- Note:
-- Followee would not follow himself/herself in all cases.
-- Please display the result in follower's alphabet order.

-- Solution
-- SQLlite

CREATE table Follower
(
followee varchar(50),
follower varchar(50)
);

INSERT into Follower 
values
('A','B'),
('B','C'),
('B','D'),
('D','E')
;

-- Query starts here

SELECT 
f1.follower as follower,
count(f2.follower) as num
FROM  
Follower f1
join Follower f2
on f1.follower=f2.followee
group by f1.follower;

