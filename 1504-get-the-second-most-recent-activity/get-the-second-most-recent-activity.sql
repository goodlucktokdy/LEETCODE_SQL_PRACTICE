# Write your MySQL query statement below
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
        row_number() over (partition by username order by endDate desc, startDate desc) as rnums
    from 
        UserActivity
) a 
where 
    rnums = 2
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