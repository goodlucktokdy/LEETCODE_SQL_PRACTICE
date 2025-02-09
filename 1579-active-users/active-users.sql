# Write your MySQL query statement below
with base as (
    select 
        id,
        login_date,
        date_sub(login_date, interval row_number() over (partition by id order by login_date) day) as sess
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
    a.id as id,
    b.name as name
from 
    base a 
inner join 
    Accounts b 
on 
    a.id = b.id 
group by 
    a.id,a.sess
having 
    count(distinct a.login_date) >= 5
order by 
    id asc