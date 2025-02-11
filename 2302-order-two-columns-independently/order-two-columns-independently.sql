# Write your MySQL query statement below
select 
    first_col,
    second_col
from 
    (select first_col,row_number() over (order by first_col) as fr from Data) a
inner join 
    (select second_col,row_number() over (order by second_col desc) as sr from Data) b
on 
    a.fr = b.sr
order by 
    a.fr