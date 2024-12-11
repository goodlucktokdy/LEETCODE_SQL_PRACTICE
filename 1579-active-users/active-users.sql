# Write your MySQL query statement below
with base as (
    select 
        a.id,
        lag(a.login_date,4) over (partition by a.id order by a.login_date) as prev_four_days,
        a.login_date
    from (
        select 
            distinct
            id,
            login_date
        from 
            Logins
    ) a
)
select 
    distinct
    a.id,
    b.name
from 
    base a
inner join 
    Accounts b 
on 
    a.id = b.id
where 
    datediff(login_date,prev_four_days) = 4
order by 
    id