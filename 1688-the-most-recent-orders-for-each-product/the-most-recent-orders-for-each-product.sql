# Write your MySQL query statement below
select 
    product_name,
    product_id,
    order_id,
    order_date
from (
    select 
        a.product_name,
        a.product_id,
        b.order_id,
        b.order_date,
        dense_rank() over (partition by a.product_id order by b.order_date desc) as rnums
    from 
        Products a 
    inner join 
        Orders b
    on 
        a.product_id = b.product_id
) c
where 
    rnums = 1
order by 
    product_name, product_id, order_id