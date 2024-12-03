with base as (
    select
        Wimbledon as id from Championships
        union all
    select
        Fr_open as id from Championships
        union all
    select
        US_open as id from Championships
        union all
    select
        Au_open as id from Championships
)
select
    a.player_id,
    a.player_name,
    count(b.id) as grand_slams_count
from 
    Players a
inner join
    base b
on 
    a.player_id = b.id
group by
    1,2