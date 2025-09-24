CREATE OR REPLACE FUNCTION get_game_details(game_dateValue DATE, game_nameValue TEXT)
RETURNS JSON AS $$
BEGIN
  RETURN (
    SELECT to_json(result)
    FROM (
      SELECT
        g.id AS game_id,
        g.date,
      FROM games g
      WHERE g.date = game_dateValue AND g.game_name = game_nameValue
      GROUP BY g.id, m.id
    ) result
  );
END;
$$ LANGUAGE plpgsql;

SELECT get_game_details('2025-07-31', 'reviewdle');