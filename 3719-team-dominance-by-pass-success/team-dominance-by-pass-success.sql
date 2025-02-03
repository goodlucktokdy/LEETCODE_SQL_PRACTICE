# Write your MySQL query statement below
with base as (
    select
        a.team_name as pass_from,
        case when cast(replace(b.time_stamp,':','.') as real) <= 45 then 1 else 2 end as half_number,
        c.team_name as pass_to,
        if(a.team_name = c.team_name,1,-1) as points
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
    pass_from as team_name,
    half_number,
    sum(points) as dominance
from 
    base 
group by 
    team_name, half_number
order by 
    team_name, half_number