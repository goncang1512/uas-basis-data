<!-- CREATE TABLE comment -->
CREATE TABLE IF NOT EXISTS comment (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    resep_id INT NOT NULL,
    FOREIGN KEY (resep_id) REFERENCES resep(id) ON DELETE CASCADE,
    comment VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

<!-- INSER comment -->
INSERT INTO comment 
    (user_id, resep_id, comment)
    VALUES 
    (:user_id, :resep_id, :comment);

<!-- GET comment by resep_id -->
SELECT
    c.id,
    c.user_id,
    c.comment,
    c.created_at,
    u.username,
    u.avatar
    FROM comment c
    INNER JOIN users u ON u.id = c.user_id
    INNER JOIN resep rON r.id = c.resep_id
    WHERE c.resep_id = :resep_id
    ORDER BY c.updated_at DESC;

<!-- DELETE comment -->
DELETE FROM comment WHERE id = :comment_id;