-- Question 80
-- Table: Logs

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | log_id        | int     |
-- +---------------+---------+
-- id is the primary key for this table.
-- Each row of this table contains the ID in a log Table.

-- Since some IDs have been removed from Logs. Write an SQL query to find the start and end number of continuous ranges in table Logs.

-- Order the result table by start_id.

-- The query result format is in the following example:

-- Logs table:
-- +------------+
-- | log_id     |
-- +------------+
-- | 1          |
-- | 2          |
-- | 3          |
-- | 7          |
-- | 8          |
-- | 10         |
-- +------------+

-- Result table:
-- +------------+--------------+
-- | start_id   | end_id       |
-- +------------+--------------+
-- | 1          | 3            |
-- | 7          | 8            |
-- | 10         | 10           |
-- +------------+--------------+
-- The result table should contain all ranges in table Logs.
-- From 1 to 3 is contained in the table.
-- From 4 to 6 is missing in the table
-- From 7 to 8 is contained in the table.
-- Number 9 is missing in the table.
-- Number 10 is contained in the table.

-- Solution
-- SQLlite

CREATE table Logs
(
log_id int
);

INSERT into Logs 
values
(1),
(2),
(3),
(7),
(8),
(10)
;

with t1 as 
(SELECT
*,lead(log_id) over() as next_,
lag(log_id) over() as prev_
from logs)

,t2 as 
(select 
ROW_NUMBER() over() as RN,
log_id as end_id
from t1
where next_-log_id!=1)

,t3 as 
(select 
ROW_NUMBER() over() as RN,
log_id as start_id
from t1
where log_id-prev_!=1 or log_id-prev_ is NULL)

select 
COALESCE(start_id,end_id) as start_id,
COALESCE(end_id,start_id) as end_id
from 
t3 left join t2
on t2.RN=t3.RN;

