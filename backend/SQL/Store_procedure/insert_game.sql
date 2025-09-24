CREATE OR REPLACE FUNCTION create_game_with_reviews2(
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
RETURNS INT AS $$
DECLARE
  v_game_id INT;
BEGIN
  -- Insert the game
  INSERT INTO games (movie_id, date, game_name)
  VALUES (p_movie_id, p_date, p_game_name)
  RETURNING id INTO v_game_id;

  -- Insert the 5 reviews
  INSERT INTO reviews (game_id, movie_id, hint_number, review_link, review_text, author, suggested_by)
  VALUES 
    (v_game_id, p_movie_id, p1_hint_number, p1_review_link, p1_review_text, p1_review_author, p_review_suggester),
    (v_game_id, p_movie_id, p2_hint_number, p2_review_link, p2_review_text, p2_review_author, p_review_suggester),
    (v_game_id, p_movie_id, p3_hint_number, p3_review_link, p3_review_text, p3_review_author, p_review_suggester),
    (v_game_id, p_movie_id, p4_hint_number, p4_review_link, p4_review_text, p4_review_author, p_review_suggester),
    (v_game_id, p_movie_id, p5_hint_number, p5_review_link, p5_review_text, p5_review_author, p_review_suggester);

  RETURN v_game_id;
END;
$$ LANGUAGE plpgsql;

SELECT create_game_with_reviews2 (
        5, '2025-07-23', 'reviewdle', 'admin', 1, 'link1', 'text1','author1', 2, 'link2', 'text2', 'author2', 3, 'link3', 'text3','author3', 4, 'link4', 'text4', 'author4',5, 'link15', 'text5', 'author5'
    );