# Write your MySQL query statement below
with install_info as (
    select 
        install_dt,
        count(distinct player_id) as installs,
        count(distinct case when date_add(install_dt,interval 1 day) = event_date then player_id else null end) as retention
    from (
        select 
            player_id,
            min(event_date) over (partition by player_id) as install_dt,
            event_date
        from 
            Activity
    ) a 
    group by 
        install_dt
)
select 
    install_dt,
    installs,
    round(retention/installs,2) as Day1_retention
from 
    install_info 
