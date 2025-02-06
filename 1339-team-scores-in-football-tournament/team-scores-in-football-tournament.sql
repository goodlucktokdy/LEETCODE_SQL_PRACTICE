# Write your MySQL query statement below
with base as (
    select 
        host_team,
        guest_team,
        case when host_goals > guest_goals then 3 
            when host_goals = guest_goals then 1 
            else 0 end as host_score,
        case when guest_goals > host_goals then 3 
            when guest_goals = host_goals then 1 
            else 0 end as guest_score
    from 
        Matches
),
score_cte as (
select 
    host_team as team,
    host_score as score
from 
    base 
union all
select 
    guest_team as team,
    guest_score as score
from 
    base 
)
select 
    a.team_id,
    a.team_name,
    sum(coalesce(b.score,0)) as num_points 
from 
    Teams a 
left join
    score_cte b 
on 
    a.team_id = b.team
group by 
    a.team_id, a.team_name
order by 
    num_points desc, a.team_id asc 