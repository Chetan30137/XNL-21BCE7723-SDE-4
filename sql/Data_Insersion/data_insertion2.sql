-- INSERT SAMPLE DATA INTO VENDORS TABLE
INSERT INTO vendors (vendor_id, name) VALUES
(UUID(), 'Amazon'),
(UUID(), 'Apple'),
(UUID(), 'Google');



-- INSERT SAMPLE DATA INTO MARKET DATA TABLE
INSERT INTO market_data (asset_symbol, price) VALUES
('AAPL', 180.25),
('GOOGL', 2725.50),
('BTC', 65000.75);

