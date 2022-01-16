-- Question 56
-- Mary is a teacher in a middle school and she has a table seat storing students' names and their corresponding seat ids.

-- The column id is continuous increment.
 

-- Mary wants to change seats for the adjacent students.
 

-- Can you write a SQL query to output the result for Mary?
 

-- +---------+---------+
-- |    id   | student |
-- +---------+---------+
-- |    1    | Abbot   |
-- |    2    | Doris   |
-- |    3    | Emerson |
-- |    4    | Green   |
-- |    5    | Jeames  |
-- +---------+---------+
-- For the sample input, the output is:
 

-- +---------+---------+
-- |    id   | student |
-- +---------+---------+
-- |    1    | Doris   |
-- |    2    | Abbot   |
-- |    3    | Green   |
-- |    4    | Emerson |
-- |    5    | Jeames  |
-- +---------+---------+

-- Solution
-- SQLlite

CREATE table Students
(
id int, 
student varchar(50)
);

INSERT into Students 
values
(1,'Abbot  '),
(2,'Doris  '),
(3,'Emerson'),
(4,'Green  '),
(5,'Jeames ')
;

with t1 as 
(select 
id, 
student,
lead(student) over() as lead_,
lag(student) over() as lag_
from students)

select 
id,
case 
	when id%2=1 then coalesce(lead_,student)
	else coalesce(lag_,student)
end as student
from t1;

