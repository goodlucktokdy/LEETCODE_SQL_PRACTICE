# Write your MySQL query statement below
with base as (
    select 
        Wimbledon as winners
    from 
        Championships
    union all
    select
        Fr_open
    from 
        Championships
    union all
    select
        US_open
    from 
        Championships
    union all
    select 
        Au_open
    from 
        Championships
)
select 
    winners as player_id,
    player_name,
    count(player_name) as grand_slams_count
from (
    select 
        a.winners,
        b.player_name
    from 
        base a 
    inner join 
        Players b 
    on 
        a.winners = b.player_id
) a
group by 
    winners, player_name