# Write your MySQL query statement below
with base as (
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
group_rank_info as (
    select 
        group_id,
        player_id,
        dense_rank() over (partition by group_id order by score desc, player_id asc) as ranks
    from (
        select 
            b.group_id as group_id,
            a.player_id as player_id,
            sum(a.score) as score
        from 
            base a 
        inner join 
            Players b 
        on 
            a.player_id = b.player_id
        group by 
            group_id, player_id
    ) a
)
select 
    group_id,
    player_id
from 
    group_rank_info
where 
    ranks = 1