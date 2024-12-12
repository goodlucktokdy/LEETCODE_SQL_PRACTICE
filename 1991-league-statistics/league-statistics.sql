with base as(
    select 
        home_team_id as team_id,
        home_team_goals as goal_for,
        away_team_goals as goal_against
    from 
        Matches
    union all
    select 
        away_team_id as team_id,
        away_team_goals as goal_for,
        home_team_goals as goal_against
    from 
        Matches
)
, except_points as (
    select 
        team_id,
        count(*) as matches_played,
        sum(goal_for) as goal_for,
        sum(goal_against) as goal_against,
        sum(goal_for) - sum(goal_against) as goal_diff
    from 
        base 
    group by 
        team_id
), points_cte as (
select 
    a.home_team,
    a.away_team,
    a.home_win + a.draw as home_point,
    a.away_win + a.draw as away_point
from (
    select 
        home_team_id as home_team,
        away_team_id as away_team,
        if(home_team_goals>away_team_goals,3,0) as home_win,
        if(home_team_goals=away_team_goals,1,0) as draw,
        if(home_team_goals < away_team_goals,3,0) as away_win
    from 
        Matches
    ) a 
)
, points_final as (
    select 
        home_team as team_id,
        home_point as points
    from 
        points_cte
    union all
    select 
        away_team as team_id,
        away_point as points
    from 
        points_cte
),final_points as (
    select 
        team_id,
        sum(points) as points
    from 
        points_final
    group by 
        1
)
select 
    distinct
    c.team_name,
    a.matches_played,
    b.points,
    a.goal_for,
    a.goal_against,
    a.goal_diff
from
    except_points a
inner join 
    final_points b 
on 
    a.team_id = b.team_id
inner join 
    Teams c 
on 
    a.team_id = c.team_id and b.team_id = c.team_id
order by 
    b.points desc, a.goal_diff desc, c.team_name asc