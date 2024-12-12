# Write your MySQL query statement below
with base as (
    select 
        a.email_id,
        a.user_id,
        a.signup_date,
        b.signup_action,
        b.action_date
    from 
        emails a 
    inner join 
        texts b 
    on 
        a.email_id = b.email_id
)
select 
    distinct
    user_id
from 
    base 
where 
    datediff(action_date,signup_date) = 1
    and signup_action = 'Verified'
order by 
    user_id asc 