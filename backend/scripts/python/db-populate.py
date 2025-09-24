import pandas as pd
from pymongo import MongoClient
#mongodb://0.0.0.0:27017/reviewdle
# MongoDB connection details
mongo_uri = "mongodb://localhost:27017"  # Update with your MongoDB URI
database_name = "reviewdle"
collection_name = "movies"

# CSV file path
csv_file = "tmdb_popular_movie_titles.csv"  # Update with your CSV file path

# Connect to MongoDB
client = MongoClient(mongo_uri)
db = client[database_name]
collection = db[collection_name]

# Read CSV file into a pandas DataFrame
df = pd.read_csv(csv_file)

# Convert DataFrame to list of dictionaries
movies = df.to_dict(orient='records')

# Insert movie titles into MongoDB
if movies:
    collection.insert_many(movies)
    print(f"Inserted {len(movies)} movie titles into the MongoDB collection '{collection_name}'.")
else:
    print("No data found in the CSV file.")

# Close the MongoDB connection
client.close()
