select
    min(a.log_id) as start_id,
    max(a.log_id) as end_id
from (
    select
        log_id,
        log_id - row_number() over (order by log_id) as session
    from 
        Logs
) a
group by 
    a.session
order by 
    start_id