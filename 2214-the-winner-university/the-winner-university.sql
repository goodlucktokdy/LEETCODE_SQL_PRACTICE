# Write your MySQL query statement below
with newyork as (
    select 
        count(distinct case when score >= 90 then student_id end) as cnts
    from 
        NewYork
),
cal as (
    select 
        count(distinct case when score >= 90 then student_id end) as cnts
    from 
        California
)
select 
    case when a.new_york > a.cali then 'New York University'
        when a.new_york = a.cali then 'No Winner'
        else 'California University' end as winner
from (
    select 
        a.cnts as new_york,
        b.cnts as cali
    from 
        newyork a 
    cross join 
        cal b
) a


