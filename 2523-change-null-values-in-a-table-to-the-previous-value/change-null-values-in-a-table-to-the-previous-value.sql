# Write your MySQL query statement below
with base as (
    select 
        id,
        ranks,
        drink,
        sum(case when drink is null then 0 else 1 end) over (order by ranks) as sess
    from (
        select 
            id,
            row_number() over () as ranks,
            drink
        from
            CoffeeShop
    ) a
)
select 
    id,
    first_value(drink) over (partition by sess order by ranks) as drink
from 
    base 
order by 
    ranks