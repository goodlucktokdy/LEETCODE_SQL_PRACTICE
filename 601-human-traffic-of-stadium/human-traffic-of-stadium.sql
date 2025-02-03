# Write your MySQL query statement below
with sess_info as (
    select 
        id,
        visit_date,
        sess,
        people,
        count(id) over (partition by sess) as cnts
    from (
        select 
            id,
            visit_date,
            people,
            cast(row_number() over (order by id) as real) - id as sess
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
from 
    sess_info 
where 
    cnts >= 3
order by 
    visit_date