# Write your MySQL query statement below
select 
    round(count(distinct case when date_add(first_visit,interval 1 day) = event_date then player_id else null end)/count(distinct player_id),2) as fraction
from (
    select 
        player_id,
        min(event_date) over (partition by player_id) as first_visit,
        event_date
    from 
        Activity
) a