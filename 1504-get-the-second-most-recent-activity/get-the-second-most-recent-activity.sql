select 
    distinct
    username,
    activity,
    startDate,
    endDate
from (
    select 
        username,
        activity,
        startDate,
        endDate,
        dense_rank() over (partition by username order by endDate desc, startDate desc) as ranks
    from 
        UserActivity
) a 
where 
    ranks = 2
union all
select 
    username,
    activity,
    startDate,
    endDate
from
    UserActivity 
where 
    username in (select username from UserActivity group by username having count(*) = 1)
