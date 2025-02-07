# Write your MySQL query statement below
with base as (
    select 
        order_id,
        max(quantity) as max_quantity,
        sum(quantity)/count(product_id) as avg_quantity
    from
        OrdersDetails
    group by 
        order_id
)
select 
    distinct 
    order_id
from (
    select 
        order_id,
        max_quantity,
        avg_quantity,
        max(avg_quantity) over () as max_avg
    from 
        base
) a 
where 
    max_quantity > max_avg
