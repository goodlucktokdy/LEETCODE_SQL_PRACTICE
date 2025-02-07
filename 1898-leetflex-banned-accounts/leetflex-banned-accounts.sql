# Write your MySQL query statement below
select 
    distinct 
    account_id
from (
    select 
        a.account_id,
        a.ip_address,
        a.login,
        a.logout
    from 
        LogInfo a 
    inner join 
        LogInfo b 
    on 
        a.account_id = b.account_id and a.ip_address != b.ip_address and
        (a.login <= b.login and b.login <= a.logout)
) a 
