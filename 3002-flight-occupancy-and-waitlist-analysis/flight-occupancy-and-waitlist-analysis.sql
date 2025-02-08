# Write your MySQL query statement below
select 
    flight_id,
    max(case when cnts = 0 then 0 
            when capacity >= cnts then cnts else capacity end) as booked_cnt,
    max(case when capacity < cnts then cnts - capacity else 0 end) as waitlist_cnt
from (
    select 
        a.flight_id,
        b.passenger_id,
        a.capacity,
        count(b.passenger_id) over (partition by a.flight_id) as cnts
    from 
        Flights a 
    left join 
        Passengers b
    on 
        a.flight_id = b.flight_id
) a
group by 
    flight_id
order by 
    flight_id