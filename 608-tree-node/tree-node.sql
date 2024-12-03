with recursive cte as (
    select
        id,
        p_id,
        1 as gen
    from 
        Tree
    where 
        p_id is null
    union all
    select
        a.id,
        a.p_id,
        cte.gen + 1
    from 
        Tree a
    inner join
        cte
    on
        cte.id = a.p_id
), leaves as (
    select
        a.aid
    from (
        select
            a.id as aid,
            a.p_id as apid,
            b.id as bid,
            b.p_id as bpid
        from 
            cte a 
        left join 
            cte b 
        on 
            a.id = b.p_id
        where 
            b.p_id is null
    ) a
)
select
    id,
    case when gen = 1 then 'Root'
        when id in (select * from leaves) then 'Leaf'
        else 'Inner' end as type
from 
    cte