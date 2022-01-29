-- Question 50
-- Write a SQL query to get the nth highest salary from the Employee table.

-- +----+--------+
-- | Id | Salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+
-- For example, given the above Employee table, the nth highest salary where n = 2 is 200. If there is no nth highest salary, then the query should return null.

-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | 200                    |
-- +------------------------+

-- Solution
-- SQLlite

create table Employee
(
id int,
salary int
);

insert into Employee
values
(1,100),
(2,200),
(3,300);

-- Query starts here
select 
id as [getNthHighestSalary(2)]
from 
(
SELECT 
*,
rank() over(order by salary) as rn
from Employee e
) a
where rn=2;
