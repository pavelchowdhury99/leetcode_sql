-- Question 75
-- The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.

-- +------+----------+-----------+----------+
-- |Id    |Name 	  |Department |ManagerId |
-- +------+----------+-----------+----------+
-- |101   |John 	  |A 	      |null      |
-- |102   |Dan 	    |A 	      |101       |
-- |103   |James 	  |A 	      |101       |
-- |104   |Amy 	    |A 	      |101       |
-- |105   |Anne 	  |A 	      |101       |
-- |106   |Ron 	    |B 	      |101       |
-- +------+----------+-----------+----------+
-- Given the Employee table, write a SQL query that finds out managers with at least 5 direct report. For the above table, your SQL query should return:

-- +-------+
-- | Name  |
-- +-------+
-- | John  |
-- +-------+
-- Note:
-- No one would report to himself.

-- Solution
-- SQLlite

CREATE table Employee
(
ID int,
Name varchar(100),
Department int,
ManagerID int
);

INSERT into Employee 
values
(101,'John ' ,'A',null),
(102,'Dan 	','A',101 ),
(103,'James' ,'A',101 ),
(104,'Amy 	','A',101 ),
(105,'Anne ' ,'A',101 ),
(106,'Ron 	','B',101 )
;

with t
as 
(SELECT ManagerID,Count(ManagerID) count_of_reports
from Employee 
group by ManagerID)

select 
Name
FROM 
Employee e
inner join t
on e.id=t.managerid
where count_of_reports>=5;
