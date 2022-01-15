-- Question 78
-- Table Variables:

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | name          | varchar |
-- | value         | int     |
-- +---------------+---------+
-- name is the primary key for this table.
-- This table contains the stored variables and their values.
 

-- Table Expressions:

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | left_operand  | varchar |
-- | operator      | enum    |
-- | right_operand | varchar |
-- +---------------+---------+
-- (left_operand, operator, right_operand) is the primary key for this table.
-- This table contains a boolean expression that should be evaluated.
-- operator is an enum that takes one of the values ('<', '>', '=')
-- The values of left_operand and right_operand are guaranteed to be in the Variables table.
 

-- Write an SQL query to evaluate the boolean expressions in Expressions table.

-- Return the result table in any order.

-- The query result format is in the following example.

-- Variables table:
-- +------+-------+
-- | name | value |
-- +------+-------+
-- | x    | 66    |
-- | y    | 77    |
-- +------+-------+

-- Expressions table:
-- +--------------+----------+---------------+
-- | left_operand | operator | right_operand |
-- +--------------+----------+---------------+
-- | x            | >        | y             |
-- | x            | <        | y             |
-- | x            | =        | y             |
-- | y            | >        | x             |
-- | y            | <        | x             |
-- | x            | =        | x             |
-- +--------------+----------+---------------+

-- Result table:
-- +--------------+----------+---------------+-------+
-- | left_operand | operator | right_operand | value |
-- +--------------+----------+---------------+-------+
-- | x            | >        | y             | false |
-- | x            | <        | y             | true  |
-- | x            | =        | y             | false |
-- | y            | >        | x             | true  |
-- | y            | <        | x             | false |
-- | x            | =        | x             | true  |
-- +--------------+----------+---------------+-------+
-- As shown, you need find the value of each boolean exprssion in the table using the variables table.

-- Solution
-- SQLLite

CREATE table Variables
(
name varchar(50), 
value int
);

CREATE table Expressions
(
left_operand varchar(50),
operator varchar(50),
right_operand varchar(50)
);


INSERT into Variables 
values
('x',66),
('y',77)
;

INSERT into Expressions 
values
('x','>','y'),
('x','<','y'),
('x','=','y'),
('y','>','x'),
('y','<','x'),
('x','=','x')
;

with t1 as 
(
select e.*,v.value as left_val,
v2.value as right_val
from 
Expressions e 
left join Variables v
on e.left_operand=v.name
left join Variables v2
on e.right_operand=v2.name
)

select *,
Case 
	when operator=">" and left_val>right_val then 'true'
	when operator="<" and left_val<right_val then 'true'
	when operator="=" and left_val=right_val then 'true'
	else 'false'
end as value 
from t1
