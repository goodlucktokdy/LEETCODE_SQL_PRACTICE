# Write your MySQL query statement below
select 
    distinct
    id,
    name
from (
    select 
        a.id,
        a.name,
        login_date,
        date_sub(login_date, interval dense_rank() over (partition by a.id order by login_date) day) as sess
    from 
        Accounts a 
    inner join 
        Logins b 
    on 
        a.id = b.id
) a 
group by 
    id,name,sess
having 
    count(distinct login_date) >= 5
order by 
    id