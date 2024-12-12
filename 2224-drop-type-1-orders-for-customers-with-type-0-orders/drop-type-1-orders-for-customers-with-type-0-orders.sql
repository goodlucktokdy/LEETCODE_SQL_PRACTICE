# Write your MySQL query statement below
with base as (
    select 
        order_id,
        customer_id,
        order_type,
        count(case when order_type = 0 then order_id else null end) over (partition by customer_id) as type0,
        count(case when order_type = 1 then order_id else null end) over (partition by customer_id) as type1
    from 
        Orders
)
select 
    distinct
    a.order_id,
    a.customer_id,
    a.order_type
from (
    select 
        order_id,
        customer_id,
        case when type0 > 0 and order_type != 0 then null
            else order_type end as order_type
    from 
        base
) a
where 
    a.order_type is not null