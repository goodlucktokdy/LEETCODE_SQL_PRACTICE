# Write your MySQL query statement below
with base as (
    select 
        id,
        num,
        lead(num) over (order by id) as lead1,
        lead(num,2) over (order by id) as lead2
    from 
        Logs
)
select 
    distinct 
    num as ConsecutiveNums
from 
    base 
where 
    num = lead1 and lead1 = lead2