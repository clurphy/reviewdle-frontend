CREATE OR REPLACE FUNCTION get_game_details(game_dateValue DATE, game_nameValue TEXT)
RETURNS JSON AS $$
BEGIN
  RETURN (
    SELECT to_json(result)
    FROM (
      SELECT
        g.id AS game_id,
        g.date,
        g.game_name,
        m.release_date AS movie_release_date,
        m.id AS movie_id,
        m.title AS movie_title,
        to_json(ARRAY_AGG(
          DISTINCT jsonb_build_object(
            'id', r.id,
            'hint_number', r.hint_number,
            'review_link', r.review_link,
            'review_text', r.review_text,
            'review_author', r.author,
            'review_suggester', r.suggested_by
          )
        )) AS reviews,
        to_json(ARRAY_AGG(DISTINCT gen.name) FILTER (WHERE gen.name IS NOT NULL)) AS genres
      FROM games g
      JOIN movies m ON g.movie_id = m.id
      LEFT JOIN reviews r ON r.game_id = g.id
      LEFT JOIN movie_genres mg ON mg.movie_id = m.id
      LEFT JOIN genres gen ON gen.id = mg.genre_id
      WHERE g.date = game_dateValue AND g.game_name = game_nameValue
      GROUP BY g.id, m.id
    ) result
  );
END;
$$ LANGUAGE plpgsql;

SELECT get_game_details('2025-07-31', 'reviewdle');