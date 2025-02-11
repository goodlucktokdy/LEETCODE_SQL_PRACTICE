# Write your MySQL query statement below
select 
    flight_id,
    case when capacity >= cnts then cnts 
        else capacity end as booked_cnt,
    case when capacity < cnts then cnts - capacity else 0 end as waitlist_cnt
from (
    select 
        a.flight_id,
        a.capacity,
        count(b.flight_id) as cnts
    from 
        Flights a 
    left join 
        Passengers b 
    on 
        a.flight_id = b.flight_id
    group by 
        a.flight_id, a.capacity
) a
order by 
    flight_id