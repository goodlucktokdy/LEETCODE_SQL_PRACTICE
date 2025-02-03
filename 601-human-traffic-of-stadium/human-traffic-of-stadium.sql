
with sess_info as (
    select 
        id,
        visit_date,
        people,
        sess,
        count(id) over (partition by sess) as sess_cnts
    from (
        select 
            id,
            visit_date,
            people,
            id - cast(row_number() over (order by id) as real) as sess
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
    sess_cnts >= 3
order by 
    visit_date