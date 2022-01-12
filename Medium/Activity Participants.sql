-- Question 77
-- Table: Friends

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- | activity      | varchar |
-- +---------------+---------+
-- id is the id of the friend and primary key for this table.
-- name is the name of the friend.
-- activity is the name of the activity which the friend takes part in.
-- Table: Activities

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- +---------------+---------+
-- id is the primary key for this table.
-- name is the name of the activity.
 

-- Write an SQL query to find the names of all the activities with neither maximum, nor minimum number of participants.

-- Return the result table in any order. Each activity in table Activities is performed by any person in the table Friends.

-- The query result format is in the following example:

-- Friends table:
-- +------+--------------+---------------+
-- | id   | name         | activity      |
-- +------+--------------+---------------+
-- | 1    | Jonathan D.  | Eating        |
-- | 2    | Jade W.      | Singing       |
-- | 3    | Victor J.    | Singing       |
-- | 4    | Elvis Q.     | Eating        |
-- | 5    | Daniel A.    | Eating        |
-- | 6    | Bob B.       | Horse Riding  |
-- +------+--------------+---------------+

-- Activities table:
-- +------+--------------+
-- | id   | name         |
-- +------+--------------+
-- | 1    | Eating       |
-- | 2    | Singing      |
-- | 3    | Horse Riding |
-- +------+--------------+

-- Result table:
-- +--------------+
-- | activity     |
-- +--------------+
-- | Singing      |
-- +--------------+

-- Eating activity is performed by 3 friends, maximum number of participants, (Jonathan D. , Elvis Q. and Daniel A.)
-- Horse Riding activity is performed by 1 friend, minimum number of participants, (Bob B.)
-- Singing is performed by 2 friends (Victor J. and Jade W.)

-- Solution
-- SQLlite

CREATE table Friends
(
id int primary key,
name varchar(50),
activity varchar(50)
);

CREATE table Activities
(
id int,
name varchar(50)
);

INSERT into Friends 
values
(1,'Jonathan D.','Eating'),
(2,'Jade W.','Singing'),
(3,'Victor J.','Singing'),
(4,'Elvis Q.','Eating'),
(5,'Daniel A.','Eating'),
(6,'Bob B.'   ,'Horse Riding')
;

INSERT into Activities 
values
(1,'Eating'),
(2,'Singing'),
(3,'Horse Riding');


with t1 as 
(select a.name
--,f.name
,count(f.name) as participants_count
from Activities a 
left join Friends f 
on a.name=f.activity 
group by a.name) 

select t1.name from t1
where t1.participants_count<(select max(participants_count) from t1)
and t1.participants_count>(select min(participants_count) from t1);
