CREATE OR REPLACE FUNCTION get_games_by_date_range(start_date DATE, end_date DATE)
RETURNS JSON AS $$
BEGIN
  RETURN (
    SELECT json_agg(result)
    FROM (
      SELECT
        g.id AS id,
        g.date,
        json_build_object(
          'title', m.title
        ) AS movie
      FROM games g
      JOIN movies m ON m.id = g.movie_id
      WHERE g.date BETWEEN start_date AND end_date
      ORDER BY g.date
    ) result
  );
END;
$$ LANGUAGE plpgsql;

SELECT get_games_by_date_range ('2025-07-20', '2025-07-23');