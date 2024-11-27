# Write your MySQL query statement below
with base as (
    select 
        a.player_id,
        timestampdiff(day,a.first_day, a.event_date) as diff_of_day
    from (
        select 
            player_id,
            min(event_date) over (partition by player_id) as first_day,
            event_date
        from 
            Activity
    ) a
)
select 
    round(count(distinct case when diff_of_day = 1 then player_id else null end)/count(distinct player_id),2) as fraction
from 
    base