# Write your MySQL query statement below
select 
    team_id,
    name,
    cast(og_ranks as real)- cast(new_ranks as real) as rank_diff
from (
    select 
        a.team_id,
        a.name,
        dense_rank() over (order by a.points desc, a.name asc) as og_ranks,
        dense_rank() over (order by a.points + coalesce(b.points_change) desc, a.name asc) as new_ranks
    from 
        TeamPoints a 
    left join 
        PointsChange b 
    on 
        a.team_id = b.team_id
) a
