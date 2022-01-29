-- Question 90
-- Table: Sales

-- +-------------+-------+
-- | Column Name | Type  |
-- +-------------+-------+
-- | sale_id     | int   |
-- | product_id  | int   |
-- | year        | int   |
-- | quantity    | int   |
-- | price       | int   |
-- +-------------+-------+
-- sale_id is the primary key of this table.
-- product_id is a foreign key to Product table.
-- Note that the price is per unit.
-- Table: Product

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | product_id   | int     |
-- | product_name | varchar |
-- +--------------+---------+
-- product_id is the primary key of this table.
 

-- Write an SQL query that selects the product id, year, quantity, and price for the first year of every product sold.

-- The query result format is in the following example:

-- Sales table:
-- +---------+------------+------+----------+-------+
-- | sale_id | product_id | year | quantity | price |
-- +---------+------------+------+----------+-------+ 
-- | 1       | 100        | 2008 | 10       | 5000  |
-- | 2       | 100        | 2009 | 12       | 5000  |
-- | 7       | 200        | 2011 | 15       | 9000  |
-- +---------+------------+------+----------+-------+

-- Product table:
-- +------------+--------------+
-- | product_id | product_name |
-- +------------+--------------+
-- | 100        | Nokia        |
-- | 200        | Apple        |
-- | 300        | Samsung      |
-- +------------+--------------+

-- Result table:
-- +------------+------------+----------+-------+
-- | product_id | first_year | quantity | price |
-- +------------+------------+----------+-------+ 
-- | 100        | 2008       | 10       | 5000  |
-- | 200        | 2011       | 15       | 9000  |
-- +------------+------------+----------+-------+

-- Solution
-- SQLlite

create table Sales
(
sales_id int,
product_id int,
year_ int,
quantity int,
price int
);

create table Product
(
product_id int,
product_name varchar(50)
);

insert into Sales
values
(1,100,2008,10, 5000),
(2,100,2009,12, 5000),
(7,200,2011,15, 9000)
;

insert into Product
values
(100,'Nokia  '),
(200,'Apple  '),
(300,'Samsung')
;

-- Query starts here
with t1 as 
(
select 
p.product_id,
year_ as first_year,
quantity,
price,
rank() over (partition by p.product_id order by year_) as rn
from Product p 
join Sales s 
on p.product_id = s.product_id
)

SELECT 
product_id,
first_year,
quantity,
price
from t1
where rn=1
;

