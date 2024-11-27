select 
    a.contest_id,
    round(100*count(distinct a.user_id)/(select count(distinct user_id) from Users),2) as percentage
from 
    Register a 
left join 
    Users b 
on 
    a.user_id = b.user_id
group by 
    a.contest_id
order by 
    percentage desc, contest_id asc
