# Write your MySQL query statement below
select
    a.product_name,
    a.year,
    a.price
from (
    select 
        a.sale_id,
        a.product_id,
        b.product_name,
        a.year,
        a.price
    from 
        Sales a
    left join
        Product b 
    on 
        a.product_id = b.product_id
) a