# Write your MySQL query statement below
select 
    product_name,
    product_id,
    order_id,
    order_date
from (
    select 
        b.product_name,
        b.product_id,
        a.order_id,
        a.order_date,
        dense_rank() over (partition by a.product_id order by a.order_date desc) as ranks
    from 
        Orders a 
    inner join 
        Products b 
    on 
        a.product_id = b.product_id
) a
where 
    ranks = 1
order by 
    product_name asc, product_id asc, order_id asc
