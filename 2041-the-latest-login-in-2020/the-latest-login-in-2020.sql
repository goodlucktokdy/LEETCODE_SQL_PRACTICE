select
    distinct
    user_id,
    max(time_stamp) over (partition by user_id) as last_stamp
from 
    Logins
where 
    year(time_stamp) = 2020