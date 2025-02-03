# Write your MySQL query statement below
with base as (
    select 
        a.team_name as pass_from,
        cast(replace(b.time_stamp,':','.') as real) as time_stamp,
        c.team_name as pass_to
    from 
        Teams a 
    inner join 
        Passes b 
    on 
        a.player_id = b.pass_from
    inner join 
        Teams c 
    on 
        b.pass_to = c.player_id
),
team_streaks_info as (
    select 
        pass_from as team_name,
        count(distinct time_stamp) as streaks
    from (
        select 
            pass_from,
            time_stamp,
            pass_to,
            row_number() over (partition by pass_from order by time_stamp) - row_number() over (partition by pass_from, pass_to order by time_stamp) as sess
        from 
            base
    ) a 
    where 
        pass_from = pass_to
    group by 
        team_name, sess
)
select 
    team_name,
    max(streaks) as longest_streak
from 
    team_streaks_info
group by 
    team_name
order by 
    team_name