# Write your MySQL query statement below
with base as (
    select 
        visited_on,
        round(sum(amount) over (order by visited_on range between interval 6 day preceding and current row),2) as amount,
        round(avg(amount) over (order by visited_on range between interval 6 day preceding and current row),2) as average_amount,
        row_number() over (order by visited_on) as rnums
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
    rnums > 6
order by 
    visited_on