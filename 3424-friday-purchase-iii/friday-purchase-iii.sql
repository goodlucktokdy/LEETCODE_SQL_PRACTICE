# Write your MySQL query statement below
with recursive cte as (
    select 
        '2023-11-01' as dates
    union all
    select 
        date_add(cte.dates, interval 1 day) as dates
    from 
        cte 
    where 
        cte.dates < date_sub('2023-12-01',interval 1 day)
),
weeks_cte as (
    select 
        week(dates) - week('2023-11-01') + 1 as week_of_month,
        'VIP' as membership
    from 
        cte
    where 
        weekday(dates) = 4
    union
    select 
        week(dates) - week('2023-11-01') + 1 as week_of_month,
        'Premium' as membership
    from 
        cte
    where 
        weekday(dates) = 4
),
dates_cte as (
    select 
        week(a.purchase_date) - week('2023-11-01') + 1 as week_of_month,
        b.membership,
        sum(amount_spend) as total_amount
    from 
        Purchases a 
    inner join 
        Users b 
    on 
        a.user_id = b.user_id 
    where 
        b.membership in ('Premium','VIP') and weekday(a.purchase_date) = 4
    group by 
        week_of_month, b.membership
)
select 
    a.week_of_month as week_of_month,
    a.membership as membership,
    coalesce(b.total_amount,0) as total_amount
from 
    weeks_cte a 
left join 
    dates_cte b 
on 
    a.week_of_month = b.week_of_month and a.membership = b.membership
order by 
    week_of_month, membership