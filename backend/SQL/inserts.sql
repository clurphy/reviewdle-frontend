-- Insert genres
INSERT INTO genres (name) VALUES ('Drama'), ('Action'), ('Comedy'), ('Sci-Fi')
ON CONFLICT (name) DO NOTHING;

INSERT INTO genres (name) VALUES ('Romance'), ('Musical');


INSERT INTO movies (name, release_year, oscar_winner)
VALUES ('The Matrix', 1999, TRUE);


INSERT INTO movies (name, release_year, oscar_winner)
VALUES ('Inception', 2008, FALSE);


INSERT INTO movies (name, release_year, oscar_winner)
VALUES ('Interstellar', 2014, FALSE);



INSERT INTO movies (name, release_year, oscar_winner)
VALUES ('Eternal Sunshine of the Spotless Mind', 2004, FALSE);



INSERT INTO movie_genres (movie_id, genre_id)
VALUES
  (3, 13), 
  (3, 8); 


  INSERT INTO movie_genres (movie_id, genre_id)
VALUES
  (4, 13), 
  (4, 8); 


  INSERT INTO movie_genres (movie_id, genre_id)
VALUES
  (5, 13), 
  (5, 8); 

  INSERT INTO movie_genres (movie_id, genre_id)
VALUES
  (6, 13), 
  (6, 14), 
  (6, 7); 

INSERT INTO games (movie_id, date, game_name) 
VALUES (3, '2025-07-21', 'reviewdle');

INSERT INTO games (movie_id, date, game_name) 
VALUES (4, '2025-07-22', 'reviewdle');

INSERT INTO reviews(movie_id, game_id , author, suggested_by, hint_number, review_link, review_text) VALUES (4,3, 'anon', 'admin', 1, 'https://letterboxd.com/jay/film/inception/1/', 'living in your head rent free' );
INSERT INTO reviews(movie_id, game_id , author, suggested_by, hint_number, review_link, review_text) VALUES (4,3, 'anon', 'admin', 2, 'https://letterboxd.com/sammeltzer/film/inception/', 'Def made for 14 year old boys but also makes you feel like a 14 year old when watching it and that’s kind of joyous.' );
INSERT INTO reviews(movie_id, game_id , author, suggested_by, hint_number, review_link, review_text) VALUES (4,3, 'anon', 'admin', 4, 'https://letterboxd.com/jay/film/inception/1/', 'bro what if ❓the only way to get out 🚷 of the dream 💤,, was to 😳 kiss 💋 but you were a projection 😱' );
INSERT INTO reviews(movie_id, game_id , author, suggested_by, hint_number, review_link, review_text) VALUES (4,3, 'anon', 'admin', 3, 'https://letterboxd.com/jay/film/inception/1/', 'It’s strange for such a good movie to have such bad dialogue' );
INSERT INTO reviews(movie_id, game_id , author, suggested_by, hint_number, review_link, review_text) VALUES (4,3, 'anon', 'admin', 5, 'https://letterboxd.com/cathyk/film/inception/1/','cillian murphy: no dad i''m giving up on YOUR dream!' );



