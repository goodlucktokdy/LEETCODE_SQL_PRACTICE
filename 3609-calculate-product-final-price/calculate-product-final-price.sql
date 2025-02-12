# Write your MySQL query statement below
select 
    a.product_id as product_id,
    a.price * (100-coalesce(b.discount,0)) * 0.01 as final_price,
    a.category
from 
    Products a 
left join 
    Discounts b 
on 
    a.category = b.category
order by 
    product_id