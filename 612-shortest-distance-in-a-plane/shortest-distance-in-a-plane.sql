with base as (
    select 
        a.x ax,
        a.y ay,
        b.x bx,
        b.y bby
    from 
        Point2D a 
    cross join 
        Point2D b
    where 
        concat(a.x,a.y) != concat(b.x,b.y)
)
select 
    min(round(sqrt(power((ax-bx),2)+power((ay-bby),2)),2)) as shortest
from 
    base
