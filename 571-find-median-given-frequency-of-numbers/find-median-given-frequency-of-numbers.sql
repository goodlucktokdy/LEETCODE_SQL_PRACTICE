# Write your MySQL query statement below
with recursive cte as (
    select 
        num,
        1 as frequency 
    from 
        Numbers
    union all
    select 
        a.num,
        cte.frequency + 1 
    from 
        Numbers a 
    inner join 
        cte 
    on 
        a.num = cte.num
    where 
        cte.frequency < a.frequency 
)
select 
    round(avg(num),1) as median
from (
    select 
        num,
        row_number() over (order by num) as rnums,
        count(num) over () as cnts
    from 
        cte
) a 
where 
    rnums between cnts/2 and cnts/2 + 1