# Write your MySQL query statement below
with base as (
    select 
        a.seller_id,
        b.item_brand,
        count(distinct a.item_id) as cnts
    from 
        Orders a 
    inner join 
        Items b 
    on 
        a.item_id = b.item_id
    group by 
        a.seller_id, b.item_brand
),
ranks_cte as (
    select 
        seller_id,
        sums,
        dense_rank() over (order by sums desc) as ranks
    from (
        select 
            seller_id,
            sum(cnts) as sums 
        from 
            base a
        where exists 
            (select 1 from Users b
                where a.seller_id = b.seller_id and a.item_brand != b.favorite_brand)
        group by 
            seller_id
    ) a
)
select 
    seller_id,
    sums as num_items
from 
    ranks_cte
where 
    ranks = 1
order by 
    seller_id