WITH transaction_stats AS (
    SELECT AVG(amount) AS avg_amount, 
           STDDEV(amount) AS stddev_amount
    FROM financial_transactions
)
SELECT ft.transaction_id, 
       ft.user_id, 
       ft.amount, 
       ft.transaction_date
FROM financial_transactions ft, transaction_stats ts
WHERE ft.amount > (ts.avg_amount + 3 * ts.stddev_amount)
ORDER BY ft.amount DESC;
