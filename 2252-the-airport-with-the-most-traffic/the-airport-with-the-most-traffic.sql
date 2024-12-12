# Write your MySQL query statement below
with base as (
    select 
        departure_airport as airport,
        flights_count
    from 
        Flights
    union all
    select 
        arrival_airport as airport,
        flights_count
    from 
        Flights
)
select 
    distinct
    a.airport as airport_id
from (
    select 
        airport,
        dense_rank() over (order by sum(flights_count) desc) as flights_ranking
    from 
        base
    group by 
        airport
) a 
where
    a.flights_ranking = 1