INSERT INTO
    oauth_users (
        google_id,
        email,
        display_name,
        first_name,
        last_name,
        profile_photo
    )
VALUES (
        1,
        'cedlav@gmail.com',
        'cedl99',
        'ced',
        'Lav',
        'ok'
    )
RETURNING
    *


select * from oauth_users;