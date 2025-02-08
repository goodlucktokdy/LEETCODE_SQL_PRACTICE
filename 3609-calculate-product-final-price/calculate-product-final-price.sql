# Write your MySQL query statement below
select 
    a.product_id,
    case when b.category is not null then a.price * (100 - b.discount) * 0.01 else a.price end as final_price,
    a.category
from 
    Products a 
left join 
    Discounts b 
on 
    a.category = b.category
order by 
    a.product_id asc 