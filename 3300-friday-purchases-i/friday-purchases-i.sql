# Write your MySQL query statement below
select 
    week(purchase_date) - week('2023-11-01') + 1 as week_of_month,
    purchase_date,
    sum(amount_spend) as total_amount
from 
    Purchases
where 
    weekday(purchase_date) = 4
group by 
    week_of_month, purchase_date
order by 
    week_of_month 