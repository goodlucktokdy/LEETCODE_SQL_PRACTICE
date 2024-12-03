select
    distinct
    a.email
from
    Person a
inner join
    Person b
on
    a.id != b.id and a.email = b.email