with base as (
    select
        a.account,
        a.name,
        b.amount
    from 
        Users a 
    inner join
        Transactions b
    on
        a.account = b.account
)
select
    name,
    sum(amount) as balance
from 
    base
group by 
    name
having
    balance > 10000
