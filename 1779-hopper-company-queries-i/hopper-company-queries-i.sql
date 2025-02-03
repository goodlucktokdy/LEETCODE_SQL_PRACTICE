with recursive cte as (
    select 
        1 as month
    union all
    select 
        cte.month + 1 
    from 
        cte 
    where 
        cte.month < 12 
),
actives as (
    select 
        a.month as month,
        sum(coalesce(b.drivers,0)) over (order by a.month) as active_drivers
    from 
        cte a 
    left join (
        select 
            month(case when join_date < '2020-01-01' then '2020-01-01' else join_date end) as month,
            count(distinct driver_id) as drivers
        from 
            Drivers
        where 
            year(join_date) <= 2020 
        group by 
            month
    ) b
    on 
        a.month = b.month
),
accepts as (
    select 
        a.month,
        coalesce(b.rides,0) as accepted_rides
    from 
        cte a 
    left join (
        select 
            month(date(a.requested_at)) as month,
            count(distinct a.ride_id) as rides
        from 
            Rides a 
        inner join 
            AcceptedRides b 
        on 
            a.ride_id = b.ride_id
        where 
            year(a.requested_at) = 2020
        group by 
            month
    ) b 
    on
        a.month = b.month 
)
select 
    a.month as month,
    a.active_drivers,
    b.accepted_rides
from 
    actives a 
inner join 
    accepts b 
on 
    a.month = b.month 
order by 
    month