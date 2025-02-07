# Write your MySQL query statement below
with c1 as (
    select 
        first_col,
        row_number() over (order by first_col) as rn 
    from Data
),
c2 as (
    select 
        second_col,
        row_number() over (order by second_col desc) as rn 
    from Data
)
select 
    a.first_col,
    b.second_col
from 
    c1 a 
inner join 
    c2 b 
on 
    a.rn = b.rn
order by 
    a.rn