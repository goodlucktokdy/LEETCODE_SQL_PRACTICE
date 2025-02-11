# Write your MySQL query statement below
select
    order_date,
    round(100.0*count(distinct case when order_date = customer_pref_delivery_date then delivery_id else null end)/count(distinct delivery_id),2) as immediate_percentage
from 
    Delivery
group by 
    order_date
order by 
    order_date