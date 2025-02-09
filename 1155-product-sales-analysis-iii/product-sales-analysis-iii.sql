# Write your MySQL query statement below
select 
    product_id,
    year as first_year,
    quantity,
    price
from (
    select 
        product_id,
        year,
        quantity,
        price,
        dense_rank() over (partition by product_id order by year asc) as ranks
    from 
        Sales
) a
where 
    ranks = 1