

INSERT INTO financial_transactions 
(user_id, vendor_id, transaction_type, amount, currency, transaction_date, details)
VALUES ('1823815e-00f7-11f0-8d96-4cd5775aa0c4','35dd606a-00f7-11f0-8d96-4cd5775aa0c4', 'DEPOSIT', 1000.00, 'USD', '2025-01-10', '{"method": "Bank Transfer"}'), 
('1822a299-00f7-11f0-8d96-4cd5775aa0c4', '35dd5d84-00f7-11f0-8d96-4cd5775aa0c4', 
 'PURCHASE', 250.50, 'USD', '2025-01-15', '{"item": "Laptop"}'),
 ('18239b71-00f7-11f0-8d96-4cd5775aa0c4','35dd3fc3-00f7-11f0-8d96-4cd5775aa0c4', 'REFUND', 75.00, 'USD', '2025-01-20', '{"reason": "Product defect"}');


