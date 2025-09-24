SELECT 
    m.id,
    m.name,
    m.release_year,
    m.oscar_winner,
    ARRAY_AGG(g.name) AS genres
  FROM movies m
  JOIN movie_genres mg ON m.id = mg.movie_id
  JOIN genres g ON mg.genre_id = g.id
  GROUP BY m.id


  UPDATE games
SET movie_id = 38
WHERE id = 13;