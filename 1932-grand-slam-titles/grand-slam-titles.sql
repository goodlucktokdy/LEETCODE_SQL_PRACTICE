# Write your MySQL query statement below
with slams as (
    select 
        Wimbledon as grand_slams
    from 
        Championships
    union all
    select 
        Fr_open as grand_slams
    from
        Championships
    union all
    select 
        US_open as grand_slams
    from
        Championships
    union all
    select 
        Au_open as grand_slams
    from 
        Championships
)
select 
    a.player_id,
    a.player_name,
    count(b.grand_slams) as grand_slams_count
from 
    Players a 
inner join 
    slams b 
on 
    a.player_id = b.grand_slams
group by 
    a.player_id, a.player_name