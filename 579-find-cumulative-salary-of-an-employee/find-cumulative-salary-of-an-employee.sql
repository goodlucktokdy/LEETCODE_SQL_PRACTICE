# Write your MySQL query statement below
select 
    id,
    month,
    sum(salary) over (partition by id order by month range between 2 preceding and 0 following) as salary
from (
    select 
        id,
        month,
        salary,
        dense_rank() over (partition by id order by month desc) as month_ranks 
    from 
        Employee 
) a 
where 
    month_ranks > 1
order by 
    id asc,month desc