# Write your MySQL query statement below
with base as (
    select 
        order_id,
        order_avg,
        max_quantity
    from (
        select 
            order_id,
            max(quantity) as max_quantity,
            sum(quantity)/count(distinct product_id) as order_avg
        from 
            OrdersDetails
        group by 
            order_id
    ) a
)
select 
    distinct 
    order_id
from 
    base 
where 
    max_quantity > (select max(order_avg) from base)
