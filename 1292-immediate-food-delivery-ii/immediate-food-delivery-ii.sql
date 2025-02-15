# Write your MySQL query statement below
select 
    round(100.0*count(distinct case when first_order = customer_pref_delivery_date then customer_id else null end)/count(distinct customer_id),2) as immediate_percentage
from (
    select 
        delivery_id,
        customer_id,
        min(order_date) over (partition by customer_id) as first_order,
        customer_pref_delivery_date
    from 
        Delivery
) a
