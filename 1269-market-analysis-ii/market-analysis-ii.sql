# Write your MySQL query statement below
with sales_info as (
    select 
        a.order_date,
        b.item_brand,
        a.seller_id,
        row_number() over (partition by a.seller_id order by a.order_date) as rnums
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
left join (
    select 
        order_date,
        item_brand,
        seller_id
    from 
        sales_info a
    where exists 
        (select 1 from Users b 
            where a.seller_id = b.user_id and a.rnums = 2 and a.item_brand = b.favorite_brand)
) b 
on 
    a.user_id = b.seller_id