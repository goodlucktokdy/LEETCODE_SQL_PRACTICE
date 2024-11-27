with base as (
    select 
        a.visited_on,
        sum(a.amount) over (order by a.visited_on range between
        interval 6 day preceding and current row) as amount,
        count(a.visited_on) over (order by a.visited_on range between
        interval 6 day preceding and current row) as window_cnt
    from (
    select 
        visited_on,
        sum(amount) as amount
    from 
        Customer
    group by 
        visited_on
    ) a
)
select 
    visited_on,
    amount,
    round(amount/7,2) as average_amount
from 
    base 
where 
    window_cnt = 7
order by 
    visited_on