CREATE OR REPLACE FUNCTION get_game_details_by_id(game_id_value INT)
RETURNS JSON AS $$
BEGIN
  RETURN (
    SELECT to_json(result)
    FROM (
      SELECT
        g.id AS id,
        g.date ,
        g.game_name as name,

        -- 🆕 movie object with genres included inside
        jsonb_build_object(
          'id', m.id,
          'title', m.title,
          'poster', m.poster_path,
          'release_date', m.release_date,
          'genres', to_json(ARRAY_AGG(DISTINCT gen.name) FILTER (WHERE gen.name IS NOT NULL))
        ) AS movie,

        -- reviews remain outside the movie object
        to_json(ARRAY_AGG(
          DISTINCT jsonb_build_object(
            'id', r.id,
            'hint_number', r.hint_number,
            'review_link', r.review_link,
            'review_text', r.review_text,
            'review_author', r.author,
            'review_suggester', r.suggested_by
          )
        )) AS reviews

      FROM games g
      JOIN movies m ON g.movie_id = m.id
      LEFT JOIN reviews r ON r.game_id = g.id
      LEFT JOIN movie_genres mg ON mg.movie_id = m.id
      LEFT JOIN genres gen ON gen.id = mg.genre_id
      WHERE g.id = game_id_value
      GROUP BY g.id, m.id
    ) result
  );
END;
$$ LANGUAGE plpgsql;


SELECT get_game_details_by_id(12);