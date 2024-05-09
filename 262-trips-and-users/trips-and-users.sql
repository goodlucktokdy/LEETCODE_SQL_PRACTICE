with t1 as
    (select a.id, a.status, a.request_at,
            b.banned as client_ban, c.banned as driver_ban
        from Trips a
        inner join
        Users b
        on a.client_id = b.users_id
        inner join
        Users c
        on a.driver_id = c.users_id
        where b.banned = 'No' and c.banned = 'No'
    ),
t2 as (select request_at Day,
                round((count(case when status != 'completed' then id end)/count(id)),2) 'Cancellation Rate'
                from t1
            where request_at between date('2013-10-01') and date('2013-10-03')
            group by request_at
)
select * from t2
