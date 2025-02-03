# Write your MySQL query statement below
with retained as (
    select 
        install_dt,
        count(distinct player_id) as installs,
        count(distinct case when event_date = date_add(install_dt,interval 1 day) then player_id else null end) as retained_users
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
)
select 
    install_dt,
    installs,
    round(retained_users/installs,2) as Day1_retention
from 
    retained