DROP TABLE movies;

CREATE TABLE movies (
    id INTEGER PRIMARY KEY,  -- TMDb ID
    title TEXT NOT NULL,
    original_title TEXT,
    release_date DATE NOT NULL,
    original_language TEXT,
    poster_path TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

