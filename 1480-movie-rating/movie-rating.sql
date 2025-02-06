# Write your MySQL query statement below
with name_cte as (
    select 
        user_id,
        name,
        dense_rank() over (order by cnts desc, name asc) as ranks
    from (
        select 
            a.user_id,
            a.name,
            count(b.created_at) as cnts
        from 
            Users a 
        inner join 
            MovieRating b 
        on 
            a.user_id = b.user_id
        group by 
            a.user_id, a.name
    ) a
),
title_cte as (
    select 
        title,
        dense_rank() over (order by average_rating desc, title asc) as ranks
    from (
        select 
            a.movie_id,
            a.title,
            avg(rating) as average_rating
        from 
            Movies a 
        inner join 
            MovieRating b 
        on 
            a.movie_id = b.movie_id
        where 
            year(B.created_at) = 2020 and month(b.created_at) = 2
        group by 
            a.movie_id, a.title
    ) a
)
select 
    name as results
from 
    name_cte 
where 
    ranks = 1 
union all
select 
    title as results
from 
    title_cte
where 
    ranks = 1
