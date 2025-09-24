DROP TABLE games;
CREATE TABLE games (
    id SERIAL PRIMARY KEY,
    movie_id INT REFERENCES movies(id) ON DELETE CASCADE,
    date DATE,
    game_name TEXT,
    UNIQUE (date, game_name) -- ensures no duplicate date for the same game_name
);

