# Write your MySQL query statement below
with base as (
    select 
        b.month,
        a.account_id,
        b.income,
        a.max_income
    from 
        Accounts a 
    inner join (
        select 
            date_format(day,'%Y-%m-01') as month,
            account_id,
            sum(amount) as income
        from 
            Transactions 
        where 
            type = 'Creditor'
        group by 
            date_format(day,'%Y-%m'), account_id
    ) b
    on 
        a.account_id = b.account_id
)
select 
    distinct
    account_id
from (
    select 
        month,
        account_id,
        date_sub(month, interval row_number() over (partition by account_id order by month) month) as sess
    from 
        base 
    where 
        income > max_income
) a
group by 
    account_id, sess 
having 
    count(distinct month) >= 2