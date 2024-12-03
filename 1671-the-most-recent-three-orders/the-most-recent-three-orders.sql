with base as (
    select
        distinct
        a.customer_id,
        b.name,
        a.order_date,
        a.order_id,
        count(a.order_id) over (partition by a.customer_id) as per_user_orders,
        dense_rank() over (partition by a.customer_id order by a.order_date desc) as recent_orders
    from 
        Orders a
    inner join 
        Customers b
    on 
        a.customer_id = b.customer_id
)
select
    name as customer_name,
    customer_id,
    order_id,
    order_date
from
    base
where 
    recent_orders <= 3
order by 
    customer_name asc, customer_id asc, order_date desc

