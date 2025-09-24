SELECT datname FROM pg_database;
SELECT table_name FROM information_schema.tables WHERE table_schema='public';

select * FROM "_GenreToMovie";
select * FROM movies;
select * from genres

select * from games

INSERT INTO "_genresTomovies" ("A", "B") VALUES (28, 755898) ON CONFLICT DO NOTHING;
