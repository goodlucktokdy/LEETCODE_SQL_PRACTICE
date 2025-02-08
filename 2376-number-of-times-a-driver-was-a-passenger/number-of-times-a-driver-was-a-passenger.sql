# Write your MySQL query statement below
select 
    coalesce(a.driver_id) as driver_id,
    count(distinct b.ride_id) as cnt
from 
    Rides a 
left join (
    select 
        distinct
        b.ride_id,
        b.driver_id,
        b.passenger_id
    from 
        Rides a 
    inner join 
        Rides b 
    on 
        a.ride_id != b.ride_id and a.driver_id = b.passenger_id
) b
on 
    a.driver_id = b.passenger_id
group by 
    driver_id
