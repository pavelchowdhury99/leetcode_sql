-- Question 73
-- Table: Actions

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user_id       | int     |
-- | post_id       | int     |
-- | action_date   | date    |
-- | action        | enum    |
-- | extra         | varchar |
-- +---------------+---------+
-- There is no primary key for this table, it may have duplicate rows.
-- The action column is an ENUM type of ('view', 'like', 'reaction', 'comment', 'report', 'share').
-- The extra column has optional information about the action such as a reason for report or a type of reaction. 
-- Table: Removals

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | post_id       | int     |
-- | remove_date   | date    | 
-- +---------------+---------+
-- post_id is the primary key of this table.
-- Each row in this table indicates that some post was removed as a result of being reported or as a result of an admin review.
 

-- Write an SQL query to find the average for daily percentage of posts that got removed after being reported as spam, rounded to 2 decimal places.

-- The query result format is in the following example:

-- Actions table:
-- +---------+---------+-------------+--------+--------+
-- | user_id | post_id | action_date | action | extra  |
-- +---------+---------+-------------+--------+--------+
-- | 1       | 1       | 2019-07-01  | view   | null   |
-- | 1       | 1       | 2019-07-01  | like   | null   |
-- | 1       | 1       | 2019-07-01  | share  | null   |
-- | 2       | 2       | 2019-07-04  | view   | null   |
-- | 2       | 2       | 2019-07-04  | report | spam   |
-- | 3       | 4       | 2019-07-04  | view   | null   |
-- | 3       | 4       | 2019-07-04  | report | spam   |
-- | 4       | 3       | 2019-07-02  | view   | null   |
-- | 4       | 3       | 2019-07-02  | report | spam   |
-- | 5       | 2       | 2019-07-03  | view   | null   |
-- | 5       | 2       | 2019-07-03  | report | racism |
-- | 5       | 5       | 2019-07-03  | view   | null   |
-- | 5       | 5       | 2019-07-03  | report | racism |
-- +---------+---------+-------------+--------+--------+

-- Removals table:
-- +---------+-------------+
-- | post_id | remove_date |
-- +---------+-------------+
-- | 2       | 2019-07-20  |
-- | 3       | 2019-07-18  |
-- +---------+-------------+

-- Result table:
-- +-----------------------+
-- | average_daily_percent |
-- +-----------------------+
-- | 75.00                 |
-- +-----------------------+
-- The percentage for 2019-07-04 is 50% because only one post of two spam reported posts was removed.
-- The percentage for 2019-07-02 is 100% because one post was reported as spam and it was removed.
-- The other days had no spam reports so the average is (50 + 100) / 2 = 75%
-- Note that the output is only one number and that we do not care about the remove dates.

-- Solution
-- SQLlite

CREATE table Actions
(
user_id int,
post_id int,
action_date date,
action_ varchar(50),
extra varchar(50)
);

CREATE table Removals
(
post_id int,
remove_date date
);

INSERT into Actions 
values
(1,1,'2019-07-01','view',null),
(1,1,'2019-07-01','like',null),
(1,1,'2019-07-01','share',null),
(2,2,'2019-07-04','view',null),
(2,2,'2019-07-04','report','spam'),
(3,4,'2019-07-04','view',null),
(3,4,'2019-07-04','report','spam'),
(4,3,'2019-07-02','view',null),
(4,3,'2019-07-02','report','spam'),
(5,2,'2019-07-03','view',null),
(5,2,'2019-07-03','report','racism'),
(5,5,'2019-07-03','view',null),
(5,5,'2019-07-03','report','racism')
;

INSERT into Removals 
values
(2,'2019-07-20'),
(3,'2019-07-18')
;

-- Query starts here
with t1 as 
(
SELECT 
a.post_id,
a.action_date,
a.extra,
case when r.remove_date is null then 0 else 1 end as count_
from Actions a
left join Removals r on
a.post_id = r.post_id
where a.extra='spam'
and a.action_ = 'report'
)

SELECT 
printf("%.2f",AVG(avg_)) as average_daily_percent
from 
(
SELECT 
post_id,
action_date,
extra,
printf("%.2f",AVG(count_)*100) as avg_
from t1 
group by action_date
)
;
