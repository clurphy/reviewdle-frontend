import prisma from "../config/db";

export async function searchMovies(title: string) {
  const movies = await prisma.$queryRaw<
    { id: number; title: string }[]
  >`
    SELECT 
      CASE
        WHEN title_count > 1 THEN title || ' (' || EXTRACT(YEAR FROM release_date) || ')'
        ELSE title
      END AS title,
      id
    FROM (
      SELECT 
        title,
        id,
        release_date,
        COUNT(*) OVER (PARTITION BY title) AS title_count
      FROM movies
      WHERE title ILIKE '%' || ${title} || '%'
    ) sub
    ORDER BY
      CASE
        WHEN title ILIKE ${title} || '%' THEN 0
        ELSE 1
      END,
      LENGTH(title) ASC
    LIMIT 30;
  `;

  return movies;
}
