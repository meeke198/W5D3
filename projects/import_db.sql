PRAGMA foreign_keys = ON;


DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL  
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL, 
    FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    parent_reply_id INTEGER,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    liked BOOLEAN,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);


INSERT INTO 
    users (fname, lname)
VALUES 
    ('Hien', 'Nguyen'), 
    ('Maddie', 'Wilson'),
    ('Tony', 'Soprano');

INSERT INTO 
    questions (title, body, author_id)
VALUES 
    ('Hien''s Question', 'HOW2MASTERSQL', (SELECT id FROM users WHERE fname = 'Hien')),
    ('Maddie''s Question', 'when can i sleep', (SELECT id FROM users WHERE fname = 'Maddie')),
    ('Tony''s Question', 'WHEREDAMONEY', (SELECT id FROM users WHERE fname = 'Tony'));

INSERT INTO 
    replies (body, parent_reply_id, question_id, user_id)
VALUES 
    ('just keep swimming', 
    NULL, 
    (SELECT id FROM questions WHERE body = 'HOW2MASTERSQL'),
    (SELECT id FROM users WHERE fname = 'Hien')),
    
    ('never', 
    NULL, 
    (SELECT id FROM questions WHERE body = 'when can i sleep'),
    (SELECT id FROM users WHERE fname = 'Maddie')),

    ('that''s a joke', 
    (SELECT id FROM replies WHERE body = 'never'), 
    (SELECT id FROM questions WHERE body = 'when can i sleep'),
    (SELECT id FROM users WHERE fname = 'Maddie'));








-- --INSERT INTO 
-- -- plays (title, year, playwright_id)
-- --VALUES 
-- --  ('All My Sons', 1947, (SELECT ID FROM playwrights WHERE name = 'Arthur Miller'))