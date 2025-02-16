# Write your MySQL query statement below
select 
    sum(apple_count) as apple_count,
    sum(orange_count) as orange_count
from (
    select 
        a.box_id,
        b.chest_id,
        a.apple_count + coalesce(b.apple_count,0) as apple_count,
        a.orange_count + coalesce(b.orange_count,0) as orange_count
    from 
        Boxes a 
    left join 
        Chests b 
    on 
        a.chest_id = b.chest_id
) a