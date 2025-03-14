EXPLAIN ANALYZE 
SELECT v.name, COUNT(ft.transaction_id), SUM(ft.amount)
FROM financial_transactions ft
JOIN vendors v ON ft.vendor_id = v.vendor_id
WHERE ft.transaction_type = 'PURCHASE'
GROUP BY v.name
ORDER BY SUM(ft.amount) DESC
LIMIT 10;
