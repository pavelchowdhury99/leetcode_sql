-- Question 109
-- Table: UserActivity

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | username      | varchar |
-- | activity      | varchar |
-- | startDate     | Date    |
-- | endDate       | Date    |
-- +---------------+---------+
-- This table does not contain primary key.
-- This table contain information about the activity performed of each user in a period of time.
-- A person with username performed a activity from startDate to endDate.

-- Write an SQL query to show the second most recent activity of each user.

-- If the user only has one activity, return that one. 

-- A user can't perform more than one activity at the same time. Return the result table in any order.

-- The query result format is in the following example:

-- UserActivity table:
-- +------------+--------------+-------------+-------------+
-- | username   | activity     | startDate   | endDate     |
-- +------------+--------------+-------------+-------------+
-- | Alice      | Travel       | 2020-02-12  | 2020-02-20  |
-- | Alice      | Dancing      | 2020-02-21  | 2020-02-23  |
-- | Alice      | Travel       | 2020-02-24  | 2020-02-28  |
-- | Bob        | Travel       | 2020-02-11  | 2020-02-18  |
-- +------------+--------------+-------------+-------------+

-- Result table:
-- +------------+--------------+-------------+-------------+
-- | username   | activity     | startDate   | endDate     |
-- +------------+--------------+-------------+-------------+
-- | Alice      | Dancing      | 2020-02-21  | 2020-02-23  |
-- | Bob        | Travel       | 2020-02-11  | 2020-02-18  |
-- +------------+--------------+-------------+-------------+

-- The most recent activity of Alice is Travel from 2020-02-24 to 2020-02-28, before that she was dancing from 2020-02-21 to 2020-02-23.
-- Bob only has one record, we just take that one.

-- Solution
-- SQLlite
CREATE table UserActivity
(
username varchar(50),
activity varchar(50),
startDate date,
endDate date
);

INSERT into UserActivity 
values
('Alice','Travel ','2020-02-12','2020-02-20'),
('Alice','Dancing','2020-02-21','2020-02-23'),
('Alice','Travel ','2020-02-24','2020-02-28'),
('Bob  ','Travel ','2020-02-11','2020-02-18')
;

with t1 as 
(SELECT 
*,
rank() over(partition by username order by enddate desc,startDate desc) as rank_
from UserActivity)

select 
distinct  username,activity,startDate,endDate  from t1 where rank_=2
UNION 
select distinct username,activity,startDate,endDate from t1 
group by username
having max(rank_)=1
