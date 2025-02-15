# Write your MySQL query statement below 
with base as (
    select 
        name,
        dense_rank() over (order by cnts desc, name) as ranks
    from (
        select 
            a.name,
            count(b.movie_id) as cnts
        from 
            Users a 
        inner join 
            MovieRating b 
        on 
            a.user_id = b.user_id
        group by 
            a.name
    ) c
),
movie_cte as (
    select 
        title,
        dense_rank() over (order by avg_rating desc, title asc) as ranks
    from (
        select 
            a.title,
            avg(b.rating) as avg_rating
        from 
            Movies a 
        inner join 
            MovieRating b
        on 
            a.movie_id = b.movie_id
        where
            year(b.created_at) = 2020 and month(b.created_at) = 02
        group by 
            a.title
    ) c
) 
select 
    name as results
from 
    base 
where 
    ranks = 1
union all
select 
    title as results
from 
    movie_cte
where 
    ranks = 1