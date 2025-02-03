# Write your MySQL query statement below
with pairs as (
    select 
        first_player as player_id,
        first_score as score
    from 
        Matches
    union all
    select 
        second_player as player_id,
        second_score as score
    from 
        Matches
),
rank_info as (
    select 
        group_id,
        player_id,
        dense_rank() over (partition by group_id order by total_score desc, player_id asc) as ranks
    from (
        select 
            a.player_id,
            b.group_id,
            sum(a.score) as total_score
        from 
            pairs a 
        inner join 
            Players b 
        on 
            a.player_id = b.player_id 
        group by 
            a.player_id, b.group_id
    ) a 
)
select 
    group_id,
    player_id
from 
    rank_info 
where 
    ranks = 1