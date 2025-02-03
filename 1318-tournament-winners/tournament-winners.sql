
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
group_info as (
    select 
        player_id,
        group_id,
        dense_rank() over (partition by group_id order by total_score desc, player_id asc) as ranks
    from (
        select 
            a.player_id,
            b.group_id,
            sum(a.score) as total_score
        from 
            base a 
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
    group_info 
where 
    ranks = 1 