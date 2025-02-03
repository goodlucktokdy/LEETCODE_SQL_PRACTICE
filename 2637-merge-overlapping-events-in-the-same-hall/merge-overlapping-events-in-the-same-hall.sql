with base as (
    select 
        hall_id,
        start_day,
        end_day,
        if(start_day > max(end_day) over (partition by hall_id order by start_day,end_day rows between unbounded preceding and 1 preceding),1,0) as is_new_sequence
    from 
        HallEvents
)
select 
    hall_id,
    min(start_day) as start_day,
    max(end_day) as end_day
from (
    select 
        hall_id,
        start_day,
        end_day,
        sum(is_new_sequence) over (partition by hall_id order by start_day, end_day) as sess
    from 
        base 
) a 
group by 
    hall_id,sess
    
