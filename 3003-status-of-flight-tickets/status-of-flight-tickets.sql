# Write your MySQL query statement below
with booking_seq as (
    select 
        a.flight_id as flight_id,
        b.passenger_id as passenger_id,
        b.booking_time as booking_time,
        a.capacity as capacity,
        row_number() over (partition by a.flight_id order by b.booking_time asc) as rnums
    from 
        Flights a 
    inner join 
        Passengers b 
    on 
        a.flight_id = b.flight_id
)
select 
    passenger_id,
    case when capacity >= rnums then 'Confirmed' else 'Waitlist' end as Status
from 
    booking_seq
order by 
    passenger_id