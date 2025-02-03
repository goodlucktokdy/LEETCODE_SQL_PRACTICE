
with base as (
    select 
        'mobile' as platform,
        spend_date
    from 
        Spending
    union 
    select  
        'both',
        spend_date
    from 
        Spending
    union
    select 
        'desktop',
        spend_date
    from 
        Spending        
),
user_info as (
    select 
        distinct 
        user_id,
        spend_date,
        case when platform_cnts = 2 then 'both' else platform end as platform,
        sum(amount) as total_amount
    from (
        select 
            user_id,
            spend_date,
            platform,
            count(platform) over (partition by user_id, spend_date) as platform_cnts,
            amount
        from 
            Spending
    ) a
    group by 
        1,2,3
)
select 
    a.spend_date as spend_date,
    a.platform as platform,
    sum(coalesce(b.total_amount,0)) as total_amount,
    count(distinct b.user_id) as total_users
from 
    base a 
left join 
    user_info b 
on 
    a.spend_date = b.spend_date and a.platform = b.platform
group by 
    spend_date, platform