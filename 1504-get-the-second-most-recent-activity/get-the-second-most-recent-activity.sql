-- -- -- -- -- -- -- -- -- -- -- -- -- # Write your MySQL query statement below
-- -- -- -- -- -- -- -- -- -- -- -- -- select 
-- -- -- -- -- -- -- -- -- -- -- -- --     a.username,
-- -- -- -- -- -- -- -- -- -- -- -- --     a.activity,
-- -- -- -- -- -- -- -- -- -- -- -- --     a.startDate,
-- -- -- -- -- -- -- -- -- -- -- -- --     a.endDate
-- -- -- -- -- -- -- -- -- -- -- -- -- from (
-- -- -- -- -- -- -- -- -- -- -- -- --     select 
-- -- -- -- -- -- -- -- -- -- -- -- --         distinct
-- -- -- -- -- -- -- -- -- -- -- -- --         username,
-- -- -- -- -- -- -- -- -- -- -- -- --         activity,
-- -- -- -- -- -- -- -- -- -- -- -- --         startDate,
-- -- -- -- -- -- -- -- -- -- -- -- --         endDate,
-- -- -- -- -- -- -- -- -- -- -- -- --         count(username) over (partition by username) as user_cnts,
-- -- -- -- -- -- -- -- -- -- -- -- --         dense_rank() over (partition by username order by endDate desc) as ranks
-- -- -- -- -- -- -- -- -- -- -- -- --     from 
-- -- -- -- -- -- -- -- -- -- -- -- --         UserActivity
-- -- -- -- -- -- -- -- -- -- -- -- -- ) a
-- -- -- -- -- -- -- -- -- -- -- -- -- where
-- -- -- -- -- -- -- -- -- -- -- -- --    ranks = 2 or (ranks <= 2 and user_cnts = ranks)
-- -- -- -- -- -- -- -- -- -- -- -- with base as (
-- -- -- -- -- -- -- -- -- -- -- --     select 
-- -- -- -- -- -- -- -- -- -- -- --         username,
-- -- -- -- -- -- -- -- -- -- -- --         activity,
-- -- -- -- -- -- -- -- -- -- -- --         startDate,
-- -- -- -- -- -- -- -- -- -- -- --         endDate,
-- -- -- -- -- -- -- -- -- -- -- --         dense_rank() over (partition by username order by endDate desc) as ranks
-- -- -- -- -- -- -- -- -- -- -- --     from 
-- -- -- -- -- -- -- -- -- -- -- --         userActivity
-- -- -- -- -- -- -- -- -- -- -- -- )
-- -- -- -- -- -- -- -- -- -- -- -- select 
-- -- -- -- -- -- -- -- -- -- -- --     username,
-- -- -- -- -- -- -- -- -- -- -- --     activity,
-- -- -- -- -- -- -- -- -- -- -- --     startDate,
-- -- -- -- -- -- -- -- -- -- -- --     endDate
-- -- -- -- -- -- -- -- -- -- -- -- from 
-- -- -- -- -- -- -- -- -- -- -- --     base 
-- -- -- -- -- -- -- -- -- -- -- -- where 
-- -- -- -- -- -- -- -- -- -- -- --     ranks = 2
-- -- -- -- -- -- -- -- -- -- -- -- union all
-- -- -- -- -- -- -- -- -- -- -- -- select 
-- -- -- -- -- -- -- -- -- -- -- --     *
-- -- -- -- -- -- -- -- -- -- -- -- from 
-- -- -- -- -- -- -- -- -- -- -- --     userActivity 
-- -- -- -- -- -- -- -- -- -- -- -- where 
-- -- -- -- -- -- -- -- -- -- -- --     username in (select username from userActivity group by username having count(*) = 1)    
-- -- -- -- -- -- -- -- -- -- -- with base as (
-- -- -- -- -- -- -- -- -- -- --     select 
-- -- -- -- -- -- -- -- -- -- --         username,
-- -- -- -- -- -- -- -- -- -- --         activity,
-- -- -- -- -- -- -- -- -- -- --         startDate,
-- -- -- -- -- -- -- -- -- -- --         endDate,
-- -- -- -- -- -- -- -- -- -- --         row_number() over (partition by username order by endDate desc) as rnums
-- -- -- -- -- -- -- -- -- -- --     from
-- -- -- -- -- -- -- -- -- -- --         UserActivity
-- -- -- -- -- -- -- -- -- -- --     where 
-- -- -- -- -- -- -- -- -- -- --         username in (select username from UserActivity group by username having count(*) > 1)
-- -- -- -- -- -- -- -- -- -- -- )
-- -- -- -- -- -- -- -- -- -- -- select
-- -- -- -- -- -- -- -- -- -- --     username,
-- -- -- -- -- -- -- -- -- -- --     activity,
-- -- -- -- -- -- -- -- -- -- --     startDate,
-- -- -- -- -- -- -- -- -- -- --     endDate
-- -- -- -- -- -- -- -- -- -- -- from 
-- -- -- -- -- -- -- -- -- -- --     base 
-- -- -- -- -- -- -- -- -- -- -- where 
-- -- -- -- -- -- -- -- -- -- --     rnums = 2
-- -- -- -- -- -- -- -- -- -- -- union all
-- -- -- -- -- -- -- -- -- -- -- select 
-- -- -- -- -- -- -- -- -- -- --     username,
-- -- -- -- -- -- -- -- -- -- --     activity,
-- -- -- -- -- -- -- -- -- -- --     startDate,
-- -- -- -- -- -- -- -- -- -- --     endDate
-- -- -- -- -- -- -- -- -- -- -- from 
-- -- -- -- -- -- -- -- -- -- --     UserActivity
-- -- -- -- -- -- -- -- -- -- -- where 
-- -- -- -- -- -- -- -- -- -- --     username in (select username from UserActivity group by username having count(*) < 2)
-- -- -- -- -- -- -- -- -- -- select 
-- -- -- -- -- -- -- -- -- --     username,
-- -- -- -- -- -- -- -- -- --     activity,
-- -- -- -- -- -- -- -- -- --     startDate,
-- -- -- -- -- -- -- -- -- --     endDate
-- -- -- -- -- -- -- -- -- -- from (
-- -- -- -- -- -- -- -- -- --     select 
-- -- -- -- -- -- -- -- -- --         username,
-- -- -- -- -- -- -- -- -- --         activity,
-- -- -- -- -- -- -- -- -- --         startDate,
-- -- -- -- -- -- -- -- -- --         endDate,
-- -- -- -- -- -- -- -- -- --         row_number() over (partition by username order by endDate desc,startDate desc) as rnums
-- -- -- -- -- -- -- -- -- --     from 
-- -- -- -- -- -- -- -- -- --         UserActivity
-- -- -- -- -- -- -- -- -- -- ) a
-- -- -- -- -- -- -- -- -- -- where 
-- -- -- -- -- -- -- -- -- --     rnums = 2
-- -- -- -- -- -- -- -- -- -- union all
-- -- -- -- -- -- -- -- -- -- select 
-- -- -- -- -- -- -- -- -- --     username,
-- -- -- -- -- -- -- -- -- --     activity,
-- -- -- -- -- -- -- -- -- --     startDate,
-- -- -- -- -- -- -- -- -- --     endDate
-- -- -- -- -- -- -- -- -- -- from 
-- -- -- -- -- -- -- -- -- --     UserActivity
-- -- -- -- -- -- -- -- -- -- where 
-- -- -- -- -- -- -- -- -- --     username in (select username from UserActivity group by username having count(*) = 1)

-- -- -- -- -- -- -- -- -- with base as (
-- -- -- -- -- -- -- -- --     select 
-- -- -- -- -- -- -- -- --         username,
-- -- -- -- -- -- -- -- --         activity,
-- -- -- -- -- -- -- -- --         startDate,
-- -- -- -- -- -- -- -- --         endDate,
-- -- -- -- -- -- -- -- --         dense_rank() over (partition by username order by startDate desc,endDate desc) as ranks
-- -- -- -- -- -- -- -- --     from 
-- -- -- -- -- -- -- -- --         UserActivity
-- -- -- -- -- -- -- -- -- )
-- -- -- -- -- -- -- -- -- select 
-- -- -- -- -- -- -- -- --     username,
-- -- -- -- -- -- -- -- --     activity,
-- -- -- -- -- -- -- -- --     startDate,
-- -- -- -- -- -- -- -- --     endDate
-- -- -- -- -- -- -- -- -- from 
-- -- -- -- -- -- -- -- --     base 
-- -- -- -- -- -- -- -- -- where 
-- -- -- -- -- -- -- -- --     username in (select username from base group by username having count(*) < 2)
-- -- -- -- -- -- -- -- -- union all
-- -- -- -- -- -- -- -- -- select 
-- -- -- -- -- -- -- -- --     username,
-- -- -- -- -- -- -- -- --     activity,
-- -- -- -- -- -- -- -- --     startDate,
-- -- -- -- -- -- -- -- --     endDate
-- -- -- -- -- -- -- -- -- from 
-- -- -- -- -- -- -- -- --     base 
-- -- -- -- -- -- -- -- -- where 
-- -- -- -- -- -- -- -- --     ranks = 2
-- -- -- -- -- -- -- -- select 
-- -- -- -- -- -- -- --     username,
-- -- -- -- -- -- -- --     activity,
-- -- -- -- -- -- -- --     startDate,
-- -- -- -- -- -- -- --     endDate
-- -- -- -- -- -- -- -- from (  
-- -- -- -- -- -- -- --     select 
-- -- -- -- -- -- -- --         username,
-- -- -- -- -- -- -- --         activity,
-- -- -- -- -- -- -- --         startDate,
-- -- -- -- -- -- -- --         endDate,
-- -- -- -- -- -- -- --         row_number() over (partition by username order by endDate desc, startDate desc) as rnums
-- -- -- -- -- -- -- --     from 
-- -- -- -- -- -- -- --         UserActivity
-- -- -- -- -- -- -- --     where 
-- -- -- -- -- -- -- --         username in (select username from UserActivity group by username having count(*) > 1)
-- -- -- -- -- -- -- -- ) a
-- -- -- -- -- -- -- -- where rnums = 2
-- -- -- -- -- -- -- -- union all
-- -- -- -- -- -- -- -- select 
-- -- -- -- -- -- -- --     username,
-- -- -- -- -- -- -- --     activity,
-- -- -- -- -- -- -- --     startDate,
-- -- -- -- -- -- -- --     endDate
-- -- -- -- -- -- -- -- from 
-- -- -- -- -- -- -- --     UserActivity
-- -- -- -- -- -- -- -- where 
-- -- -- -- -- -- -- --     username in (select username from UserActivity group by username having count(*) = 1)
-- -- -- -- -- -- -- select 
-- -- -- -- -- -- --     username,
-- -- -- -- -- -- --     activity,
-- -- -- -- -- -- --     startDate,
-- -- -- -- -- -- --     endDate
-- -- -- -- -- -- -- from (
-- -- -- -- -- -- --     select 
-- -- -- -- -- -- --         username,
-- -- -- -- -- -- --         activity,
-- -- -- -- -- -- --         startDate,
-- -- -- -- -- -- --         endDate,
-- -- -- -- -- -- --         row_number() over (partition by username order by startDate desc) as rnums
-- -- -- -- -- -- --     from 
-- -- -- -- -- -- --         UserActivity 
-- -- -- -- -- -- -- ) u
-- -- -- -- -- -- -- where 
-- -- -- -- -- -- --     rnums = 2
-- -- -- -- -- -- -- union all
-- -- -- -- -- -- -- select 
-- -- -- -- -- -- --     username,
-- -- -- -- -- -- --     activity,
-- -- -- -- -- -- --     startDate,
-- -- -- -- -- -- --     endDate
-- -- -- -- -- -- -- from 
-- -- -- -- -- -- --     UserActivity
-- -- -- -- -- -- -- where 
-- -- -- -- -- -- --     username in (select username from UserActivity group by username having count(*) = 1)
-- -- -- -- -- -- with base as (
-- -- -- -- -- --     select 
-- -- -- -- -- --         username,
-- -- -- -- -- --         activity,
-- -- -- -- -- --         startDate,
-- -- -- -- -- --         endDate,
-- -- -- -- -- --         row_number() over (partition by username order by endDate desc, startDate desc) as rnums
-- -- -- -- -- --     from 
-- -- -- -- -- --         UserActivity 
-- -- -- -- -- -- )
-- -- -- -- -- -- select 
-- -- -- -- -- --     username,
-- -- -- -- -- --     activity,
-- -- -- -- -- --     startDate,
-- -- -- -- -- --     endDate
-- -- -- -- -- -- from 
-- -- -- -- -- --     base 
-- -- -- -- -- -- where 
-- -- -- -- -- --     rnums = 2
-- -- -- -- -- -- union all
-- -- -- -- -- -- select 
-- -- -- -- -- --     username,
-- -- -- -- -- --     activity,
-- -- -- -- -- --     startDate,
-- -- -- -- -- --     endDate
-- -- -- -- -- -- from 
-- -- -- -- -- --     UserActivity 
-- -- -- -- -- -- where 
-- -- -- -- -- --     username in (select username from UserActivity group by username having count(distinct startDate) = 1)
-- -- -- -- -- select 
-- -- -- -- --     username,
-- -- -- -- --     activity,
-- -- -- -- --     startDate,
-- -- -- -- --     endDate
-- -- -- -- -- from (
-- -- -- -- --     select 
-- -- -- -- --         username,
-- -- -- -- --         activity,
-- -- -- -- --         startDate,
-- -- -- -- --         endDate,
-- -- -- -- --         dense_rank() over (partition by username order by endDate desc, startDate desc) as ranks
-- -- -- -- --     from 
-- -- -- -- --         UserActivity
-- -- -- -- -- ) a
-- -- -- -- -- where 
-- -- -- -- --     ranks = 2
-- -- -- -- -- union all
-- -- -- -- -- select 
-- -- -- -- --     username,
-- -- -- -- --     activity,
-- -- -- -- --     startDate,
-- -- -- -- --     endDate
-- -- -- -- -- from 
-- -- -- -- --     UserActivity 
-- -- -- -- -- where 
-- -- -- -- --     username in (select username from UserActivity group by 
-- -- -- -- --                     username having count(username) = 1)

-- -- -- -- with base as (
-- -- -- --     select 
-- -- -- --         username,
-- -- -- --         activity,
-- -- -- --         startDate,
-- -- -- --         endDate,
-- -- -- --         row_number() over (partition by username order by endDate desc) as ranks
-- -- -- --     from 
-- -- -- --         UserActivity
-- -- -- -- )
-- -- -- -- select 
-- -- -- --     username,
-- -- -- --     activity,
-- -- -- --     startDate,
-- -- -- --     endDate
-- -- -- -- from 
-- -- -- --     base 
-- -- -- -- where 
-- -- -- --     ranks = 2 
-- -- -- -- union all
-- -- -- -- select 
-- -- -- --     username,
-- -- -- --     activity,
-- -- -- --     startDate,
-- -- -- --     endDate
-- -- -- -- from 
-- -- -- --     UserActivity 
-- -- -- -- where 
-- -- -- --     username in (select username from UserActivity group by username having count(distinct startDate) = 1)
-- -- -- select 
-- -- --     username,
-- -- --     activity,
-- -- --     startDate,
-- -- --     endDate
-- -- -- from (
-- -- --     select 
-- -- --         username,
-- -- --         activity,
-- -- --         startDate,
-- -- --         endDate,
-- -- --         row_number() over (partition by username order by endDate desc) as rnums
-- -- --     from
-- -- --         UserActivity
-- -- -- ) a 
-- -- -- where 
-- -- --     rnums = 2 
-- -- -- union all
-- -- -- select 
-- -- --     username,
-- -- --     activity,
-- -- --     startDate,
-- -- --     endDate
-- -- -- from 
-- -- --     UserActivity
-- -- -- where 
-- -- --     username in (select username from UserActivity group by username having count(*) = 1)
-- -- select 
-- --     username,
-- --     activity,
-- --     startDate,
-- --     endDate
-- -- from (
-- --     select 
-- --         username,
-- --         activity,
-- --         startDate,
-- --         endDate,
-- --         dense_rank() over (partition by username order by endDate desc) as recent_ranks
-- --     from 
-- --         UserActivity
-- -- ) a 
-- -- where 
-- --     recent_ranks = 2
-- -- union all
-- -- select 
-- --     username,
-- --     activity,
-- --     startDate,
-- --     endDate
-- -- from 
-- --     UserActivity 
-- -- where 
-- --     username in (select username from UserActivity group by username having count(*) = 1)
-- with base as (
--     select 
--         distinct 
--         username,
--         activity,
--         startDate,
--         endDate
--     from 
--         UserActivity
-- )
-- select 
--     username,
--     activity,
--     startDate,
--     endDate
-- from (
--     select 
--         username,
--         activity,
--         startDate,
--         endDate,
--         row_number() over (partition by username order by endDate desc,startDate desc) as rnums
--     from 
--         base 
-- ) a 
-- where 
--     rnums = 2
-- union all
-- select 
--     username,
--     activity,
--     startDate,
--     endDate
-- from 
--     base
-- where 
--     username in (select username from base group by username having count(*) = 1)
with base as (
    select 
        distinct 
        username,
        activity,
        startDate,
        endDate
    from 
        UserActivity
)
select 
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
        row_number() over (partition by username order by endDate desc,startDate desc) as rnums
    from 
        base
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
    base 
where 
    username in (select username from base group by username having count(username) = 1)