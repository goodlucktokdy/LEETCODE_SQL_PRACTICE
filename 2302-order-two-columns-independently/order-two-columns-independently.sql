# Write your MySQL query statement below
with base as (
    select 
        first_col,
        second_col,
        row_number() over (order by first_col) as first_ranks,
        row_number() over (order by second_col desc) as second_ranks
    from 
        Data
)
select 
    a.first_col,
    b.second_col
from 
    base a 
inner join 
    base b 
on 
    a.first_ranks = b.second_ranks
order by 
    a.first_ranks