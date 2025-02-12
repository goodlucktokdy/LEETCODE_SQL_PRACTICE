# Write your MySQL query statement below
with recursive cte as (
    select 
        '2023-11-01' as dates,
        'Premium' as membership
    union all
    select 
        date_add(cte.dates,interval 1 day) as dates,
        'VIP' as membership
    from 
        cte 
    where 
        cte.dates < date_sub('2023-12-01',interval 1 day)
),
base as (
    select 
        distinct
        week(a.dates) - week('2023-11-01') + 1 as week_of_month,
        b.membership
    from 
        cte a 
    cross join 
        cte b 
    where 
        weekday(a.dates) = 4
),
user_sales_info as (
    select 
        week(a.purchase_date) - week('2023-11-01') + 1 as week_of_month,
        b.membership,
        sum(a.amount_spend) as total_amount
    from 
        Purchases a 
    inner join 
        Users b 
    on 
        a.user_id = b.user_id 
    where 
        weekday(a.purchase_date) = 4
    group by 
        week(a.purchase_date) - week('2023-11-01') + 1, b.membership
)
select 
    a.week_of_month as week_of_month,
    a.membership as membership, 
    coalesce(b.total_amount,0) as total_amount
from 
    base a 
left join 
    user_sales_info b 
on 
    a.week_of_month = b.week_of_month and a.membership = b.membership
order by 
    week_of_month, membership