<!-- CREATE table resep -->
CREATE TABLE IF NOT EXISTS  resep (
    id SERIAL PRIMARY KEY,
    judul VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL,
    deskripsi TEXT NOT NULL,
    bahan_bahan TEXT NOT NULL,
    langkah_langkah TEXT NOT NULL,
    waktu_persiapan VARCHAR(255) NOT NULL,
    waktu_memasak VARCHAR(255) NOT NULL,
    total_waktu VARCHAR(255) NOT NULL,
    porsi VARCHAR(255) NOT NULL,
    kesulitan VARCHAR(255) NOT NULL,
    asal_makanan VARCHAR(255) NOT NULL,
    kategori VARCHAR(255) NOT NULL,
    gambar VARCHAR(255) NOT NULL,
    gambar_id VARCHAR(255) NOT NULL,
    vidio VARCHAR(255),
    vidio_id VARCHAR(255),
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE);

<!-- GET resep dan urutkan berdasarkan created_at -->
SELECT * FROM resep ORDER BY created_at DESC;

<!-- GET resep by slug -->
SELECT * FROM resep WHERE slug = :id;

<!-- GET resep by id -->
SELECT * FROM resep WHERE id = :id;

<!-- GET resep by judul -->
SELECT * FROM resep WHERE judul = :title;

<!-- DELETE resep -->
DELETE FROM resep WHERE id = :id;

<!-- UPLOAD resep -->
INSERT INTO resep 
    (judul, slug, deskripsi, bahan_bahan, langkah_langkah, waktu_persiapan, waktu_memasak, total_waktu, porsi, kesulitan, asal_makanan, kategori, user_id, gambar, gambar_id, vidio, vidio_id)
    VALUES 
    (:judul, :slug, :deskripsi, :bahan_bahan, :langkah_langkah, :waktu_persiapan, :waktu_memasak, :total_waktu, :porsi, :kesulitan, :asal_makanan, :kategori,:user_id, :gambar, :gambar_id, :vidio, :vidio_id);

<!-- SEARCH resep by judul, kategori, asal_makanan -->
SELECT 
    r.id, 
    r.judul, 
    r.gambar, 
    r.slug, 
    r.user_id AS make_id,
    u.id AS user_id, 
    u.username, 
    u.email, 
    u.avatar,
    COALESCE(SUM(rating.rating), 0) AS total_rating,
    COUNT(rating.id) AS jumlah_rating
    FROM resep r
    LEFT JOIN rating ON rating.resep_id = r.id
    JOIN users u ON u.id = r.user_id
    WHERE judul ILIKE :pattern OR kategori ILIKE :pattern OR asal_makanan ILIKE :pattern
    GROUP BY r.id, r.judul, r.gambar, r.slug, u.id, u.username, u.email, u.avatar;

<!-- GET resep by user_id -->
SELECT 
    r.id, 
    r.judul, 
    r.gambar, 
    r.slug, 
    r.user_id AS make_id,
    u.id AS user_id, 
    u.username, 
    u.email, 
    u.avatar,
    COALESCE(SUM(rating.rating), 0) AS total_rating,
    COUNT(rating.id) AS jumlah_rating
    FROM resep r
    LEFT JOIN rating ON rating.resep_id = r.id
    JOIN users u ON u.id = r.user_id
    WHERE r.user_id = :user_id
    GROUP BY r.id, r.judul, r.gambar, r.slug, u.id, u.username, u.email, u.avatar
    ORDER BY r.updated_at DESC;

<!-- UPDATE resep -->
UPDATE resep SET
    judul = :judul,
    slug = :slug,
    deskripsi = :deskripsi,
    waktu_persiapan = :waktu_persiapan,
    waktu_memasak = :waktu_memasak,
    bahan_bahan = :bahan_bahan, 
    langkah_langkah = :langkah_langkah,
    total_waktu = :total_waktu,
    porsi = :porsi,
    kesulitan = :kesulitan,
    asal_makanan = :asal_makanan,
    kategori = :kategori
    WHERE id = :resep_id;

<!-- UPDATE data gambar resep -->
UPDATE resep SET gambar = :gambar, gambar_id = :gambar_id WHERE id = :resep_id;

<!-- UPDATE data vidio resep -->
UPDATE resep SET vidio = :vidio, vidio_id = :vidio_id WHERE id = :resep_id;