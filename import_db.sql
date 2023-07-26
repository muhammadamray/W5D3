DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL
);


DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,
    FOREIGN KEY (author_id) REFERENCES users(id)
);


DROP TABLE IF EXISTS question_follows;
CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    author_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY (author_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);


DROP TABLE IF EXISTS replies;
CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    parent_id INTEGER,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (parent_id) REFERENCES replies(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);


DROP TABLE IF EXISTS question_likes;    
CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);





