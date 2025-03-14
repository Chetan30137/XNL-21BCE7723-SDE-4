CREATE INDEX idx_transaction_user ON financial_transactions(user_id);
CREATE INDEX idx_transaction_vendor ON financial_transactions(vendor_id);
CREATE INDEX idx_transaction_date ON financial_transactions(transaction_date);
