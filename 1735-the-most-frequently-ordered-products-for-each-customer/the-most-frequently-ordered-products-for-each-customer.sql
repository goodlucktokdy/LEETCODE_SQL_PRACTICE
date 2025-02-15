# Write your MySQL query statement below
with base as (
    select 
        customer_id,
        product_id,
        product_name,
        dense_rank() over (partition by customer_id order by cnts desc) as ranks
    from (
        select 
            a.customer_id,
            a.product_id,
            b.product_name,
            count(a.order_id) over (partition by a.customer_id,a.product_id) as cnts
        from 
            Orders a 
        inner join 
            Products b 
        on 
            a.product_id = b.product_id
    ) c
)
select 
    distinct
    customer_id,
    product_id,
    product_name
from 
    base 
where 
    ranks = 1