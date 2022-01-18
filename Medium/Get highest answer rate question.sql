-- Question 86
-- Get the highest answer rate question from a table survey_log with these columns: id, action, question_id, answer_id, q_num, timestamp.

-- id means user id; action has these kind of values: "show", "answer", "skip"; answer_id is not null when action column is "answer", 
-- while is null for "show" and "skip"; q_num is the numeral order of the question in current session.

-- Write a sql query to identify the question which has the highest answer rate.

-- Example:

-- Input:
-- +------+-----------+--------------+------------+-----------+------------+
-- | id   | action    | question_id  | answer_id  | q_num     | timestamp  |
-- +------+-----------+--------------+------------+-----------+------------+
-- | 5    | show      | 285          | null       | 1         | 123        |
-- | 5    | answer    | 285          | 124124     | 1         | 124        |
-- | 5    | show      | 369          | null       | 2         | 125        |
-- | 5    | skip      | 369          | null       | 2         | 126        |
-- +------+-----------+--------------+------------+-----------+------------+
-- Output:
-- +-------------+
-- | survey_log  |
-- +-------------+
-- |    285      |
-- +-------------+
-- Explanation:
-- question 285 has answer rate 1/1, while question 369 has 0/1 answer rate, so output 285.
 

-- Note: The highest answer rate meaning is: answer number's ratio in show number in the same question.

-- Solution
-- SQLlite

CREATE table survey_log
(
id int,
action varchar(50),
question_id int,
answer_id int,
q_num int,
timestamp int
);

INSERT into survey_log 
values
(5,'show',285,null , 1,123),
(5,'answer',285,124124, 1,124),
(5,'show',369,null , 2,125),
(5,'skip',369,null, 2,126)
;

with t1 as 
(SELECT 
question_id,count(*) as ans_count
from survey_log
where action='answer'
group by question_id)

,t2 as 
(SELECT 
question_id,count(*) as show_count
from survey_log
where action='show'
group by question_id)

,t3 as 
(
select distinct question_id from survey_log
)


select
question_id as survey_log
FROM 
(select
*,
rank() over(order by rate DESC) as N
from
(SELECT 
t3.question_id,COALESCE(ans_count,0)/COALESCE(show_count,1) as rate
from t3
left join t1 on 
t1.question_id=t3.question_id
left join t2 on 
t2.question_id=t3.question_id
)) where N=1;
;

