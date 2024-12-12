# Write your MySQL query statement below
with base as (
    select 
        contest_id,
        gold_medal as user
    from 
        Contests
    union all
    select 
        contest_id,
        silver_medal as user
    from 
        Contests
    union all
    select 
        contest_id,
        bronze_medal as user
    from 
        Contests
)
, medal_cnts as (
    select 
        user,
        contest_id,
        row_number() over (partition by user order by contest_id) as rn
    from 
        base
), final_info as (
    select 
        user
    from 
        medal_cnts 
    group by 
        user,contest_id - rn
    having 
        count(*) >= 3
    union all
    select 
        gold_medal as user
    from 
        Contests
    group by
        user
    having 
        count(distinct contest_id) >= 3
)
select 
    distinct
    a.name,
    a.mail
from 
    Users a 
inner join 
    final_info b 
on 
    a.user_id = b.user