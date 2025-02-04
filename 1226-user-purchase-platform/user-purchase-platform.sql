# Write your MySQL query statement below
with recursive cte as (
    select 
        spend_date,
        'both' as platform
    from 
        Spending
    union 
    select 
        spend_date,
        'mobile' as platform
    from 
        Spending
    union 
    select 
        spend_date,
        'desktop' as platform 
    from 
        Spending
),
users_info as (
    select 
        user_id,
        spend_date,
        case when cnts = 2 then 'both' else platform end as platform,
        amount
    from (
        select 
            user_id,
            spend_date,
            platform,
            count(platform) over (partition by user_id, spend_date) as cnts,
            amount
        from 
            Spending
    ) a 
)
select 
    a.spend_date as spend_date,
    a.platform as platform,
    sum(coalesce(b.total_amount,0)) as total_amount,
    count(distinct b.user_id) as total_users
from 
    cte a 
left join (
    select 
        user_id,
        spend_date,
        platform,
        sum(amount) as total_amount
    from 
        users_info
    group by 
        user_id, spend_date, platform
) b
on 
    a.spend_date = b.spend_date and a.platform = b.platform
group by 
    spend_date, platform