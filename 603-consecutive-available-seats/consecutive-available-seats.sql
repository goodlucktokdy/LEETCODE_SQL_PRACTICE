with base as (
    select
        a.seat_id aid,
        a.free as afree,
        b.seat_id bid,
        b.free as bfree
    from
        Cinema a
    join 
        Cinema b
    on 
        a.seat_id = b.seat_id - 1
    where 
        a.free = 1 and b.free = 1
)
select
    aid as seat_id
    from
    base
union 
select
    bid as seat_id
    from
    base
order by
    seat_id