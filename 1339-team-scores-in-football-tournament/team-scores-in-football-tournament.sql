with base as (
    select
        host_team as team,
        case when host_goals > guest_goals then 3 
            when host_goals = guest_goals then 1
            else 0 end as score
    from 
        Matches
    union all
    select
        guest_team as team,
        case when host_goals < guest_goals then 3
            when host_goals = guest_goals then 1
                else 0 end as score
    from 
        Matches
)
select
    ifnull(b.team,a.team_id) as team_id,
    a.team_name,
    ifnull(sum(b.score),0) as num_points
from 
    Teams a
left join
    base b
on
    a.team_id = b.team
group by
    1,2
order by
    num_points desc, team_id asc