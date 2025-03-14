INSERT INTO financial_transactions_2025_01 (user_id, vendor_id, transaction_type, amount, currency, transaction_date, details) VALUES
(@user1, NULL, 'DEPOSIT', 1000.00, 'USD', '2025-01-10', '{"method": "Bank Transfer"}');

INSERT INTO financial_transactions_2025_02 (user_id, vendor_id, transaction_type, amount, currency, transaction_date, details) VALUES
(@user2, @vendor1, 'PURCHASE', 250.50, 'USD', '2025-02-05', '{"item": "Laptop"}');
