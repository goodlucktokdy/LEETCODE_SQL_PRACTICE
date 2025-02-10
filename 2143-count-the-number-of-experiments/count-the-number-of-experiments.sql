# Write your MySQL query statement below
with base_og as (
    select 
        'IOS' as platform,
        'Reading' as experiment_name
    union all
    select
        'Android' as platform,
        'Programming' as experiment_name
    union all
    select 
        'Web' as platform,
        'Sports' as experiment_name
),
base as (
    select 
        a.platform,
        b.experiment_name
    from 
        base_og a 
    cross join 
        base_og b
)
select 
    a.platform,
    a.experiment_name,
    count(distinct b.experiment_id) as num_experiments
from 
    base a
left join 
    Experiments b
on 
    a.platform = b.platform and a.experiment_name = b.experiment_name
group by 
    a.platform, a.experiment_name