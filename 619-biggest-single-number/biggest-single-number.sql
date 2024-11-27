# Write your MySQL query statement below
with base as (
    select 
        num,
        count(num) as cnt_num
    from 
        MyNumbers
    group by 
        num
    having 
        cnt_num = 1
) 
select 
    case when (select count(num) from base) = 0 then null
    else max(num) end as num
from 
    base