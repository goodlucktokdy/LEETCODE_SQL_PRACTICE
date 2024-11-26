# Write your MySQL query statement below
with base as (
    select 
        a.delivery_id,
        a.customer_id,
        case when a.customer_pref_delivery_date = a.first_order_date then 'immediate' else 'scheduled'
        end as schedules
    from (
        select 
            delivery_id,
            customer_id,
            min(order_date) over (partition by customer_id) as first_order_date,
            order_date,
            customer_pref_delivery_date
        from 
            Delivery
    ) a
    where 
        a.first_order_date = a.order_date
)
select 
    round(100.0*count(distinct case when schedules = 'immediate' then customer_id end)/count(distinct customer_id),2) as immediate_percentage
from 
    base 
