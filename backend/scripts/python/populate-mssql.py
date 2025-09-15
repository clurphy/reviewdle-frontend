import requests
import pyodbc

# -----------------------------
# Connection settings
# -----------------------------
conn_str = (
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=localhost;"
    "DATABASE=Reviewdle;"
    "Trusted_Connection=yes;"
)

api_key = 'b799563fa225299d3ee71253d8c6fd74'
language = 'en-US'
base_url_movies = 'https://api.themoviedb.org/3/discover/movie'
base_url_genres = 'https://api.themoviedb.org/3/genre/movie/list'

# -----------------------------
# Connect to SQL Server
# -----------------------------
try:
    conn = pyodbc.connect(conn_str)
    cursor = conn.cursor()
    print("Connected successfully!")
except pyodbc.Error as e:
    print("Connection error:", e)
    exit(1)

# -----------------------------
# Helper functions
# -----------------------------
def insert_many(table_name, columns, rows):
    """Insert multiple rows, skipping duplicates."""
    if not rows:
        return
    placeholders = ', '.join(['?'] * len(columns))
    columns_str = ', '.join(columns)
    sql = f"INSERT INTO {table_name} ({columns_str}) VALUES ({placeholders})"
    for row in rows:
        try:
            cursor.execute(sql, row)
        except pyodbc.IntegrityError:
            # Duplicate primary/unique key, ignore
            continue
        except pyodbc.Error as e:
            print(f"Error inserting into {table_name}: {e}")
    conn.commit()

def safe_execute(sql, params):
    """Execute a single insert/update and skip on IntegrityError"""
    try:
        cursor.execute(sql, params)
        conn.commit()
    except pyodbc.IntegrityError:
        # Skip duplicates
        print(cursor.fetchone()[0])
        print("integrity error")

    except pyodbc.Error as e:
        print(f"Error executing SQL: {e}")
    except Exception as e:
        print(f"Error executing SQL: {e}")

def get_genre_mapping():
    # Fetch TMDb genres
    params = {'api_key': api_key, 'language': language}
    response = requests.get(base_url_genres, params=params)
    response.raise_for_status()
    genres_data = response.json()['genres']

    # Insert genres and return TMDbId -> internal Id mapping
    for genre in genres_data:
        safe_execute("""
            IF NOT EXISTS (SELECT 1 FROM Genres WHERE TmdbId = ?)
            INSERT INTO Genres (TmdbId, Name) VALUES (?, ?)
        """, (genre['id'], genre['id'], genre['name']))

    # Create mapping of TMDb genre ID -> internal Genre Id
    cursor.execute("SELECT Id, TmdbId FROM Genres")
    mapping = {tmdb_id: internal_id for internal_id, tmdb_id in cursor.fetchall()}
    return mapping

# -----------------------------
# Map TMDb genre IDs to internal IDs
# -----------------------------
genre_mapping = get_genre_mapping()

# -----------------------------
# Fetch and insert movies
# -----------------------------
for page in range(1, 499):
    params = {'api_key': api_key, 'language': language, 'page': page}
    response = requests.get(base_url_movies, params=params)
    if response.status_code != 200:
        print(f"Failed to retrieve data for page {page}. Status: {response.status_code}")
        continue

    data = response.json()
    if 'results' not in data:
        print(f"No results for page {page}")
        continue

    movie_genres_to_insert = []
    for movie in data['results']:
        if not movie.get("release_date"):
            print(f"Skipping movie {movie['title']} due to missing release date")
            continue
        if not movie.get("poster_path"):
            print(movie)
            print(f"Skipping movie {movie['poster_path']} due to missing poster")
            continue
        tmdb_id = movie['id']
        title = movie['title']
        original_title = movie.get('original_title')
        release_date = movie.get('release_date') or None
        original_language = movie.get('original_language')
        poster_path = movie.get('poster_path')
        full_poster_url = f"https://image.tmdb.org/t/p/w500/{poster_path}" if poster_path else None
        genre_ids = movie.get('genre_ids', [])

        # Insert movie safely
        safe_execute("""
            IF NOT EXISTS (SELECT 1 FROM Movies WHERE TmdbId = ?)
            INSERT INTO Movies (TmdbId, Title, OriginalTitle, ReleaseDate, OriginalLanguage, Poster)
            VALUES (?, ?, ?, ?, ?, ?)
        """, (tmdb_id, tmdb_id, title, original_title, release_date, original_language, full_poster_url))

        # Get internal Movie Id
        cursor.execute("SELECT Id FROM Movies WHERE TmdbId = ?", tmdb_id)
        movie_db_id = cursor.fetchone()[0]

        # Map TMDb genre IDs to internal Genre Ids
        for tmdb_genre_id in genre_ids:
            internal_genre_id = genre_mapping.get(tmdb_genre_id)
            if internal_genre_id:
                movie_genres_to_insert.append((movie_db_id, internal_genre_id))

    # Insert movie-genre relations
    insert_many(
        table_name='GenreMovie',
        columns=['MoviesId', 'GenresId'],
        rows=movie_genres_to_insert
    )

    print(f"Inserted page {page} with {len(movie_genres_to_insert)} movie-genre links")

# -----------------------------
# Close connection
# -----------------------------
cursor.close()
conn.close()
