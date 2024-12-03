select
    a.name,
    a.distance as travelled_distance
from (
    select
        a.id,
        a.name,
        ifnull(sum(b.distance),0) as distance
    from 
        Users a
    left join
        Rides b
    on
        a.id = b.user_id
    group by 
        a.id, a.name
) a
order by
    travelled_distance desc, a.name asc