# Write your MySQL query statement below
select 
    sale_date,
    sum(case when fruit = 'apples' then sales else -1*sales end) as diff
from (
    select 
        sale_date,
        fruit,
        sum(sold_num) as sales
    from 
        Sales
    group by 
        sale_date, fruit
) a
group by 
    sale_date
order by 
    sale_date