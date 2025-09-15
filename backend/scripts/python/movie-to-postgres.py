import requests
import psycopg2
from psycopg2.extras import execute_values

# API endpoint and key
api_key = 'b799563fa225299d3ee71253d8c6fd74'
base_url = 'https://api.themoviedb.org/3/discover/movie'
language = 'en-US'


# DB connection info
conn = psycopg2.connect(
    host="localhost",
    dbname="reviewdle-prisma",
    user="postgres",
    password="password",
    port=5433
)
cursor = conn.cursor()

for page in range(1, 499):
    params = {
        'api_key': api_key,
        'language': language,
        'page': page
    }

    response = requests.get(base_url, params=params)
    data = response.json()

    if response.status_code == 200 and 'results' in data:
        movies_to_insert = []
        movie_genres_to_insert = []

        for movie in data['results']:
            tmdb_id = movie['id']
            title = movie['title']
            original_title = movie.get('original_title')
            release_date = movie.get('release_date') or None
            original_language = movie.get('original_language')
            poster_path = movie.get('poster_path')
            full_poster_url = f"https://image.tmdb.org/t/p/w500/{poster_path}" if poster_path else None
            genre_ids = movie.get('genre_ids', [])

            movies_to_insert.append((
                tmdb_id, title, original_title, release_date, original_language, full_poster_url
            ))

            for genre_id in genre_ids:
                movie_genres_to_insert.append((tmdb_id, genre_id))

        try:
            execute_values(cursor, """
                INSERT INTO movies (id, title, original_title, release_date, original_language, poster_path)
                VALUES %s
                ON CONFLICT (id) DO NOTHING
            """, movies_to_insert)
        except Exception as e:
            print(f"Skipping movies insert on page {page} due to error: {e}")

        try:
            if movie_genres_to_insert:
                execute_values(cursor, """
                    INSERT INTO "_GenreToMovie" ("B", "A")
                    VALUES %s
                    ON CONFLICT DO NOTHING
                """, movie_genres_to_insert)
        except Exception as e:
            print(f"Skipping movie_genres insert on page {page} due to error: {e}")

        conn.commit()
        print(f"Inserted page {page} with {len(movies_to_insert)} movies")
    else:
        print(f"Failed to retrieve data for page {page}. Status code: {response.status_code}")

cursor.close()
conn.close()