# Write your MySQL query statement below
with base as (
    select 
        'mobile' as platform,
        spend_date
    from 
        Spending
    union 
    select 
        'both' as platform,
        spend_date
    from 
        Spending
    union 
    select 
        'desktop' as platform,
        spend_date
    from 
        Spending
),
platform_info as (
    select 
        user_id,
        spend_date,
        case when platform_cnts = 2 then 'both' else platform end as platform,
        amount
    from (
        select 
            user_id,
            spend_date,
            platform,
            amount,
            count(platform) over (partition by spend_date,user_id) as platform_cnts
        from 
            Spending
    ) a 
)
select 
    a.spend_date,
    a.platform,
    sum(coalesce(b.total_amount,0)) as total_amount,
    count(distinct b.user_id) as total_users
from 
    base a 
left join (
    select 
        user_id,
        spend_date,
        platform,
        sum(amount) as total_amount
    from 
        platform_info 
    group by 
        1,2,3
) b
on 
    a.platform = b.platform and a.spend_date = b.spend_date
group by 
    1,2