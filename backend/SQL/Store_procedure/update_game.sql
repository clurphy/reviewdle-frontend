CREATE OR REPLACE FUNCTION upsert_game_with_reviews(
    p_game_id INT,
    p_movie_id INT,
    p_date DATE,
    p_game_name TEXT,
    p_review_suggester TEXT,

    -- Review 1
    p1_hint_number INT,
    p1_review_link TEXT,
    p1_review_text TEXT,
    p1_review_author TEXT,
    -- Review 2
    p2_hint_number INT,
    p2_review_link TEXT,
    p2_review_text TEXT,
    p2_review_author TEXT,
    -- Review 3
    p3_hint_number INT,
    p3_review_link TEXT,
    p3_review_text TEXT,
    p3_review_author TEXT,
    -- Review 4
    p4_hint_number INT,
    p4_review_link TEXT,
    p4_review_text TEXT,
    p4_review_author TEXT,
    -- Review 5
    p5_hint_number INT,
    p5_review_link TEXT,
    p5_review_text TEXT,
    p5_review_author TEXT
)
RETURNS VOID AS $$
BEGIN
    -- 1. Update the game itself
    UPDATE games
    SET movie_id = p_movie_id,
        date = p_date,
        game_name = p_game_name
    WHERE id = p_game_id;

    -- 2. Upsert reviews
    INSERT INTO reviews (game_id, movie_id, hint_number, review_link, review_text, author, suggested_by)
    VALUES
      (p_game_id, p_movie_id, p1_hint_number, p1_review_link, p1_review_text, p1_review_author, p_review_suggester)
    ON CONFLICT (game_id, hint_number)
    DO UPDATE SET
      review_link = EXCLUDED.review_link,
      review_text = EXCLUDED.review_text,
      author = EXCLUDED.author,
      suggested_by = EXCLUDED.suggested_by;

    INSERT INTO reviews (game_id, movie_id, hint_number, review_link, review_text, author, suggested_by)
    VALUES
      (p_game_id, p_movie_id, p2_hint_number, p2_review_link, p2_review_text, p2_review_author, p_review_suggester)
    ON CONFLICT (game_id, hint_number)
    DO UPDATE SET
      review_link = EXCLUDED.review_link,
      review_text = EXCLUDED.review_text,
      author = EXCLUDED.author,
      suggested_by = EXCLUDED.suggested_by;

    INSERT INTO reviews (game_id, movie_id, hint_number, review_link, review_text, author, suggested_by)
    VALUES
      (p_game_id, p_movie_id, p3_hint_number, p3_review_link, p3_review_text, p3_review_author, p_review_suggester)
    ON CONFLICT (game_id, hint_number)
    DO UPDATE SET
      review_link = EXCLUDED.review_link,
      review_text = EXCLUDED.review_text,
      author = EXCLUDED.author,
      suggested_by = EXCLUDED.suggested_by;

    INSERT INTO reviews (game_id, movie_id, hint_number, review_link, review_text, author, suggested_by)
    VALUES
      (p_game_id, p_movie_id, p4_hint_number, p4_review_link, p4_review_text, p4_review_author, p_review_suggester)
    ON CONFLICT (game_id, hint_number)
    DO UPDATE SET
      review_link = EXCLUDED.review_link,
      review_text = EXCLUDED.review_text,
      author = EXCLUDED.author,
      suggested_by = EXCLUDED.suggested_by;

    INSERT INTO reviews (game_id, movie_id, hint_number, review_link, review_text, author, suggested_by)
    VALUES
      (p_game_id, p_movie_id, p5_hint_number, p5_review_link, p5_review_text, p5_review_author, p_review_suggester)
    ON CONFLICT (game_id, hint_number)
    DO UPDATE SET
      review_link = EXCLUDED.review_link,
      review_text = EXCLUDED.review_text,
      author = EXCLUDED.author,
      suggested_by = EXCLUDED.suggested_by;
END;
$$ LANGUAGE plpgsql;
