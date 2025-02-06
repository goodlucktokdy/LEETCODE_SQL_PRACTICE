# Write your MySQL query statement below
with base as (
    select 
        num,
        count(num) over (partition by num, sess) as cnts
    from (
        select 
            id,
            num,
            id - cast(row_number() over (partition by num order by id) as real) as sess
        from 
            Logs
    ) a
)
select 
    distinct 
    coalesce(num, null) as ConsecutiveNums
from 
    base 
where 
    cnts >= 3