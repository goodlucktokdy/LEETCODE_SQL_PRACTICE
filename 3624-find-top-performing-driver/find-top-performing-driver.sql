# Write your MySQL query statement below
with base as (
    select 
        a.fuel_type,
        a.driver_id,
        round(avg(b.rating),2) as rating,
        sum(b.distance) as distance 
    from 
        Vehicles a 
    inner join 
        Trips b 
    on 
        a.vehicle_id = b.vehicle_id
    group by 
        a.fuel_type, a.driver_id
)
select 
    fuel_type,
    driver_id,
    rating,
    distance
from (
    select 
        a.fuel_type,
        a.driver_id,
        a.rating,
        a.distance,
        dense_rank() over (partition by fuel_type order by a.rating desc, a.distance desc, b.accidents asc) as ranks
    from 
        base a 
    inner join 
        Drivers b 
    on 
        a.driver_id = b.driver_id
) a
where 
    ranks = 1
order by 
    fuel_type asc 