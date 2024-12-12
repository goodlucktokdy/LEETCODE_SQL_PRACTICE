# Write your MySQL query statement below
select 
    extract(week from a.purchase_date) - extract(week from '2023-11-01') + 1 as week_of_month,
    a.purchase_date,
    sum(a.amount_spend) as total_amount
from (
    select
        user_id,
        purchase_date,
        amount_spend
    from 
        Purchases 
    where 
        year(purchase_date) = 2023 and month(purchase_date) = 11
        and weekday(purchase_date) = 4
) a 
group by 
    1,2
order by 
    week_of_month 