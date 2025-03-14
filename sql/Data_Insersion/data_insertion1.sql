-- INSERT SAMPLE DATA INTO USERS TABLE
INSERT INTO users (user_id, username, email, password_hash, role) VALUES
(UUID(), 'john_doe', 'john@example.com', 'hashed_password', 'CUSTOMER'),
(UUID(), 'alice_smith', 'alice@example.com', 'hashed_password', 'MERCHANT'),
(UUID(), 'bob_jones', 'bob@example.com', 'hashed_password', 'ADMIN');