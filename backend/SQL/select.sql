select * FROM genres;
select * FROM movies;
select * FROM movie_genres;

select * FROM games;

select * FROM reviews;


SELECT
    g.id AS game_id,
    g.date,
    g.game_name,
    m.id AS movie_id,
    m.name,
    -- add more movie columns as needed, e.g. m.release_year, m.genre, etc.
    r.id AS review_id,
    r.author,
    r.suggested_by,
    r.hint_number,
    r.review_link,
    r.review_text
FROM games g
JOIN movies m ON g.movie_id = m.id
LEFT JOIN reviews r ON r.game_id = g.id
WHERE g.date = '2025-07-22'  -- replace with your target date
  AND g.game_name = 'reviewdle';  -- replace with your target game_name


  SELECT
  g.id AS game_id,
  g.date,
  g.game_name,
m.release_year as movie_release_year,
  m.id AS movie_id,
  m.name AS movie_name,
  -- Aggregate review fields into arrays

to_json(ARRAY_AGG(
  DISTINCT jsonb_build_object(
    'id', r.id,
    'hint_number', r.hint_number,
    'review_link', r.review_link,
    'review_text', r.review_text,
    'review_author', r.author,
    'review_suggester', r.suggested_by
  )
)
) AS reviews,
   to_json( ARRAY_AGG(DISTINCT gen.name) FILTER (WHERE gen.name IS NOT NULL)) AS genres

FROM games g
JOIN movies m ON g.movie_id = m.id
LEFT JOIN reviews r ON r.game_id = g.id
LEFT JOIN movie_genres mg ON mg.movie_id = m.id
LEFT JOIN genres gen ON gen.id = mg.genre_id

WHERE g.date = '2025-07-22' AND g.game_name = 'reviewdle'
GROUP BY g.id, m.id





SELECT get_game_details('2025-07-22', 'reviewdle');

SELECT * FROM games WHERE date='2025-08-11' and game_name='reviewdle'
