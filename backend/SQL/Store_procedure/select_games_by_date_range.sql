CREATE OR REPLACE FUNCTION get_games_by_date_range(start_date DATE, end_date DATE)
RETURNS JSON AS $$
BEGIN
  RETURN (
    SELECT json_agg(result)
    FROM (
      SELECT
        g.id,
        g.date
      FROM games g
      WHERE g.date BETWEEN start_date AND end_date
      GROUP BY g.id
    ) result
  );
END;
$$ LANGUAGE plpgsql;
SELECT get_games_by_date_range('2025-07-20', '2025-07-23');
