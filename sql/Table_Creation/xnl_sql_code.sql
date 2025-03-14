-- USERS Table
CREATE TABLE users (
    user_id CHAR(36) NOT NULL DEFAULT (UUID()),
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    role ENUM('CUSTOMER', 'ADMIN', 'MERCHANT') NOT NULL DEFAULT 'CUSTOMER',
    PRIMARY KEY (user_id)
);

-- VENDORS Table
CREATE TABLE vendors (
    vendor_id CHAR(36) NOT NULL DEFAULT (UUID()),
    name VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (vendor_id)
);

-- FINANCIAL TRANSACTIONS Table
CREATE TABLE financial_transactions (
    transaction_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id CHAR(36) NOT NULL,
    vendor_id CHAR(36) NULL,
    transaction_type ENUM('DEPOSIT', 'WITHDRAWAL', 'PURCHASE', 'REFUND') NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(10) NOT NULL DEFAULT 'USD',
    transaction_date DATE NOT NULL,
    details JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_transaction_user (user_id),
    INDEX idx_transaction_date (transaction_date)
);



-- MARKET DATA Table
CREATE TABLE market_data (
    market_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    asset_symbol VARCHAR(10) NOT NULL,
    price DECIMAL(12,4) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (asset_symbol, timestamp)
);

-- FINANCIAL PRODUCTS Table
CREATE TABLE financial_products (
    product_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    fee_structure JSON NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- AUDIT LOGS Table
CREATE TABLE audit_logs (
    log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id CHAR(36) NOT NULL,
    action VARCHAR(255) NOT NULL,
    details TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_audit_logs_user (user_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- PARTITIONED FINANCIAL TRANSACTIONS TABLES
CREATE TABLE financial_transactions_2025_01 LIKE financial_transactions;
CREATE TABLE financial_transactions_2025_02 LIKE financial_transactions;

-- STORED PROCEDURE FOR INSERTING INTO PARTITIONED TABLES
DELIMITER //
CREATE PROCEDURE insert_into_transaction_partition(
    IN p_user_id CHAR(36), 
    IN p_vendor_id CHAR(36), 
    IN p_transaction_type ENUM('DEPOSIT', 'WITHDRAWAL', 'PURCHASE', 'REFUND'), 
    IN p_amount DECIMAL(10,2), 
    IN p_currency VARCHAR(10), 
    IN p_transaction_date DATE, 
    IN p_details JSON
)
BEGIN
    DECLARE partition_table VARCHAR(50);
    SET partition_table = CONCAT('financial_transactions_', DATE_FORMAT(p_transaction_date, '%Y_%m'));
    
    SET @sql = CONCAT(
        'INSERT INTO ', partition_table, 
        ' (user_id, vendor_id, transaction_type, amount, currency, transaction_date, details) VALUES (?, ?, ?, ?, ?, ?, ?)'
    );

    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @ p_user_id, @p_vendor_id, @p_transaction_type,@ p_amount,@ p_currency,@ p_transaction_date, @p_details;
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

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

-- Insert Financial Transactions (Ensure user/vendor consistency)
INSERT INTO financial_transactions (user_id, vendor_id, transaction_type, amount, currency, transaction_date, details) VALUES
(@user1, NULL, 'DEPOSIT', 1000.00, 'USD', '2025-01-10', '{"method": "Bank Transfer"}'),
(@user2, @vendor1, 'PURCHASE', 250.50, 'USD', '2025-01-15', '{"item": "Laptop"}'),
(@user3, @vendor2, 'REFUND', 75.00, 'USD', '2025-01-20', '{"reason": "Product defect"}');

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

CREATE TABLE financial_transactions_2025_02 LIKE financial_transactions;
CREATE TABLE financial_transactions_2025_02 LIKE financial_transactions;

INSERT INTO financial_transactions_2025_01 (user_id, vendor_id, transaction_type, amount, currency, transaction_date, details) VALUES
(@user1, NULL, 'DEPOSIT', 1000.00, 'USD', '2025-01-10', '{"method": "Bank Transfer"}');

INSERT INTO financial_transactions_2025_02 (user_id, vendor_id, transaction_type, amount, currency, transaction_date, details) VALUES
(@user2, @vendor1, 'PURCHASE', 250.50, 'USD', '2025-02-05', '{"item": "Laptop"}');


SELECT * FROM users;
SELECT * FROM vendors;
SELECT * FROM financial_transactions;
SELECT * FROM market_data;
SELECT * FROM financial_products;
SELECT * FROM audit_logs;
SELECT * FROM financial_transactions_2025_01;
SELECT * FROM financial_transactions_2025_02;

