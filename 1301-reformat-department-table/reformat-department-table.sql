# Write your MySQL query statement below
with recursive cte as (
select 
    1 as months
union all 
select 
    a.months + 1
from 
    cte a
where 
    a.months < 12
), months_cte as (
    select 
        a.months,
        b.id,
        b.revenue
    from 
        cte a 
    left join 
        Department b 
    on 
        a.months = case when b.month = 'Jan' then 1 
                        when b.month = 'Feb' then 2
                        when b.month = 'Mar' then 3
                        when b.month = 'Apr' then 4 
                        when b.month = 'May' then 5 
                        when b.month = 'Jun' then 6 
                        when b.month = 'Jul' then 7
                        when b.month = 'Aug' then 8
                        when b.month = 'Sep' then 9
                        when b.month = 'Oct' then 10
                        when b.month = 'Nov' then 11 
                        else 12 end
)
select 
    id,
    sum(case when months = 1 then revenue end) as Jan_Revenue,
    sum(case when months = 2 then revenue end) as Feb_Revenue,
    sum(case when months = 3 then revenue end) as Mar_Revenue,
    sum(case when months = 4 then revenue end) as Apr_Revenue,
    sum(case when months = 5 then revenue end) as May_Revenue,
    sum(case when months = 6 then revenue end) as Jun_Revenue,
    sum(case when months = 7 then revenue end) as Jul_Revenue,
    sum(case when months = 8 then revenue end) as Aug_Revenue,
    sum(case when months = 9 then revenue end) as Sep_Revenue,
    sum(case when months = 10 then revenue end) as Oct_Revenue,
    sum(case when months = 11 then revenue end) as Nov_Revenue,
    sum(case when months = 12 then revenue end) as Dec_Revenue
from 
    months_cte
where 
    id is not null
group by 
    id