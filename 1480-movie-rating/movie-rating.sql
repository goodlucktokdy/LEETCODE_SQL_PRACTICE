# Write your MySQL query statement below
with names_cte as (
    select 
        user_id,
        name,
        dense_rank() over (order by cnts desc, name asc) as ranks
    from (
        select 
            a.user_id,
            a.name,
            count(distinct movie_id) as cnts
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
movie_cte as (
    select 
        movie_id,
        title,
        dense_rank() over (order by avg_rating desc, title asc) as ranks
    from (
        select 
            a.movie_id,
            a.title,
            avg(b.rating) as avg_rating
        from 
            MovieRating b
        inner join 
            Movies a 
        on 
            a.movie_id = b.movie_id and year(b.created_at) = 2020 and month(b.created_at) = 2
        group by 
            a.movie_id, a.title
    ) a
)
select 
    name as results
from 
    names_cte
where 
    ranks = 1
union all
select 
    title
from
    movie_cte
where 
    ranks = 1
