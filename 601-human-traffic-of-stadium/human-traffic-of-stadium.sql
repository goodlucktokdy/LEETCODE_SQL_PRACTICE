# Write your MySQL query statement below
with base as (
    select 
        id,
        visit_date,
        people,
        cast(row_number() over (order by id) as real) - id as sess
    from (
        select 
            id,
            visit_date,
            people
        from 
            Stadium
        where 
            people >= 100
    ) a
)
select 
    id,
    visit_date,
    people
from (
    select 
        id,
        visit_date,
        people,
        count(id) over (partition by sess) as cnts
    from 
        base 
) a 
where 
    cnts >= 3
order by 
    visit_date asc 