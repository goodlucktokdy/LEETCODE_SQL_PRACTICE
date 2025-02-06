# Write your MySQL query statement below
with base as (
    select 
        visited_on,
        sum(amount) over (order by visited_on range between interval 6 day preceding and current row) as amount,
        round(avg(amount) over (order by visited_on range between interval 6 day preceding and current row),2) as average_amount
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
    average_amount
from 
    base 
where 
    date_add((select min(visited_on) from Customer),interval 6 day) <= visited_on
order by 
    visited_on