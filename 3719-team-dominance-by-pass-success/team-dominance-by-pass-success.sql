with base as (
    select 
        a.team_name as from_team,
        cast(replace(b.time_stamp,':','.') as real) as time_stamp,
        c.team_name as to_team
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
)
select 
    from_team as team_name,
    case when time_stamp <= 45 then 1 else 2 end as half_number,
    sum(case when from_team = to_team then 1 else -1 end) as dominance
from 
    base 
group by 
    team_name, half_number
order by 
    team_name, half_number