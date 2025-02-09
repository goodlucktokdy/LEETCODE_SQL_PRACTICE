# Write your MySQL query statement below
select 
    distinct
    num as ConsecutiveNums
from (
    select 
        id,
        num,
        cast(row_number() over (partition by num order by id) as real) - row_number() over (order by id) as sess
    from 
        Logs
) a
group by 
    sess, num
having 
    count(distinct id) >= 3