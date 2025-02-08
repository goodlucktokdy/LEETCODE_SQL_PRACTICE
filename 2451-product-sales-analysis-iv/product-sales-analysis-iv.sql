# Write your MySQL query statement below
with base as (
    select 
        user_id,
        product_id,
        dense_rank() over (partition by user_id order by price desc) as ranks
    from (
        select 
            a.user_id,
            a.product_id,
            sum(a.quantity * b.price) as price
        from 
            Sales a 
        inner join 
            Product b 
        on 
            a.product_id = b.product_id 
        group by 
            a.user_id, a.product_id
    ) a
)
select 
    user_id,
    product_id
from 
    base 
where 
    ranks = 1