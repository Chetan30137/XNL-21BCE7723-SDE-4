SELECT v.name AS vendor_name, 
       COUNT(ft.transaction_id) AS total_transactions,
       SUM(ft.amount) AS total_sales
FROM financial_transactions ft
JOIN vendors v ON ft.vendor_id = v.vendor_id
WHERE ft.transaction_type = 'PURCHASE'
GROUP BY v.name
ORDER BY total_sales DESC
LIMIT 10;
