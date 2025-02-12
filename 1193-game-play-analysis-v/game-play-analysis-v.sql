# Write your MySQL query statement below
select 
    install_dt,
    count(distinct player_id) as installs,
    round(count(distinct case when date_add(install_dt,interval 1 day) = event_date then player_id else null end)/count(distinct player_id),2) as Day1_retention
from (
    select 
        player_id,
        event_date,
        min(event_date) over (partition by player_id) as install_dt
    from 
        Activity
) a
group by 
    install_dt