# Write your MySQL query statement below
with base as (
    select 
        id,
        drink,
        rnums,
        sum(case when drink is null then 0 else 1 end) over (order by rnums asc) as ranks
    from (
        select 
            id,
            row_number() over () as rnums,
            drink
        from 
            CoffeeShop
    ) a
)
select 
    id,
    first_value(drink) over (partition by ranks order by rnums) as drink
from 
    base
order by 
    rnums