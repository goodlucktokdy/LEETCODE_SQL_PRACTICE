with base as (
    select 
        abs(ax-bx) as shortest
    from (
        select 
            a.x ax,
            b.x bx
        from 
            Point a 
        inner join 
            Point b 
        on 
            a.x != b.x
    ) a
)
select 
    min(shortest) as shortest
from 
    base