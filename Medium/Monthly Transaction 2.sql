-- Question 95
-- Table: Transactions

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | id             | int     |
-- | country        | varchar |
-- | state          | enum    |
-- | amount         | int     |
-- | trans_date     | date    |
-- +----------------+---------+
-- id is the primary key of this table.
-- The table has information about incoming transactions.
-- The state column is an enum of type ["approved", "declined"].
-- Table: Chargebacks

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | trans_id       | int     |
-- | charge_date    | date    |
-- +----------------+---------+
-- Chargebacks contains basic information regarding incoming chargebacks from some transactions placed in Transactions table.
-- trans_id is a foreign key to the id column of Transactions table.
-- Each chargeback corresponds to a transaction made previously even if they were not approved.
 

-- Write an SQL query to find for each month and country, the number of approved transactions and their total amount, the number of chargebacks and their total amount.

-- Note: In your query, given the month and country, ignore rows with all zeros.

-- The query result format is in the following example:

-- Transactions table:
-- +------+---------+----------+--------+------------+
-- | id   | country | state    | amount | trans_date |
-- +------+---------+----------+--------+------------+
-- | 101  | US      | approved | 1000   | 2019-05-18 |
-- | 102  | US      | declined | 2000   | 2019-05-19 |
-- | 103  | US      | approved | 3000   | 2019-06-10 |
-- | 104  | US      | approved | 4000   | 2019-06-13 |
-- | 105  | US      | approved | 5000   | 2019-06-15 |
-- +------+---------+----------+--------+------------+

-- Chargebacks table:
-- +------------+------------+
-- | trans_id   | trans_date |
-- +------------+------------+
-- | 102        | 2019-05-29 |
-- | 101        | 2019-06-30 |
-- | 105        | 2019-09-18 |
-- +------------+------------+

-- Result table:
-- +----------+---------+----------------+-----------------+-------------------+--------------------+
-- | month    | country | approved_count | approved_amount | chargeback_count  | chargeback_amount  |
-- +----------+---------+----------------+-----------------+-------------------+--------------------+
-- | 2019-05  | US      | 1              | 1000            | 1                 | 2000               |
-- | 2019-06  | US      | 3              | 12000           | 1                 | 1000               |
-- | 2019-09  | US      | 0              | 0               | 1                 | 5000               |
-- +----------+---------+----------------+-----------------+-------------------+--------------------+

-- Solution
-- SQLLite

CREATE table Transactions
(
id int,
country varchar(50),
state varchar(50),
amount int,
trans_date date
);

CREATE table Chargebacks
(
trans_id int,
charge_date date
);

insert into Transactions
values
(101,'US','approved',1000,'2019-05-18'),
(102,'US','declined',2000,'2019-05-19'),
(103,'US','approved',3000,'2019-06-10'),
(104,'US','approved',4000,'2019-06-13'),
(105,'US','approved',5000,'2019-06-15')
;


insert into Chargebacks
values
(102,'2019-05-29'),
(101,'2019-06-30'),
(105,'2019-09-18')
;


-- Query starts here

with approved_count as 
(
select strftime("%Y-%m",trans_date) as month,
country,
count(state) as approved_count,
sum(amount) as approved_amount
from transactions 
where state='approved'
group by strftime("%Y-%m",trans_date),country
)

,chargeback_count as 
(
select strftime("%Y-%m",c.charge_date) as month,
t.country,
count(state) as chargeback_count,
sum(amount) as chargeback_amount
from Chargebacks c
join Transactions t on c.trans_id = t.id
group by strftime("%Y-%m",c.charge_date)
)


select 
c.month,
COALESCE (a.country,c.country),
COALESCE (a.approved_count,0),
COALESCE (a.approved_amount,0),
COALESCE (c.chargeback_count,0),
COALESCE (c.chargeback_amount,0)
from
(select month from approved_count a 
union
select month from chargeback_count) x
left join approved_count a on x.month=a.month
left join chargeback_count c on x.month=c.month;


