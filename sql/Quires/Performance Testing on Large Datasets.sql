INSERT INTO financial_transactions (user_id, vendor_id, transaction_type, amount, currency, transaction_date, details)
SELECT 
    (SELECT user_id FROM users ORDER BY RAND() LIMIT 1),
    (SELECT vendor_id FROM vendors ORDER BY RAND() LIMIT 1),
    'PURCHASE',
    ROUND(RAND() * 500 + 50, 2),  -- Random amount between 50-550
    'USD',
    DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365) DAY),  -- Random past date within a year
    '{"generated": "true"}'
FROM information_schema.tables 
LIMIT 100000;  -- Insert 100K rows
