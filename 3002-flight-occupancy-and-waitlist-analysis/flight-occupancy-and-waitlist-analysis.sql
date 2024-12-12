# Write your MySQL query statement below
select 
    a.flight_id,
    case when a.passengers < a.capacity then a.passengers else a.capacity end as booked_cnt,
    case when a.passengers - a.capacity > 0 then a.passengers - a.capacity 
    else 0 end as waitlist_cnt
from (
    select 
        distinct
        a.flight_id,
        a.capacity,
        coalesce(count(b.passenger_id) over (partition by flight_id),0) as passengers
    from 
        Flights a 
    left join 
        Passengers b 
    on 
        a.flight_id = b.flight_id
) a 
order by 
    a.flight_id asc 