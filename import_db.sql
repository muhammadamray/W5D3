DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL
);

INSERT INTO
    users (fname, lname)
VALUES
    ('John', 'Doe'),
    ('Jane', 'Doe'),
    ('Bob', 'Smith'),
    ('Alice', 'Smith');

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,
    FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
    questions (
        title,
        body,
        author_id
    )
VALUES
    (
        'What is a foreign key?',
        'I am having trouble understanding what a foreign key is. Can someone help?',
        (
            SELECT
                id
            FROM
                users
            WHERE
                fname = 'John'
                AND lname = 'Doe'
        )
    ),
    (
        'What is a primary key?',
        'I am having trouble understanding what a primary key is. Can someone help?',
        (
            SELECT
                id
            FROM
                users
            WHERE
                fname = 'John'
                AND lname = 'Doe'
        )
    ),
    (
        'What is a table?',
        'I am having trouble understanding what a table is. Can someone help?',
        (
            SELECT
                id
            FROM
                users
            WHERE
                fname = 'Bob'
                AND lname = 'Smith'
        )
    ),
    (
        'What is a database?',
        'I am having trouble understanding what a database is. Can someone help?',
        (
            SELECT
                id
            FROM
                users
            WHERE
                fname = 'Alice'
                AND lname = 'Smith'
        )
    );

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    author_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY (author_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
    question_follows (author_id, question_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                users
            WHERE
                fname = 'John'
                AND lname = 'Doe'
        ),
        (
            SELECT
                id
            FROM
                questions
            WHERE
                title = 'What is a foreign key?'
        )
    ),
    (
        (
            SELECT
                id
            FROM
                users
            WHERE
                fname = 'John'
                AND lname = 'Doe'
        ),
        (
            SELECT
                id
            FROM
                questions
            WHERE
                title = 'What is a primary key?'
        )
    ),
    (
        (
            SELECT
                id
            FROM
                users
            WHERE
                fname = 'Bob'
                AND lname = 'Smith'
        ),
        (
            SELECT
                id
            FROM
                questions
            WHERE
                title = 'What is a table?'
        )
    ),
    (
        (
            SELECT
                id
            FROM
                users
            WHERE
                fname = 'Alice'
                AND lname = 'Smith'
        ),
        (
            SELECT
                id
            FROM
                questions
            WHERE
                title = 'What is a database?'
        )
    );

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    parent_id INTEGER,
    question_id INTEGER NOT NULL,
    FOREIGN KEY (parent_id) REFERENCES replies(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
    replies (body, parent_id, question_id)
VALUES
    (
        'I am having trouble understanding what a foreign key is. Can someone help?',
        NULL,
        (
            SELECT
                id
            FROM
                questions
            WHERE
                title = 'What is a database?'
        )
    ),
    (
        (
            'A foreign key is a column or group of columns in a relational database table that provides a link between data in two tables. It acts as a cross-reference between tables because it references the primary key of another table, thereby establishing a link between them.'
        ),
        (
            SELECT
                id
            FROM
                replies
            WHERE
                body = 'I am having trouble understanding what a foreign key is. Can someone help?'
        ),
        (
            SELECT
                id
            FROM
                questions
            WHERE
                title = 'What is a foreign key?'
        )
    );

DROP TABLE IF EXISTS questions_likes;

CREATE TABLE questions_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
    questions_likes (user_id, question_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                users
            WHERE
                fname = 'John'
                AND lname = 'Doe'
        ),
        (
            SELECT
                id
            FROM
                questions
            WHERE
                title = 'What is a foreign key?'
        )
    ),
    (
        (
            SELECT
                id
            FROM
                users
            WHERE
                fname = 'John'
                AND lname = 'Doe'
        ),
        (
            SELECT
                id
            FROM
                questions
            WHERE
                title = 'What is a primary key?'
        )
    ),
    (
        (
            SELECT
                id
            FROM
                users
            WHERE
                fname = 'Bob'
                AND lname = 'Smith'
        ),
        (
            SELECT
                id
            FROM
                questions
            WHERE
                title = 'What is a table?'
        )
    ),
    (
        (
            SELECT
                id
            FROM
                users
            WHERE
                fname = 'Alice'
                AND lname = 'Smith'
        ),
        (
            SELECT
                id
            FROM
                questions
            WHERE
                title = 'What is a database?'
        )
    );
