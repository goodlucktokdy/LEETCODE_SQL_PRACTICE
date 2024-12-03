with base as (
    select
        a.order_id,
        a.customer_id,
        a.product_id,
        b.product_name,
        c.name
    from 
        Orders a
    left join
        Products b
    on
        a.product_id = b.product_id
    inner join
        Customers c
    on
        a.customer_id = c.customer_id
), mid_cte as (
    select
        a.customer_id,
        a.product_name,
        a.product_id,
        dense_rank() over (partition by a.customer_id order by a.order_cnts desc) as ranks
    from (
        select
            distinct
            customer_id,
            count(order_id) over (partition by customer_id,product_id) as order_cnts,
            product_name,
            product_id
        from 
            base
    ) a
)
select
    distinct
    customer_id,
    product_id,
    product_name
from 
    mid_cte
where 
    ranks = 1