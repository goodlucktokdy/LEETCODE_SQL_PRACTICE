# Write your MySQL query statement below
select 
    state,
    group_concat(city order by city asc separator ', ') as cities,
    count(distinct case when left(city,1) = left(state,1) then city else null end) as matching_letter_count
from 
    cities
group by 
    state
having 
    count(distinct city) >= 3 and matching_letter_count > 0
order by 
    matching_letter_count desc, state asc 