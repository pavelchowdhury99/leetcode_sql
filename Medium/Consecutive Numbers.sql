-- Question 52
-- Write a SQL query to find all numbers that appear at least three times consecutively.

-- +----+-----+
-- | Id | Num |
-- +----+-----+
-- | 1  |  1  |
-- | 2  |  1  |
-- | 3  |  1  |
-- | 4  |  2  |
-- | 5  |  1  |
-- | 6  |  2  |
-- | 7  |  2  |
-- +----+-----+
-- For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.

-- +-----------------+
-- | ConsecutiveNums |
-- +-----------------+
-- | 1               |
-- +-----------------+

-- Solution
-- SQLlite

CREATE table Logs
(
Id int, 
Num int
);


INSERT into Logs 
values
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 1),
(6, 2),
(7, 2)
;

select DISTINCT num as ConsecutiveNums
from
(
SELECT *,
lead(num,1) over(order by ID) as one_lead,
lead(num,2) over(order by ID) as two_lead
FROM logs)
where NUM=one_lead and Num=two_lead;

