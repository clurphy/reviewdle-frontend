DROP TABLE reviews;

CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    movie_id INT REFERENCES movies(id) ON DELETE CASCADE,
    game_id INT REFERENCES games(id) ON DELETE CASCADE,  
    author TEXT,
    suggested_by TEXT,
    hint_number INT,
    review_link TEXT,
    review_text TEXT,
    UNIQUE (game_id, hint_number)
);
