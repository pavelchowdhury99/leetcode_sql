--Question 94
-- Table Accounts:

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- +---------------+---------+
-- the id is the primary key for this table.
-- This table contains the account id and the user name of each account.
 

-- Table Logins:

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | login_date    | date    |
-- +---------------+---------+
-- There is no primary key for this table, it may contain duplicates.
-- This table contains the account id of the user who logged in and the login date. A user may log in multiple times in the day.
 

-- Write an SQL query to find the id and the name of active users.

-- Active users are those who logged in to their accounts for 5 or more consecutive days.

-- Return the result table ordered by the id.

-- The query result format is in the following example:

-- Accounts table:
-- +----+----------+
-- | id | name     |
-- +----+----------+
-- | 1  | Winston  |
-- | 7  | Jonathan |
-- +----+----------+

-- Logins table:
-- +----+------------+
-- | id | login_date |
-- +----+------------+
-- | 7  | 2020-05-30 |
-- | 1  | 2020-05-30 |
-- | 7  | 2020-05-31 |
-- | 7  | 2020-06-01 |
-- | 7  | 2020-06-02 |
-- | 7  | 2020-06-02 |
-- | 7  | 2020-06-03 |
-- | 1  | 2020-06-07 |
-- | 7  | 2020-06-10 |
-- +----+------------+

-- Result table:
-- +----+----------+
-- | id | name     |
-- +----+----------+
-- | 7  | Jonathan |
-- +----+----------+
-- User Winston with id = 1 logged in 2 times only in 2 different days, so, Winston is not an active user.
-- User Jonathan with id = 7 logged in 7 times in 6 different days, five of them were consecutive days, so, Jonathan is an active user.

-- Solution
-- SQLlite

CREATE table accounts
(
id int primary key,
name varchar(20)
);

CREATE table logins
(
id int,
login_date date
);

INSERT into accounts 
values
(1,'Winston'),
(7,'Jonathan')
;

INSERT into logins 
values
(7,'2020-05-30'),
(1,'2020-05-30'),
(7,'2020-05-31'),
(7,'2020-06-01'),
(7,'2020-06-02'),
(7,'2020-06-02'),
(7,'2020-06-03'),
(1,'2020-06-07'),
(7,'2020-06-10');

with t1 as (
SELECT *,lead(login_date,4) over(PARTITION by id order by login_date) as lead_5_date 
FROM 
(select DISTINCT * from logins l)) 

select DISTINCT t2.id,t2.name
from accounts t2 left join t1 on t2.id=t1.id
where t1.lead_5_date NOTNULL ;
