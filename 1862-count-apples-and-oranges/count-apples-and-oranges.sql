# Write your MySQL query statement below
select 
    sum(apple_count + chest_apple) as apple_count,
    sum(orange_count + chest_orange) as orange_count
from (
    select 
        a.box_id,
        a.chest_id,
        a.apple_count,
        a.orange_count,
        coalesce(b.apple_count,0) as chest_apple,
        coalesce(b.orange_count,0) as chest_orange
    from 
        Boxes a 
    left join 
        Chests b 
    on 
        a.chest_id = b.chest_id 
) a