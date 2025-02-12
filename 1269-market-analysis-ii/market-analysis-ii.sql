# Write your MySQL query statement below
select 
    a.user_id as seller_id,
    if(b.item_brand is null,'no','yes') as 2nd_item_fav_brand
from 
    Users a 
left join (
    select 
        a.seller_id,
        b.item_brand,
        dense_rank() over (partition by a.seller_id order by a.order_date) as rnums
    from 
        Orders a 
    inner join 
        Items b 
    on 
        a.item_id = b.item_id
) b
on 
    a.user_id = b.seller_id and a.favorite_brand = b.item_brand and b.rnums = 2