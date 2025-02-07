# Write your MySQL query statement below
with base as (
select 
    'Android' as platform,
    'Reading' as experiment_name
union 
select 
    'IOS' as platform,
    'Sports' as experiment_name
union 
select 
    'Web' as platform,
    'Programming' as experiment_name
),
pairs as (
    select 
        a.platform,
        b.experiment_name
    from 
        base a 
    cross join 
        base b
)
select 
    a.platform,
    a.experiment_name,
    count(distinct b.experiment_id) as num_experiments
from 
    pairs a 
left join 
    Experiments b 
on 
    a.platform = b.platform and a.experiment_name = b.experiment_name
group by 
    a.platform, a.experiment_name
