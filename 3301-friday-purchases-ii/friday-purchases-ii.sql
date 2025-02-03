# Write your MySQL query statement below
with recursive cte as (
    select 
        '2023-11-01' as dates
    union all
    select 
        date_add(cte.dates,interval 1 day) as dates
    from 
        cte 
    where 
        cte.dates < date_sub('2023-12-01',interval 1 day)
)
select 
    week(a.dates) - week('2023-11-01') + 1 as week_of_month,
    a.dates as purchase_date,
    sum(coalesce(b.amount_spend,0)) as total_amount
from 
    cte a 
left join 
    Purchases b 
on 
    a.dates = b.purchase_date
where 
    weekday(a.dates) = 4
group by 
    week_of_month, purchase_date
order by 
    week_of_month asc