with flight_info as (
    select 
        flight_id,
        passenger_id,
        capacity,
        if(capacity >= sequence,'Confirmed','Waitlist') as Status
    from (
        select 
            a.flight_id,
            b.passenger_id,
            a.capacity,
            row_number() over (partition by a.flight_id order by b.booking_time) as sequence
        from 
            Flights a 
        inner join 
            Passengers b 
        on 
            a.flight_id = b.flight_id
    ) a
)
select 
    passenger_id,
    Status
from 
    flight_info
order by 
    passenger_id asc 