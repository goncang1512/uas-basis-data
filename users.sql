<!-- Create Tabel -->
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    avatar VARCHAR(255),
    role VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

<!-- Create User -->
INSERT INTO users 
    (username, email, password, avatar, role) 
    VALUES 
    (:username, :email, :password, :avatar, :role);

<!-- Get One user -->
SELECT 
    username, 
    email 
    FROM users 
    WHERE username = :username OR email = :email;

<!-- GET by email -->
SELECT * FROM users WHERE email = :email;