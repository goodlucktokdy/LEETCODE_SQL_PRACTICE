-- with base as (
--     select
--         a.account,
--         a.name,
--         b.amount
--     from 
--         Users a 
--     inner join
--         Transactions b
--     on
--         a.account = b.account
-- )
-- select
--     name,
--     sum(amount) as balance
-- from 
--     base
-- group by 
--     name
-- having
--     balance >= 10000
SELECT 
    DISTINCT a.name, b.balance
FROM 
    Users a
JOIN (
    SELECT 
        account, SUM(amount) as balance
    FROM 
        Transactions
    GROUP BY 1
    HAVING balance>10000) b
ON 
    a.account = b.account 