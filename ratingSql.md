<!-- CREATE TABLE rating -->
CREATE TABLE IF NOT EXISTS rating (
    id SERIAL PRIMARY KEY,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    resep_id INT NOT NULL,
    FOREIGN KEY (resep_id) REFERENCES resep(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

<!-- GET rating by user_id dan resep_id -->
SELECT * FROM rating where user_id = :user_id AND resep_id = :resep_id;

<!-- UPDATE rating -->
UPDATE rating SET rating = :rating WHERE user_id = :user_id AND resep_id = :resep_id;

<!-- INSERT rating -->
INSERT INTO rating (user_id, resep_id, rating) VALUES (:user_id, :resep_id, :rating);