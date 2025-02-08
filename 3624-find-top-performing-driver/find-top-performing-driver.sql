# Write your MySQL query statement below
with base as (
    select 
        b.fuel_type,
        a.driver_id,
        round(avg(c.rating),2) as rating,
        sum(c.distance) as distance,
        sum(a.accidents) as accidents
    from 
        Drivers a 
    inner join 
        Vehicles b 
    on 
        a.driver_id = b.driver_id
    inner join 
        Trips c 
    on 
        b.vehicle_id = c.vehicle_id
    group by 
        b.fuel_type, a.driver_id
)
select 
    fuel_type,
    driver_id,
    rating,
    distance
from (
    select 
        fuel_type,
        driver_id,
        rating,
        distance,
        dense_rank() over (partition by fuel_type order by rating desc, distance desc, accidents asc) as ranks
    from 
        base
) a
where 
    ranks = 1
order by 
    fuel_type asc 