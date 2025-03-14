SELECT DATE(ft.transaction_date) AS transaction_day, 
       SUM(ft.amount) AS daily_sales, 
       COUNT(ft.transaction_id) AS transaction_count
FROM financial_transactions ft
WHERE ft.transaction_type = 'PURCHASE'
GROUP BY transaction_day
ORDER BY transaction_day DESC;
