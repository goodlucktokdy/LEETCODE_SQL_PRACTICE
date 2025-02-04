# Write your MySQL query statement below
with base as (
    select 
        a.seller_id,
        dense_rank() over (partition by a.seller_id order by a.order_date) as rnums,
        b.item_brand
    from 
        Orders a 
    inner join 
        Items b 
    on 
        a.item_id = b.item_id
)
select 
    a.user_id as seller_id,
    if(b.item_brand is null,'no','yes') as 2nd_item_fav_brand
from 
    Users a 
left join 
    base b 
on 
    a.user_id = b.seller_id and b.rnums = 2 and a.favorite_brand = b.item_brand