# Write your MySQL query statement below
with base as (
    select 
        a.seller_id,
        b.item_brand,
        count(distinct a.item_id) as num_items
    from 
        Orders a 
    inner join 
        Items b 
    on 
        a.item_id = b.item_id 
    group by 
        a.seller_id, b.item_brand
),
ranks_info as (
    select 
        seller_id,
        num_items,
        dense_rank() over (order by num_items desc) as ranks
    from (
        select 
            seller_id,
            sum(num_items) as num_items
        from 
            base 
        where 
            (seller_id,item_brand) not in (select seller_id, favorite_brand from Users)
        group by 
            seller_id
    ) a
)
select 
    seller_id,
    num_items
from 
    ranks_info 
where 
    ranks = 1
order by 
    seller_id