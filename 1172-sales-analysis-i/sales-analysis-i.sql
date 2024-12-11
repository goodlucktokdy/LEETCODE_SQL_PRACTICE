# Write your MySQL query statement below
with base as (
    select 
        a.seller_id,
        dense_rank() over (order by a.sum_sales desc) as ranking
    from (
        select 
            seller_id,
            sum(price) as sum_sales
        from 
            Sales
        group by
            1
    ) a 
)
select 
    seller_id
from 
    base 
where 
    ranking = 1