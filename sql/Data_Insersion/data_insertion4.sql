-- Create fixed UUIDs for users and vendors
SET @user1 = UUID();
SET @user2 = UUID();
SET @user3 = UUID();

SET @vendor1 = UUID();
SET @vendor2 = UUID();
SET @vendor3 = UUID();

-- Insert Users
INSERT INTO users (user_id, username, email, password_hash, role) VALUES
(@user1, 'john_doe', 'john@example.com', 'hashed_password', 'CUSTOMER'),
(@user2, 'alice_smith', 'alice@example.com', 'hashed_password', 'MERCHANT'),
(@user3, 'bob_jones', 'bob@example.com', 'hashed_password', 'ADMIN');

-- Insert Vendors
INSERT INTO vendors (vendor_id, name) VALUES
(@vendor1, 'Amazon'),
(@vendor2, 'Apple'),
(@vendor3, 'Google');



-- Insert Market Data
INSERT INTO market_data (asset_symbol, price) VALUES
('AAPL', 180.25),
('GOOGL', 2725.50),
('BTC', 65000.75);

-- Insert Financial Products
INSERT INTO financial_products (name, description, fee_structure) VALUES
('Premium Savings Account', 'High interest rate savings account', '{"monthly_fee": 5.00}'),
('Gold Credit Card', 'Exclusive credit card with cashback', '{"annual_fee": 99.99}');

-- Insert Audit Logs
INSERT INTO audit_logs (user_id, action, details) VALUES
(@user1, 'LOGIN', 'User logged in from IP 192.168.1.1'),
(@user2, 'UPDATE_PROFILE', 'Changed email address');
