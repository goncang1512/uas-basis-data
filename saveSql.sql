<!-- CREATE TABLE save -->
CREATE TABLE IF NOT EXISTS saves (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    resep_id INT NOT NULL,
    FOREIGN KEY (resep_id) REFERENCES resep(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

<!-- INSERT save -->
INSERT INTO saves (user_id, resep_id) VALUES (:user_id, :resep_id);

<!-- GET save by user_id -->
SELECT * FROM saves WHERE user_id = :user_id;

<!-- GET save by user_id dan resep_id -->
SELECT * FROM saves WHERE user_id = :user_id AND resep_id = :resep_id;

<!-- DELETE save -->
DELETE FROM saves WHERE id = :save_id;

<!-- GET one data -->
SELECT * FROM saves WHERE id = :id;

<!-- GET save with JOIN -->
SELECT s.id AS save_id, 
    r.id AS resep_id, 
    r.judul, 
    r.gambar, 
    r.slug, 
    r.user_id AS make_id, 
    u.username, 
    u.email, 
    u.avatar,
    COALESCE(SUM(rating.rating), 0) AS total_rating,
    COUNT(rating.id) AS jumlah_rating
    FROM saves s
    JOIN users u ON u.id = s.user_id
    JOIN resep r ON r.id = s.resep_id
    LEFT JOIN rating ON rating.resep_id = r.id
    WHERE s.user_id = :user_id
    GROUP BY s.id, r.id, r.judul, r.gambar, r.slug, u.id, u.username, u.email
    ORDER BY r.updated_at DESC;