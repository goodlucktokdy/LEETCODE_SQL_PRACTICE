# Write your MySQL query statement below
with t1 as 
        (select student, (case 
            when id = (select max(id) from Seat) and (select max(id) from Seat) % 2 = 1 then id
            when id % 2 = 0 then id - 1
            when id % 2 = 1 then id + 1
            else id end) id
    from Seat
    order by id
        )
select id, student from t1

       