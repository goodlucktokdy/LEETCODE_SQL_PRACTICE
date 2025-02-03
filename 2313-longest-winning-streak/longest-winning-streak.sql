# Write your MySQL query statement below
with base as (
    select 
        player_id,
        match_day,
        result,
        row_number() over (partition by player_id order by match_day) - row_number() over (partition by player_id, result order by match_day) as sess
    from 
        Matches
)
select 
    a.player_id as player_id,
    max(coalesce(b.streaks,0)) as longest_streak
from 
    Matches a 
left join (
    select 
        player_id,
        count(distinct match_day) as streaks
    from 
        base
    where 
        result = 'Win'
    group by 
        player_id, sess
) b 
on 
    a.player_id = b.player_id
group by 
    player_id