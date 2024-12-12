# Write your MySQL query statement below
select 
    distinct
    a.city
from (
    select 
        distinct
        listing_id,
        city,
        avg(price) over (partition by city) as city_avg,
        avg(price) over () as total_avg
    from 
        Listings
) a
where 
    a.city_avg > a.total_avg
order by 
    a.city asc