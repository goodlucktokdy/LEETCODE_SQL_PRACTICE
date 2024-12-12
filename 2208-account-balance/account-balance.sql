# Write your MySQL query statement below
with base as (
    select 
        a.account_id,
        b.day,
        b.type,
        if(b.type = 'Deposit',b.amount,-1 * b.amount) as amount
    from 
        Transactions a 
    left join 
        Transactions b 
    on 
        a.account_id = b.account_id and a.day = b.day and a.type = b.type
)
select 
    distinct
    account_id,
    day,
    sum(amount) over (partition by account_id order by day asc) as balance
from   
    base