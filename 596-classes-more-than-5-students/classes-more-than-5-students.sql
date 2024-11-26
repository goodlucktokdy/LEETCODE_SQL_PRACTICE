# Write your MySQL query statement below
select
    distinct
    a.class
from (
    select 
        class,
        count(distinct student) as cnts
    from 
        Courses
    group by 
        class
    having
        cnts >= 5
) a