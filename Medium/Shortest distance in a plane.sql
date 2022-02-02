-- Question 89
-- Table point_2d holds the coordinates (x,y) of some unique points (more than two) in a plane.
 

-- Write a query to find the shortest distance between these points rounded to 2 decimals.
 

-- | x  | y  |
-- |----|----|
-- | -1 | -1 |
-- | 0  | 0  |
-- | -1 | -2 |
 

-- The shortest distance is 1.00 from point (-1,-1) to (-1,2). So the output should be:
 

-- | shortest |
-- |----------|
-- | 1.00     |
 

-- Note: The longest distance among all the points are less than 10000.

-- Solution
-- SQLlite
CREATE table coordinates
(
x int,
y int
);

INSERT into coordinates 
values
(-1,-1),
(0,0),
(-1,-2)
;

-- Query starts here

SELECT 
min(shortest) shortest
from 
(SELECT 
SQRT(POWER(abs(c1.x-c2.x),2)+POWER(abs(c1.y-c2.y),2)) as shortest
from coordinates c1,coordinates c2
where not(c1.x=c2.x and c1.y=c2.y)) t
;
