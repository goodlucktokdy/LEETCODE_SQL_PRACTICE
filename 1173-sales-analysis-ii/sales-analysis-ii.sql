# Write your MySQL query statement below
with base as (
    select 
        case when a.product_name = 'S8' then 1 else 0 end as S8,
        case when a.product_name = 'iPhone' then 1 else 0 end as iphone,
        b.buyer_id
    from 
        Product a 
    left join 
        Sales b 
    on 
        a.product_id = b.product_id 
)
select 
    buyer_id
from 
    base
group by 
    buyer_id
having 
    sum(s8) != 0 and sum(iphone) = 0