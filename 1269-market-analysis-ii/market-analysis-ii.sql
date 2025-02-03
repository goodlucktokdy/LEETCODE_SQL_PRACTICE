
    
with base as (
    select 
        a.seller_id,
        b.item_brand,
        row_number() over (partition by a.seller_id order by a.order_date) as rnums
    from 
        Orders a 
    inner join 
        Items b 
    on 
        a.item_id = b.item_id
)
select 
    u.user_id as seller_id,
    if(b.item_brand is null,'no','yes') as 2nd_item_fav_brand
from 
    Users u
left join (
    select 
        seller_id,
        item_brand
    from 
        base a 
    where exists 
        (select 1 from Users u 
            where a.seller_id = u.user_id and a.rnums = 2 and a.item_brand = u.favorite_brand)
) b 
on
    u.user_id = b.seller_id