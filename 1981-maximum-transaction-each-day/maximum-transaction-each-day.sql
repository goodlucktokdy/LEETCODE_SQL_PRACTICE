with daily_amount as (
    select
        day,
        max(amount) as max_amount_daily
    from 
        Transactions
    group by 
        day
)
select
    b.transaction_id
from 
    daily_amount a
inner join
    Transactions b
on
    a.max_amount_daily = b.amount and a.day = b.day
order by
    b.transaction_id asc