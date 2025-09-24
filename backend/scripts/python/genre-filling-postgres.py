import requests
import psycopg2


api_key = 'b799563fa225299d3ee71253d8c6fd74'
genre_url = f"https://api.themoviedb.org/3/genre/movie/list?api_key={api_key}&language=en-US"


conn = psycopg2.connect(
    host="localhost",
    dbname="reviewdle-prisma",
    user="postgres",
    password="password",
    port=5433
)
cursor = conn.cursor()


response = requests.get(genre_url)
if response.status_code == 200:
    genres = response.json().get('genres', [])
    for genre in genres:
        genre_id = genre['id']
        name = genre['name']

        cursor.execute("""
            INSERT INTO genres (id, name)
            VALUES (%s, %s)
            ON CONFLICT (id) DO NOTHING;
        """, (genre_id, name))

    conn.commit()
    print(f"Inserted {len(genres)} genres.")
else:
    print(f"Failed to fetch genres: {response.status_code} - {response.text}")

# --- Cleanup ---
cursor.close()
conn.close()
